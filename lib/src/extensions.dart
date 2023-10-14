import 'dart:async' show Completer;
import 'dart:convert';

import './constants.dart';
import './exceptions.dart';

extension FunctionsForString on String {
  /// verificar se a url é válida
  bool get isNetworkURL => dartDevUtils.isNetworkURL(this);

  /// verificar se o texto tem o formato de endereço de telefone
  bool get isPhone => dartDevUtils.isPhone(this);

  /// verificar se a String e numerica
  bool get isNumeric => dartDevUtils.isNumeric(this);

  /// Converter a primera letra para maiúscula
  String get capitalize => dartDevUtils.capitalize(this);

  /// Converter a primeira letra de todas as palavras para maiúscula
  String get capitalizeAll => dartDevUtils.capitalizeAll(this);

  /// obter apenas caracteres alfabéticos e númericos
  String get getOnlyAlphabetsNumbers =>
      dartDevUtils.getOnlyAlphabetsNumbers(this);

  /// obter apenas caracteres númericos
  String get getOnlyNumbers => dartDevUtils.getOnlyNumbers(this);

  /// obter apenas caracteres alfabéticos
  String get getOnlyAlphabets => dartDevUtils.getOnlyAlphabets(this);

  /// Remover acentos de uma cadeia de caracteres
  String get removeAccents => dartDevUtils.removeAccents(this);

  /// Obter data em um texto
  DateTime? get getDateFromText => dartDevUtils.getDateFromText(this);

  /// Converter uma cadeia de caracteres para uma [List<String>]
  /// onde cada caractere é representado na base 2
  List<String> get toBinaryList =>
      dartDevUtils.convertStringToNumericalBase(this);

  /// Converter uma cadeia de caracteres para uma [List<String>]
  /// onde cada caractere é representado na base 8
  List<String> get toOctalList => dartDevUtils
      .convertStringToNumericalBase(this, typeBase: NumericBase.octal);

  /// Converter uma cadeia de caracteres para uma [List<String>]
  /// onde cada caractere é representado na base 16
  List<String> get toHexadecimalList => dartDevUtils
      .convertStringToNumericalBase(this, typeBase: NumericBase.hexadecimal);

  /// Converter uma cadeia de caracteres para uma [List<String>]
  /// onde cada caractere é representado na base 16
  List<String> get toDuotrigesimalList => dartDevUtils
      .convertStringToNumericalBase(this, typeBase: NumericBase.duotrigesimal);

  /// Converter uma cadeia de caracteres para uma [List<String>]
  /// onde cada caractere é representado nos formatos Unicode: \u0000 e \u{00000}
  List<String> get toUniCodeList => toHexadecimalList
      .map((e) => e.length <= 4 ? '\\u${e.padLeft(4, '0')}' : '\\u{$e}')
      .toList();

  // Essa função é equivalente as funções nativas do dart:
  // ==> latin1.encoder.convert('anyString') ASCII de 0-255 caracteres
  // ==> utf8.encoder.convert('anyString') ASCII de 0-127 caracteres
  // ==> 'anyString'.codeUnits é bem semenhente, mais pode gerar uma lista
  // de bytes maior caso os caracteres sejam emojis
  //
  // A diferença é que cada caracter é convertido para os valores hexadecimais(base 16)
  // sem ter a limitações de bytes nos padrões UTF-7, UTF-8, Latin-1 ISO-8859-1, ...
  // que podem gerar uma FormatException na conversão como nesse exemplo onde as letras
  // [Ş] e [ț] não fazem parte da tabela ASCII
  //
  // print(latin1.encode('Şuebersson monțalvão')); // dará um erro
  //
  // funciona, mais, irá alterar os bytes para compatibilizar com a tabala ASCII
  // e gerará bytes adicionais
  // print(utf8.encode('Şuebersson monțalvão'));
  //
  //
  // Tem o mesmo comportamento do método latin1.encode e irá gerar um Exception
  // caso tenha algo caracter fora tabela ASCII(0-255), além alterar os caracteres
  //
  // BytesBuilder bytesBuilder = BytesBuilder();
  // bytesBuilder.add('Şuebersson monțalvão'.codeUnits);
  // print(utf8.decode(bytesBuilder.toBytes())); // ^uebersson monalvão
  //
  /// Criar uma list(UTF-16) de bytes com valores hexadecimais
  List<int> get toHexaBytes =>
      toHexadecimalList.map((e) => int.parse('0x$e')).toList();

