class DartDevUtilsExeception implements Exception {
  final String message;

  DartDevUtilsExeception(this.message);

  @override
  String toString() => message;

  /// Gerar um erro se o valor for nulo
  static O generateErrorIfValueIsNull<O>(O? value, {required String message}) {
    if (value == null) throw DartDevUtilsExeception(message);
    return value;
  }
}

// extension SendExeception on DartDevUtilsExeception{
//   // Enviar exeception para o registro de erros da app
//   void sendExeception(){}
// }

class GetValueFromKeyException extends DartDevUtilsExeception {
  GetValueFromKeyException(String message) : super(message);
}

class DataStreamError extends DartDevUtilsExeception {
  DataStreamError(String message) : super(message);
}

class FirstWhereMultComputationException extends DartDevUtilsExeception {
  FirstWhereMultComputationException(String message) : super(message);
}
