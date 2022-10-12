import 'dart:io' show File, HttpClientRequest, HttpClientResponse;
import 'dart:convert' show json;
import 'dart:typed_data' show Uint8List;
import './consolidateHttpClientResponseBytes.dart' show consolidateHttpClientResponseBytes;

import 'constants.dart';
import 'functions.dart';

// https://flutter.dev/docs/cookbook/persistence/reading-writing-files
// https://api.flutter.dev/flutter/dart-io/Directory-class.html

final File _cachedFileData = 
  File('${Constants.i.cacheDirectory.path}${Constants.i.pathSeparator}cachedFileData.json');

enum _OperationType{add, upDate}

class FileCaching {
  /// Classe resposável por armazenar, ler e excluir os arquivos em cache na mémoria 

  HttpClientRequest? _request;
  HttpClientResponse? _response;

  Uri? urlAddress; 
  String? fileName;
  File? fileAddress;

  /// Obter um arquivo em cache
  Future<File> getFile({required String url, Duration? fileDurationTime}) async {    
    assert(url.isNotEmpty, 'Insira o endereço da url');

    urlAddress = Uri.parse(url); 
    fileName = urlAddress!.pathSegments.last.split('/').last;
    fileAddress = File('${Constants.i.cacheDirectory.path}${Constants.i.pathSeparator}$fileName');

    if(fileAddress!.existsSync()){
      return fileAddress!;
    }else{
      return _getDataFromNetwork<File>(fileDurationTime);
    }

  }

  /// Obter a byteData um arquivo em cache
  Future<Uint8List> getBytesData({required String url, Duration? fileDurationTime}) async {
    assert(url.isNotEmpty, 'Insira o endereço da url');

    urlAddress = Uri.parse(url); 
    fileName = urlAddress!.pathSegments.last.split('/').last;
    fileAddress = File('${Constants.i.cacheDirectory.path}${Constants.i.pathSeparator}$fileName');

    if(fileAddress!.existsSync()){
      return fileAddress!.readAsBytes();
    }else{
      return _getDataFromNetwork<Uint8List>(fileDurationTime);
    }

  }

  /// Se não passar o tempo de duração do arquivo, o mesmo terá uma duração de 3 dias
  Future<T> _getDataFromNetwork<T>(Duration? fileDurationTime) async {

    try {
      _request = await Constants.i.httpClient.getUrl(urlAddress!);
      _response = await _request?.close();
  
      if(_response!.statusCode == 200){

        return consolidateHttpClientResponseBytes(_response!, autoUncompress: false).then((uint8List) async {

          await fileAddress?.create(recursive: true).then((file) {
            file.writeAsBytesSync(uint8List);
          });
          
          //print('Tamannho do arquivo: ${fileAddress!.lengthSync()}');
          //print('Tamannho do arquivo: ${uint8List.lengthInBytes}');

          return T == Uint8List ? uint8List as T : fileAddress as T;

        }).whenComplete(() {

          _upDateJsonDataBaseCache (
            data: {
              fileName!: {
                "networkURL": urlAddress!.toString(),
                "fileAddress": fileAddress!.path,
                "fileSize": fileAddress!.lengthSync(),
                "expirationData": DateTime.now()
                  .add(fileDurationTime ?? const Duration(days: 3))
                  .toIso8601String(),
              }
            },
            type: _OperationType.add
          );

          _dispose();

        }).catchError((_){
          _dispose();
          throw '---- Falha ao tentar armazenar o arquivo ----';
        });

      }else if(_response!.statusCode >= 404){
        _dispose();
        throw '---- Verifique se a url informada está correta, se ela existe ou se tem problemas no servidor ----';
      }else{
        _dispose();
        throw '---- Falha ao tentar armazenar o arquivo, status: ${_response!.statusCode}  ----';
      }
    
    } catch (e) {
      _dispose();
      throw '---- Erro ao tentar acessar a url fornecida, por favor verifique sua conexão ----';
    }
  
  }

  void _dispose() {

    //Constants.httpClient.close();
    _request?.close();
    
    _request = null;
    _response = null;
    fileName = null;
    fileAddress = null;
    urlAddress = null;

  }
  /// função responsável por verificar e deletar o arquivos expirados
  static Future<void> checkExpiredFiles() async {
    if(_cachedFileData.existsSync()) {
      await _cachedFileData.readAsString().then((value) {
        if(value.isNotEmpty){

          final Map<String, dynamic> _data = json.decode(value);
          final int counter = _data.length;

          ({..._data}).forEach((key, value) async {
            if(DateTime.parse(value['expirationData']).isBefore(DateTime.now())){
              _data.remove(key);
              Functions.i.file = File(value['fileAddress']);
              await Functions.i.file.delete();
              //print('Arquivo removido: $key');
            }
          });

          if(counter > _data.length) 
            _upDateJsonDataBaseCache(data: _data, type: _OperationType.upDate);

          _data.clear();
        
        }
      });
    }
  }

  /// função responsável por registrar num arquivos json os dados de armazenamento dos arquivos em cache
  static void _upDateJsonDataBaseCache({required Map<String, dynamic> data, required _OperationType type}) async {

    if(_cachedFileData.existsSync()){

      if(type == _OperationType.add){
        await _cachedFileData.readAsString().then((value) {
          Map<String, dynamic> _data = json.decode(value);
          _data.addAll(data);
          _cachedFileData.writeAsStringSync(json.encode(_data));
          _data.clear();
        });
      }else{
        _cachedFileData.writeAsStringSync(json.encode(data));
      }
    }else{
      await _cachedFileData.create(recursive: true).whenComplete(() => 
        _cachedFileData.writeAsStringSync(json.encode(data))
      );
    }
  }

  /// função responsável por deletar dos os arquivos
  static Future<bool> deleteAllCachedFiles() async {

    return await Constants.i.cacheDirectory.exists().then((value) {
      if(value){

        Constants.i.cacheDirectory.listSync().forEach((entity) async {
          await entity.delete();
        });

        print('---- Todos os arquivos em cache da app foram removidos ----');
        return true;
      
      }else{
        return false;
      }
    });

  }

  /// função responsável por ler a quantida de mémoria armazana em cache
  static Future<String> getTotalSizeCachedFiles() async {
    if(_cachedFileData.existsSync()) {
      return await _cachedFileData.readAsString().then((value) {

        if(value.isNotEmpty){

          final Map<String, dynamic> _data = json.decode(value);

          //ler o tamanho de todos os arquivos salvos em cache + o próprio json
          final byte = _data.values.fold<num>(0, (value, e) => value + e['fileSize']) 
            + _cachedFileData.lengthSync();
          
          if(byte >= 1e+9){
            return '${(byte / 1e+9).toStringAsFixed(3)} GB';
          }else{
            return '${(byte / 1e+6).toStringAsFixed(3)} MB';
          }

        }else{
          return '0 KB';
        }
      
      });
    }else {
      return '0 KB';
    }
  }

}