  /// Converter um texto[String] legível para base64
  String get toBase64 => base64.encode(toHexaBytes);

  /// Converter um texto na base64[String] para um texto legível
  String get base64ToUTF16String => base64.decode(this).bytesToString;

  // Suebersson Montalvão ==> Suebersson%20Montalv%C3%A3o
  String get toEscape => Uri.encodeComponent(this);
  // Suebersson%20Montalv%C3%A3o ==> Suebersson Montalvão
  String get toUnEscape => Uri.decodeComponent(this);

  /// Converter base64 para bytes
  List<int> get toBytes => base64.decode(this);

  /// Verificar se uma string inicia ou termina com uma correspondência[RegExp]
  ///
  /// Ex:  print('...suebersson.dev@gmail.com'.startsOrEndsWith(RegExp(r'[_.@-]')));
  ///
  bool startsOrEndsWith(RegExp regExp) {
    if (isEmpty) {
      return false;
    } else if (regExp.hasMatch(this[0]) || regExp.hasMatch(this[length - 1])) {
      return true;
    } else {
      return false;
    }
  }
}

extension Utf8ListToString on List<int> {
  // Essa função é equivalente a função: utf8.decode(this, allowMalformed: true),
  // a diferenção é que a mesma não está limitada a tabela ASCII de 0-255 caracteres
  /// Converter uma lista de bytes para [String]
  String get bytesToString => String.fromCharCodes(this);

  /// Converter bytes para base64
  String get toBase64 => base64.encode(this);
}

extension GetBase on NumericBase {
  int get getBase {
    switch (this) {
      case NumericBase.duotrigesimal:
        return 32;
      case NumericBase.hexadecimal:
        return 16;
      case NumericBase.octal:
        return 8;
      default:
        return 2;
    }
  }
}

extension GetValueFromKey on Map {
  /// Obter um valor na [Map] através da chave
  ///
  /// Se a função [computation] for atribuida, ela será executada
  /// ao invés de obter o valor diretamente através da chave. Essa função
  /// possibilita processar o valor e fazer converções
  ///
  /// O parâmentro [orElseValue] irá retornar um valor alternativo caso a chave/valor não exista
  /// ou caso a função [computation] retorne [null]. Esse parâmetro garante o retorno de
  /// um valor, caso o mesmo não seja definido(atribuido), a função irá gerar um erro com uma [Exception]
  ///
  V getValueFromKey<K, V>(K key,
      {dynamic Function(dynamic)? computation, V? orElseValue}) {
    if (containsKey(key)) {
      var value = computation?.call(this[key]) ?? this[key];

      if (value == null) {
        return orElseValue ??= throw GetValueFromKeyException(
            'A key foi encontrada, mais o valar é nulo');
      } else if (value is V) {
        return value;
      } else {
        throw GetValueFromKeyException(
            'O valor foi encontrado, mais o tipo é ${value.runtimeType} e o dart não possibilita fazer um cast de tipos diferentes');
      }
    } else {
      return orElseValue ??=
          throw GetValueFromKeyException('key($key) não encontrada');
    }
  }

