import 'constants.dart';

extension FunctionsForString on String {
  /// verificar se a url é válida
  bool get isNetworkURL => dartDevUtils.isNetworkURL(this);

  /// verificar se o e-mail é válida
  bool get isEmail => dartDevUtils.isEmail(this);

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
}
