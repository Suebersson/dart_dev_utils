class Constants {
  static Constants? _instance;

  Constants._();

  static Constants get i {
    _instance ??= Constants._();
    return _instance!;
  }

  /// expressão regular para válida url
  RegExp get regExpUrls => RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  /// expressão regular para válida e-mails
  RegExp get regExpEmails => RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  /// expressão regular para válida datas nos formato americanos
  /// Formato: yyyy-mm-dd
  RegExp get regExpDateUS => RegExp(r"^\d{4}-\d{2}-\d{2}");

  /// expressão regular para válida datas nos formato brasileiro
  /// Formato: dd-mm-yyyy
  RegExp get regExpDateBR => RegExp(r"^\d{2}-\d{2}-\d{4}");

  /// Formato: 000.000.000-00
  RegExp get regExpCPF => RegExp(r"^\d{3}.\d{3}.\d{3}-\d{2}");

  /// expressão regular para válida número de telefone celular brasileiro
  /// Formatos: 00900000000; (00)900000000; 0090000-0000; (00)90000-0000
  RegExp get regExpCellPhoneBR => RegExp(
      r"((\d{2}9\d{8})|(\(\d{2}\)\9\d{8})|(\d{2}9\d{4}-\d{4})|(\(\d{2}\)\9\d{4}-\d{4}))");

  /// expressão regular para válida número de telefone fixo brasileiro
  /// Formatos: 0000000000; (00)00000000; 000000-0000; (00)0000-0000
  RegExp get regExpFixePhoneBR => RegExp(
      r"((\d{10})|(\(\d{2}\)\d{8})|(\d{2}\d{4}-\d{4})|(\(\d{2}\)\d{4}-\d{4}))");

  /// válidar caracteres alfabéticos e númericos
  RegExp get regExpOnlyAlphabetsNumbers => RegExp('[^A-Za-z0-9]');

  /// válidar apenas caracteres alfabéticos e númericos
  RegExp get regExpOnlyAlphabets => RegExp('[^A-Za-z]');

  /// válidar apenas caracteres númericos
  RegExp get regExpOnlyNumbers => RegExp('[^0-9]');

  final String charactersWithAccent =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  final String charactersWithoutAccent =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

  /// Caracteres com acentos
  RegExp get regExpAccentedCharacters => RegExp('[À-ž]');
}
