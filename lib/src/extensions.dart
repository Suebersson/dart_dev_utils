import 'functions.dart';

extension FunctionsForString on String {
  /// verificar se a url é válida
  // ignore: unnecessary_this
  bool get isNetworkURL => Functions.i.isNetworkURL(this);

  /// verificar se o e-mail é válida
  // ignore: unnecessary_this
  bool get isEmail => Functions.i.isEmail(this);

  /// verificar se a String e numerica
  // ignore: unnecessary_this
  bool get isNumeric => Functions.i.isNumeric(this);

  /// Converter a primera letra para maiúscula
  // ignore: unnecessary_this
  String get capitalize => Functions.i.capitalize(this);

  /// Converter a primeira letra de todas as palavras para maiúscula
  // ignore: unnecessary_this
  String get capitalizeAll => Functions.i.capitalizeAll(this);

  /// obter apenas caracteres alfabéticos e númericos
  // ignore: unnecessary_this
  String get getOnlyAlphabetsNumbers =>
      Functions.i.getOnlyAlphabetsNumbers(this);

  /// obter apenas caracteres númericos
  // ignore: unnecessary_this
  String get getOnlyNumbers => Functions.i.getOnlyNumbers(this);

  /// obter apenas caracteres alfabéticos
  // ignore: unnecessary_this
  String get getOnlyAlphabets => Functions.i.getOnlyAlphabets(this);

  /// Remover acentos de uma cadeia de caracteres
  // ignore: unnecessary_this
  String get removeAccents => Functions.i.removeAccents(this);

  /// Obter data em um texto
  // ignore: unnecessary_this
  DateTime? get getDateFromText => Functions.i.getDateFromText(this);
}