  /*
    Map<String, dynamic> mapData = {
      'name': 'Sueberssom Montalvão',
      'age': 198,
      'heigth': '1.70',
      'birthData': '1825-04-14',
      'homePage': 'http://suebersson.dev',
      'is_dev': true,
      'anything': null,
    };

    // Uma Chamando simples, com risco de gerar uma Exception caso chave/valor não exista
    print(mapData.getValueFromKey('name')); // Suebersson Montalvão

    print(mapData.getValueFromKey<dynamic, int>('noExistentKey', orElseValue: 404)); // 404

    print(mapData.getValueFromKey('anything', computation: (o) => o ?? 'undefined')); //undefined

    print(mapData.getValueFromKey('anything', orElseValue: 'undefined')); //undefined

    print(mapData.getValueFromKey('is_dev', orElseValue: false)); // true

    print(mapData.getValueFromKey(
      'homePage', computation: (e) => Uri.parse(e)).runtimeType);// _SimpleUri

    print(mapData.getValueFromKey(
      'name', computation: (e) => Uri.encodeComponent(e)));// Sueberssom%20Montalv%C3%A3o

    print(mapData.getValueFromKey('heigth', computation: (e) => num.tryParse(e)));// 1.7

    print(
      mapData.getValueFromKey<String, DateTime>(
        'birthData', 
        computation: (e) => DateTime.tryParse(e),
        orElseValue: DateTime.now()
      )
    ); // 1825-04-14 00:00:00.000
  */
}

extension FirstWhereMultComputation<T> on List<T> {
  /// Procurar um único dado com multiplos processamentos(multiplas funções assíncronas) em paralelo
  ///
  /// Está função trabalha da mesma forma que a função [firstWhere].
  /// E também é similar a função [Future.any] que inserimos as funções manuamente,
  /// a difereça é que as funções assíncronas são criadas automaticamente de acordo
  /// com a quantidade computações definidas no parâmetros [computation]
  ///
  /// Essa função é inviável caso tenha que processar dados nas funções[computation]
  /// que não sejam complexas ou que o processamento seja rápido. Nesse caso use a função [firstWhere]
  ///
  /// Potanto, só use essa função caso tenha executar funções complexas, que demoram para obter
  /// o resultado e tenha muitos dados a serem processados para obter um único valor/dado
  Future<T> firstWhereMultComputation(bool Function(T) test,
      {int computation = 4, T Function()? orElse}) {
    final int dataLength = length;

    /// Se quantidade de [computation] for maior do que a quantidade de dados
    /// ou menor ou igual a 1
    if (computation >= dataLength || computation <= 1) {
      /// Usar apenas uma função[computation] nativa do dart
      return Future.value(firstWhere(test, orElse: orElse));
    } else {
      final Completer<T> completer = Completer<T>.sync();

      bool isCompleted = false; //completer.isCompleted;

      final int groups = dataLength ~/ computation;

      late final List<Set<int>> ranges;

      /// Se a quantidade de dados que serão processados foi dividido por igual para
      /// a quantidade funções que serão computadas, então, gerar grupos com intervalos iguais
      if (groups * computation == dataLength) {
        ranges = List<Set<int>>.generate(computation, (i) {
          if (i == 0) {
            return {0, groups * (i + 1) - 1};
          } else {
            return {groups * i, groups * (i + 1) - 1};
          }
        });
      } else {
        // senão, o último grupos ficará o restante dos dados
        ranges = List<Set<int>>.generate(computation, (i) {
          if (i == 0) {
            return {0, groups * (i + 1) - 1};
          } else if (computation == i + 1) {
            return {groups * i, dataLength - 1};
          } else {
            return {groups * i, groups * (i + 1) - 1};
          }
        });
      }

      Future<void> findObject(int first, int last) async {
        if (isCompleted) return;
        for (var i = first; i <= last; i++) {
          if (isCompleted) {
            break;
          } else {
            if (test(this[i])) {
              isCompleted = true;
              completer.complete(this[i]);
              break;
            }
          }
        }
      }

      for (var c = 0; c < computation; c++) {
        findObject(ranges[c].first, ranges[c].last).then((_) {
          if (c + 1 == dataLength && !isCompleted) {
            if (orElse == null) {
              throw FirstWhereMultComputationException(
                  'O valor não foi encontrado no objeto $runtimeType');
            } else {
              isCompleted = true;
              completer.complete(orElse.call());
            }
          }
        }).onError((error, stackTrace) {
          if (!completer.isCompleted) {
            completer.completeError(error!, stackTrace);
          }
        });
      }

      return completer.future.whenComplete(() {
        ranges.clear();
      });
    }
  }
}
