import 'dart:async';
import 'dart:math' show Random;
import 'dart:developer' as developer;

import './constants.dart';

class Functions {
  static final Functions _instance = Functions._();
  static Functions get i => _instance;
  Functions._();

  /// verificar se a url é válida
  bool isNetworkURL(String url) {
    assert(url.isNotEmpty, 'Insira o endereço da URL');
    return Constants.i.regExpUrls.hasMatch(url);
  }

  /// verificar se o e-mail é válida
  bool isEmail(String email) {
    assert(email.isNotEmpty, 'Insira o endereço da E-mail');
    return Constants.i.regExpEmails.hasMatch(email);
  }

  /// verificar se a String e numerica
  bool isNumeric(String str) {
    assert(str.isNotEmpty, 'Insira uma string numérica');
    var number = num.tryParse(str);
    if (!number!.isNaN && number.isFinite) {
      return true;
    } else {
      return false;
    }
  }

  /// Converter a primera letra para maiúscula
  String capitalize(String str) {
    assert(str.isNotEmpty, 'Insira a String para converção');
    return str[0].toUpperCase() + str.substring(1);
  }

  /// Converter a primeira letra de todas as palavras para maiúscula
  String capitalizeAll(String str) {
    assert(str.isNotEmpty, 'Insira a String para converção');
    return str
        .split(' ')
        .asMap()
        .entries
        .map((e) => capitalize(e.value))
        .toList()
        .join(' ');
  }

  /// obter apenas caracteres alfabéticos e númericos
  String getOnlyAlphabetsNumbers(String str) {
    assert(str.isNotEmpty, 'Insira um valor de string');
    return str.replaceAll(Constants.i.regExpOnlyAlphabetsNumbers, '');
  }

  /// obter apenas caracteres númericos
  String getOnlyNumbers(String str) {
    assert(str.isNotEmpty, 'Insira um valor de string');
    return str.replaceAll(Constants.i.regExpOnlyNumbers, '');
  }

  /// obter apenas caracteres alfabéticos
  String getOnlyAlphabets(String str) {
    assert(str.isNotEmpty, 'Insira um valor de string');
    return str.replaceAll(Constants.i.regExpOnlyAlphabets, '');
  }

  /// Remover acentos de uma cadeia de caracteres
  String removeAccents(String str) {
    // Posição: m.start
    // Caracter: m.input[m.start]
    assert(str.isNotEmpty, 'Insira um valor de string');
    return str.replaceAllMapped(Constants.i.regExpAccentedCharacters, (m) {
      return Constants.i.charactersWithoutAccent[
          Constants.i.charactersWithAccent.indexOf(m.input[m.start])];
    });
  }

  /// Essa função é ideal para obeter um valor de uma data através
  /// de um texto logo ou quando o formato da data na string é desconhecido
  DateTime? getDateFromText(String str) {
    /// Padrões de formato que seram reconhecidos pela função
    /// US: yyyy-mm-dd; yyyy/mm/dd
    /// BR: dd-mm-yyyy; dd/mm/yyyy
    assert(str.isNotEmpty, 'Insira um valor de String');

    if (str.contains('/')) str = str.replaceAll('/', '-');

    if (Constants.i.regExpDateUS.hasMatch(str)) {
      /// Formato US: yyyy-mm-dd ou yyyy/mm/dd

      return DateTime.parse(Constants.i.regExpDateUS.stringMatch(str)!);
    } else if (Constants.i.regExpDateBR.hasMatch(str)) {
      /// Formato BR: dd-mm-yyyy ou dd/mm/yyyy

      /// Converter para o formato US => yyyy-mm-dd
      str = Constants.i.regExpDateBR.stringMatch(str)!;
      str = str.split('-').reversed.join('-');

      return DateTime.parse(str);
    } else {
      //throw 'O valor da String não contém nenhum formato de data.';
      return null;
    }
  }

  /// Gerador de caracteres aleatórios
  String passwordGenerate({
    int size = 6,
    PasswordType passwordType = PasswordType.characterMix,
  }) {
    //Code ==> https://theasciicode.com.ar/
    final List<int> skipCharCode = const [
      34,
      39,
      40,
      41,
      44,
      46,
      47,
      58,
      59,
      60,
      61,
      62,
      91,
      92,
      93,
      94,
      96,
      123
    ];
    final Random random = Random.secure();
    int charCode;

    switch (passwordType) {
      case PasswordType.onlyNumbers:
        return List<String>.generate(
          size,
          (i) => String.fromCharCode(
              random.nextInt(10) + 48), // charCode >= 48 & 57 <=
        ).join('');
      case PasswordType.onlyCapitalLetters:
        return List<String>.generate(
          size,
          (i) => String.fromCharCode(
              random.nextInt(26) + 65), // charCode >= 65 & 90 <=
        ).join('');
      case PasswordType.onlyLowerCaseLetters:
        return List<String>.generate(
          size,
          (i) => String.fromCharCode(
              random.nextInt(26) + 97), // charCode >= 97 & 122 <=
        ).join('');
      case PasswordType
          .upperLowerCaseLetters: // Characters: CapitalLetters + LowerCaseLetters
        return List<String>.generate(
          size,
          (i) {
            do {
              charCode = random.nextInt(58) + 65; // charCode >= 65 & 122 <=
            } while (
                //transformar as condições em uma única condição
                !<bool>[
              charCode >= 65 && charCode <= 90, //charCode entre 65-90
              charCode >= 97 && charCode <= 122 //charCode entre 97-122
            ].contains(true));
            return String.fromCharCode(charCode);
          },
        ).join('');
      case PasswordType
          .numbersLetters: // Characters: numbers + CapitalLetters + LowerCaseLetters
        return List<String>.generate(
          size,
          (i) {
            do {
              charCode = random.nextInt(75) + 48; // charCode >= 48 & 122 <=
            } while (
                //transformar as condições em uma única condição
                !<bool>[
              charCode >= 48 && charCode <= 57, //charCode entre 48-57
              charCode >= 65 && charCode <= 90, //charCode entre 65-90
              charCode >= 97 && charCode <= 122 //charCode entre 97-122
            ].contains(true));
            return String.fromCharCode(charCode);
          },
        ).join('');
      default: // Characters: numbers + CapitalLetters + LowerCaseLetters + special characters
        return List<String>.generate(
          size,
          (i) {
            do {
              charCode = random.nextInt(90) + 33; // charCode >= 33 & 122 <=
            } while (skipCharCode.contains(charCode));
            return String.fromCharCode(charCode);
          },
        ).join('');
    }
  }
}

// ###########################################################################
//
// Método/funções que devem ficar fora de uma classe para que possam ser
// acessadas e usadas por qualquer método estático ou não estático
//
// ###########################################################################

/// Este método foi criado para substituir o método [print] do dart,
/// o mesmo imprime uma mesagem de texto no console apenas se a app
/// estiver sendo executada no modo debug
void printLog(
  String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  String name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  if (isRunDebugMode_) {
    developer.log(
      message,
      time: time,
      sequenceNumber: sequenceNumber,
      level: level,
      name: name,
      zone: zone,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
