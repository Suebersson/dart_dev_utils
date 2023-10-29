typedef CheckedEmail = ({bool isValid, String message});

extension EmailAttributes on String {
  CheckedEmail get checkIfIsEmail => Email(this).check;

  Email get email => Email(this);

  /// verificar se a string é endereço de e-mail é válida
  bool get isEmail => Email(this).check.isValid;
}

/// Classe funcional para tratar endereços de e-mail
class Email {
  const Email._({required this.address, required this.regExpForEmails});

  factory Email(String address) {
    return Email._(address: address, regExpForEmails: regExpForEmailsInternal);
  }

  factory Email.fromRegExp(
      {required String address, required RegExp regExpForEmails}) {
    return Email._(address: address, regExpForEmails: regExpForEmails);
  }

  final String address;
  final RegExp regExpForEmails;

  // expressões anteriores:
  //
  // static final RegExp regExpForEmailsInternal = RegExp('^[a-z0-9_.-]+(@[a-z0-9-]{2,})+(.[a-z]{2,}.[a-z]{2,}.[a-z]{2,}.[a-z]{2,}|.[a-z]{2,}.[a-z]{2,}.[a-z]{2,}|.[a-z]{2,}.[a-z]{2,}|.[a-z]{2,})\$');
  //
  // static final RegExp regExpForEmailsInternal = RegExp(
  //   r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
  //
  /// Expressão para testar e verificar se uma string se enquada num
  /// padrão de endereço de e-mail
  static final RegExp regExpForEmailsInternal =
      RegExp('^[a-z0-9_.-]*@[a-z0-9]+[.a-z]{2,}\$');

  /// Todos os caracteres permitidos
  static final RegExp allowedCharacters = RegExp(r'[a-z0-9_.@-]');

  /// Caracteres especiais permitidos
  static final RegExp specialCharactersAllowed = RegExp(r'[_.@-]');

  /// Caracteres alfabeticos permitidos
  static final RegExp allowedAlphabeticCharacters = RegExp(r'[a-z]');

  // Caracteres especiais que compõe um email repetidos numa string
  static final RegExp repeatedCharacters = RegExp(r'[.|-|_|@]{2,}');

  /// Verificar se o endereço se enquadra no padrão de e-mail
  CheckedEmail get check {
    if (address.isEmpty) {
      return (isValid: false, message: 'informe um e-mail');
    } else if (address.contains(' ') ||
        repeatedCharacters.hasMatch(address) ||
        !regExpForEmails.hasMatch(address) ||
        !allowedAlphabeticCharacters.hasMatch(address[0]) ||
        !allowedAlphabeticCharacters.hasMatch(address[address.length - 1])) {
      return (isValid: false, message: 'informe um endereço de e-mail válido');
    } else {
      return (isValid: true, message: 'endereço de e-mail válido');
    }
  }

  /// Verificar se a string é um e-mail
  bool isEmail(String email) => Email(email).check.isValid;

  String get domain {
    if (address.isEmpty) {
      return address;
    } else {
      return address.split('@').last;
    }
  }

  String get domainName {
    if (address.isEmpty) {
      return address;
    } else {
      return RegExp(r'@\w+.')
              .stringMatch(address)
              ?.replaceAll(RegExp('[@|.]'), '') ??
          '';
    }
  }

  String get id {
    if (address.isEmpty) {
      return address;
    } else {
      return address.split('@').first;
    }
  }

  /// Ocultar parcialmente os caracteres mantendo quantidade de caracteres no texto de email
  static String partialObscureText(String email) {
    for (int i = 0; i < email.length; i++) {
      if (i > 2 && email[i] != '@') {
        email = email.replaceRange(i, i + 1, '*');
      } else if (email[i] == '@') {
        break;
      }
    }
    return email;
  }

  /// Ocultar parcialmente um intervalo de caracteres no texto de email
  static String partialObscureTextFromRange(String email) {
    return email.replaceRange(2, email.indexOf('@') - 1, '********');
  }
}
