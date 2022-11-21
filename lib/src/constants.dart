class Constants {
  static final Constants _instance = Constants._();
  static Constants get i => _instance;
  Constants._();

  /// expressão regular para válida url
  final RegExp regExpUrls = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  /// expressão regular para válida e-mails
  final RegExp regExpEmails = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  /// expressão regular para válida datas nos formato americanos
  /// Formato: yyyy-mm-dd; yyyy/mm/dd
  final RegExp regExpDateUS = RegExp(r"\d{4}(-|/)\d{2}(-|/)\d{2}");

  /// expressão regular para válida datas nos formato brasileiro
  /// Formato: dd-mm-yyyy; dd/mm/yyyy
  final RegExp regExpDateBR = RegExp(r"\d{2}(-|/)\d{2}(-|/)\d{4}");

  /// Formato: 0000 0000 0000 0000
  final RegExp regExpCredcardBR = RegExp(r"\d{4}\s\d{4}\s\d{4}");

  /// Formato: 000.000.000-00; 00.000.000/0000-00
  final RegExp regExpCpfCnpj =
      RegExp(r"\d{3}.\d{3}.\d{3}-\d{2}|\d{2}.\d{3}.\d{3}/\d{4}-\d{2}");

  /// Formato: 00.000-000; 00000-000
  final RegExp regExpCEP = RegExp(r"\d{2}(.|)\d{3}-\d{3}");

  /// expressão regular para válidar número de telefone celular brasileiro
  /// Formatos: 00900000000; (00)900000000; 0090000-0000; (00)90000-0000;
  ///           00 900000000; (00) 900000000; 00 90000-0000; (00) 90000-0000
  final RegExp regExpCellPhoneBR = RegExp(
      r"(\d{2}(\s9|9)\d{8})|(\(\d{2}\)(\s9|9)\d{8})|(\d{2}(\s9|9)\d{4}-\d{4})|(\(\d{2}\)(\s9|9)\d{4}-\d{4})");

  /// expressão regular para válidar número de telefone fixo brasileiro
  /// Formatos: 0000000000; (00)00000000; 000000-0000; (00)0000-0000;
  ///           00 00000000; (00) 00000000; 00 0000-0000; (00) 0000-0000
  final RegExp regExpFixePhoneBR = RegExp(
      r"(\d{2}(\s|)\d{8})|(\(\d{2}\)(\s|)\d{8})|(\d{2}(\s|)\d{4}-\d{4})|(\(\d{2}\)(\s|)\d{4}-\d{4})");

  /// válidar apenas caracteres alfabéticos e númericos
  final RegExp regExpOnlyAlphabetsNumbers = RegExp('[^A-Za-z0-9]');

  /// válidar apenas caracteres alfabéticos
  final RegExp regExpOnlyAlphabets = RegExp('[^A-Za-z]');

  /// válidar apenas caracteres númericos
  final RegExp regExpOnlyNumbers = RegExp('[^0-9]');

  final String charactersWithAccent =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  final String charactersWithoutAccent =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

  /// Caracteres com acentos
  final RegExp regExpAccentedCharacters = RegExp('[À-ž]');

  bool get isRunProfileMode => isRunProfileMode_;
  bool get isRunReleaseMode => isRunReleaseMode_;
  bool get isRunDebugMode => isRunDebugMode_;
}

// ###########################################################################
//
// Variavéis que devem ficar fora de uma classe para que possam ser
// acessadas e usadas por qualquer método estático ou não estático
//
// ###########################################################################

/// Modo execução da aplicação
const bool isRunProfileMode_ = bool.fromEnvironment('dart.vm.profile');
const bool isRunReleaseMode_ = bool.fromEnvironment('dart.vm.product');
const bool isRunDebugMode_ = !isRunReleaseMode_ && !isRunProfileMode_;
