import 'dart:async';
import 'dart:math' show Random;
import 'dart:developer' as developer;

import './constants.dart';
import './extensions.dart';

class Functions {
  /// verificar se a url é válida
  bool isNetworkURL(String url) {
    assert(url.isNotEmpty, 'Insira o endereço da URL');
    return dartDevUtils.regExpUrls.hasMatch(url);
  }

  /// verificar se o e-mail é válida
  bool isEmail(String email) {
    assert(email.isNotEmpty, 'Insira o endereço da E-mail');
    return dartDevUtils.regExpEmails.hasMatch(email);
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
    return str.replaceAll(dartDevUtils.regExpOnlyAlphabetsNumbers, '');
  }

  /// obter apenas caracteres númericos
  String getOnlyNumbers(String str) {
    assert(str.isNotEmpty, 'Insira um valor de string');
    return str.replaceAll(dartDevUtils.regExpOnlyNumbers, '');
  }

  /// obter apenas caracteres alfabéticos
  String getOnlyAlphabets(String str) {
    assert(str.isNotEmpty, 'Insira um valor de string');
    return str.replaceAll(dartDevUtils.regExpOnlyAlphabets, '');
  }

  /// Remover acentos de uma cadeia de caracteres
  String removeAccents(String text, {Pattern? pattern}) {
    // assert(text.isNotEmpty, 'Insira um valor de string');

    // RegExp usada no JavaScript => RegExp("[\u0300-\u036f]"). A mesma só funciona
    // se todos os caracteres forem desmembrados para o padrão NFD usando a função "normalize()"
    // no javaScript
    return text.replaceAllMapped(
        pattern ?? dartDevUtils.regExpAccentedCharacters, (match) {
      // Posição: match.start
      // Caracter(texto): match.input[match.start]
      String l = match.input[match.start];
      return dartDevUtils.charactersWithAccent.entries
          .singleWhere((mapEntry) => mapEntry.value.contains(l),
              orElse: () => MapEntry(l, {}))
          .key;
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

    if (dartDevUtils.regExpDateUS.hasMatch(str)) {
      /// Formato US: yyyy-mm-dd ou yyyy/mm/dd

      return DateTime.parse(dartDevUtils.regExpDateUS.stringMatch(str)!);
    } else if (dartDevUtils.regExpDateBR.hasMatch(str)) {
      /// Formato BR: dd-mm-yyyy ou dd/mm/yyyy

      /// Converter para o formato US => yyyy-mm-dd
      str = dartDevUtils.regExpDateBR.stringMatch(str)!;
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

  /// Converter uma cadeia de caracteres para uma base númerica
  List<String> convertStringToNumericalBase(String text,
      {NumericBase typeBase = NumericBase.binary}) {
    // assert(text.isNotEmpty, 'Insira um texto para fazer a conversão');

    /// Exemplo:
    /// ```dart
    /// List<String> listUnicode =
    ///   convertStringToNumericalBase('Suebersson montalvão', typeBase: NumericBase.hexadecimal)
    ///     .map((e) => '\\u00$e').toList();
    /// print(listUnicode);
    /// ```

    return Runes(text).map((i) => i.toRadixString(typeBase.getBase)).toList();
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
