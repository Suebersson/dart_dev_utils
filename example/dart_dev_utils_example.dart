import 'package:dart_dev_utils/dart_dev_utils.dart';

void main() async{
  
  // Formato: 000.000.000-00
  print(Constants.i.regExpCPF.hasMatch('000.000.000-00')); // true
  
  // Formatos: 00900000000; (00)900000000; 0090000-0000; (00)90000-0000
  print(Constants.i.regExpCellPhoneBR.hasMatch('(00)900000000')); // true

  // Formatos: 0000000000; (00)00000000; 000000-0000; (00)0000-0000
  print(Constants.i.regExpFixePhoneBR.hasMatch('(00)30000000')); // true

  print('suebersson montalvão'.capitalize); // Suebersson montalvão

  print('suebersson montalvão'.capitalizeAll); // Suebersson Montalvão

  var f = Functions.i.checkFileExist(filePath: 'C:/Users/name/AppData/Local/Temp/cachedFilesFlutterApp/Google-flutter-logo.png');
  print('Exist: $f');

  await Functions.i.getByteDataFromInternet(url: 'https://getlogo.net/wp-content/uploads/2020/08/flutter-logo-vector.png').then((uint8List) {
    Functions.i.createFile(filePath: 'C:/Users/name/...png', bytesData: uint8List).then((value) {
      print('---- Arquivo creado com sucesso ----');
    });
  });

  await Functions.i.getByteDataFromFile(filePath: 'C:/Users/name/...png').then((value) {
    print(value);
  });

  // armazenar arquivo em cache
  await FilesCache().getBytesData(
    url: 'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png',
    fileDurationTime: Duration(days: 3)
  ).then((uint8List) {
    print(uint8List);
  });

}
