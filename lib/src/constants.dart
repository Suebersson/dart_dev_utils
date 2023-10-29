import './mixin_dart_dev_utils.dart';
import './email.dart';

mixin Constants {
  /// expressão regular para válida url
  final RegExp regExpUrls = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  /// expressão regular para válida e-mails
  RegExp get regExpEmails => Email.regExpForEmailsInternal;

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

  /// Expressão regular para válidar número de telefone no formato global:
  ///
  ///
  /// Prefixos com parenteses:
  ///   RegExp(r'\(((\d{1}|\+\d{1})|(\d{2}|\+\d{2})|(\d{3}|\+\d{3})|(\d{4}|\+\d{4}))\)( \d{1}|\d{1}).*\d');
  ///
  ///     (+0)...; (+00)...; (+000)...; (+0000)...;
  ///     (0)...;  (00)...;  (000)...;  (0000)...
  ///
  ///
  /// Prefixos sem parenteses: RegExp(r'(\+\d{1}|\+\d{2}|\+\d{3}|\+\d{4})( \d{1}|\d{1}).*\d')
  ///     +0...; +00...; +000...; +0000...
  ///
  ///
  /// Corpo do endereço: ( \d{1}|\d{1}).*\d
  ///   ===> Começa com um digito(com ou sem um espaço no inicio) e termina digitos
  ///
  /// Exemplo de formatos:
  /// - Prefixos com ou sem parenteses desde que use o caracter '+'
  /// - Prexixos de 1 4 digitos
  /// - com ou sem um espaço no inicio do corpo de endereço
  /// (+00)00000000;  (+00) 00000000; (+00)0000-0000; (+00) 0000-0000
  /// +000 000000000; +000000-0000;   +000 00000-0000
  ///
  final regExpGlobalPhone = RegExp(
      r'\(((\d{1}|\+\d{1})|(\d{2}|\+\d{2})|(\d{3}|\+\d{3})|(\d{4}|\+\d{4}))\)( \d{1}|\d{1}).*\d|(\+\d{1}|\+\d{2}|\+\d{3}|\+\d{4})( \d{1}|\d{1}).*\d');

  /// válidar apenas caracteres alfabéticos e númericos
  final RegExp regExpOnlyAlphabetsNumbers = RegExp('[^A-Za-z0-9]');

  /// válidar apenas caracteres alfabéticos
  final RegExp regExpOnlyAlphabets = RegExp('[^A-Za-z]');

  /// válidar apenas caracteres númericos
  final RegExp regExpOnlyNumbers = RegExp('[^0-9]');

  // https://theasciicode.com.ar/
  final Map<String, Set<String>> charactersWithAccent = Map.unmodifiable({
    'a': {'à', 'á', 'â', 'ã', 'ä', 'å', 'ā', 'ă', 'ą', 'aͤ', 'ǟ'},
    'A': {'À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Ā', 'Ă', 'Ą', 'Aͤ', 'Ǟ'},
    'e': {'è', 'é', 'ê', 'ë', 'ę'},
    'E': {'È', 'É', 'Ê', 'Ë', 'Ę'},
    'i': {'ì', 'í', 'î', 'ï'},
    'I': {'Ì', 'Í', 'Î', 'Ï'},
    'o': {'ò', 'ó', 'ô', 'õ', 'ö', 'ø', 'ő'},
    'O': {'Ò', 'Ó', 'Ô', 'Õ', 'Ö', 'Ø', 'Ő'},
    'u': {'ù', 'ú', 'û', 'ü', 'ŭ', 'ű'},
    'U': {'Ù', 'Ú', 'Û', 'Ü', 'Ŭ', 'Ű'},
    'th': {'Ð', 'ð'},
    'c': {'ç', 'ĉ', 'č', 'ć'},
    'C': {'Ç', 'Ĉ', 'Č', 'Ć'},
    'g': {'ĝ', 'ğ'},
    'G': {'Ĝ', 'Ğ'},
    'h': {'ĥ'},
    'H': {'Ĥ'},
    'j': {'ĵ'},
    'J': {'Ĵ'},
    's': {'š', 'ś', 'ŝ', 'ș', 'ş'},
    'S': {'Š', 'Ś', 'Ŝ', 'Ș', 'Ş'},
    'l': {'ł'},
    'L': {'Ł'},
    'n': {'ñ', 'ń'},
    'N': {'Ñ', 'Ń'},
    't': {'ț'},
    'T': {'Ț'},
    'y': {'ÿ', 'ý'},
    'Y': {'Ÿ', 'Ý'},
    'z': {'ž', 'ź', 'ż'},
    'Z': {'Ž', 'Ź', 'Ż'},
    'oe': {'œ'},
    'OE': {'Œ'},
    'ae': {'æ'},
    'AE': {'Æ'}
  });

  /// Caracteres com acentos
  final RegExp regExpAccentedCharacters = RegExp('[À-ž]', multiLine: true);

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

final DartDevUtils dartDevUtils = DartDevUtils();

/// Modo execução da aplicação
const bool isRunProfileMode_ = bool.fromEnvironment('dart.vm.profile');
const bool isRunReleaseMode_ = bool.fromEnvironment('dart.vm.product');
const bool isRunDebugMode_ = !isRunReleaseMode_ && !isRunProfileMode_;

enum PasswordType {
  onlyNumbers,
  onlyCapitalLetters,
  onlyLowerCaseLetters,
  upperLowerCaseLetters,
  numbersLetters,
  characterMix
}

enum NumericBase { binary, octal, hexadecimal, duotrigesimal }
