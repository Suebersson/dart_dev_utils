import 'dart:async';
import 'dart:math' show Random;
import 'dart:developer' as developer;

import './constants.dart';
import './extensions.dart';

mixin Functions {
  /// verificar se a url é válida
  bool isNetworkURL(String url) {
    // assert(url.isNotEmpty, 'Insira o endereço da URL');
    // impossibilitar o processamento se a string for vazia
    if (url.isEmpty) return false;

    return dartDevUtils.regExpUrls.hasMatch(url);
  }

  /// verificar se o e-mail é válida
  bool isEmail(String email) {
    // assert(email.isNotEmpty, 'Insira o endereço da E-mail');
    // impossibilitar o processamento se a string for vazia
    if (email.isEmpty) return false;

    return dartDevUtils.regExpEmails.hasMatch(email);
  }

  /// verificar se o texto tem o formato de endereço de telefone
  bool isPhone(String number) {
    // impossibilitar o processamento se a string for vazia
    if (number.isEmpty) return false;

    return dartDevUtils.regExpGlobalPhone.hasMatch(number);
  }

  /// verificar se a String e numerica
  bool isNumeric(String text) {
    // assert(str.isNotEmpty, 'Insira uma string numérica');
    // impossibilitar o processamento se a string for vazia
    if (text.isEmpty) return false;

    var number = num.tryParse(text);
    if (!number!.isNaN && number.isFinite) {
      return true;
    } else {
      return false;
    }
  }

  /// Converter a primera letra para maiúscula
  String capitalize(String text) {
    // assert(str.isNotEmpty, 'Insira a String para converção');
    // impossibilitar o processamento se a string for vazia
    if (text.isEmpty) return text;

    return text[0].toUpperCase() + text.substring(1);
  }

  /// Converter a primeira letra de todas as palavras para maiúscula
  String capitalizeAll(String text) {
    // assert(str.isNotEmpty, 'Insira a String para converção');
    // impossibilitar o processamento se a string for vazia
    if (text.isEmpty) return text;

    return text
        .split(' ')
        .asMap()
        .entries
        .map((e) => capitalize(e.value))
        .toList()
        .join(' ');
  }

  /// obter apenas caracteres alfabéticos e númericos
  String getOnlyAlphabetsNumbers(String text) {
    // assert(str.isNotEmpty, 'Insira um valor de string');
    // impossibilitar o processamento se a string for vazia
    if (text.isEmpty) return text;

    return text.replaceAll(dartDevUtils.regExpOnlyAlphabetsNumbers, '');
  }

  /// obter apenas caracteres númericos
  String getOnlyNumbers(String text) {
    // assert(str.isNotEmpty, 'Insira um valor de string');
    // impossibilitar o processamento se a string for vazia
    if (text.isEmpty) return text;

    return text.replaceAll(dartDevUtils.regExpOnlyNumbers, '');
  }

  /// obter apenas caracteres alfabéticos
  String getOnlyAlphabets(String text) {
    // assert(str.isNotEmpty, 'Insira um valor de string');
    // impossibilitar o processamento se a string for vazia
    if (text.isEmpty) return text;

    return text.replaceAll(dartDevUtils.regExpOnlyAlphabets, '');
  }

  /// Remover acentos de uma cadeia de caracteres
  String removeAccents(String text, {Pattern? pattern}) {
    // assert(text.isNotEmpty, 'Insira um valor de string');
    // impossibilitar o processamento se a string for vazia
    if (text.isEmpty) return text;

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
  DateTime? getDateFromText(String text) {
    /// Padrões de formato que seram reconhecidos pela função
    /// US: yyyy-mm-dd; yyyy/mm/dd
    /// BR: dd-mm-yyyy; dd/mm/yyyy

    // assert(str.isNotEmpty, 'Insira um valor de String');
    // impossibilitar o processamento se a string for vazia
    if (text.isEmpty) return null;

    if (text.contains('/')) text = text.replaceAll('/', '-');

    if (dartDevUtils.regExpDateUS.hasMatch(text)) {
      /// Formato US: yyyy-mm-dd ou yyyy/mm/dd

      return DateTime.parse(dartDevUtils.regExpDateUS.stringMatch(text)!);
    } else if (dartDevUtils.regExpDateBR.hasMatch(text)) {
      /// Formato BR: dd-mm-yyyy ou dd/mm/yyyy

      /// Converter para o formato US => yyyy-mm-dd
      text = dartDevUtils.regExpDateBR.stringMatch(text)!;
      text = text.split('-').reversed.join('-');

      return DateTime.parse(text);
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
