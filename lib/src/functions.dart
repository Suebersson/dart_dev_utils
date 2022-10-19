import 'constants.dart';

class Functions {
  static Functions? _instance;

  Functions._();

  static Functions get i {
    _instance ??= Functions._();
    return _instance!;
  }

  /// verificar se a url é válida
  bool isNetworkURL({required String url}) {
    assert(url.isNotEmpty, 'Insira o endereço da URL');
    return Constants.i.regExpUrls.hasMatch(url);
  }

  /// verificar se o e-mail é válida
  bool isEmail({required String email}) {
    assert(email.isNotEmpty, 'Insira o endereço da E-mail');
    return Constants.i.regExpEmails.hasMatch(email);
  }

  /// verificar se a String e numerica
  bool isNumeric({required String value}) {
    assert(value.isNotEmpty, 'Insira uma string numérica');
    var number = num.tryParse(value);
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
}
