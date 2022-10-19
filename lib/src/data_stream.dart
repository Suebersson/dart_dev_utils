import 'dart:async' show Stream, StreamController;
import 'package:meta/meta.dart' show mustCallSuper;

/// Este objeto foi criado para facilitar e externalizar a instância de uma [StreamController]
/// deixando dentro da app apenas os códigos necessários
class DataStream<T> {
  /// Criar uma instância [StreamController] e suas propriedades
  ///
  /// Este objeto pode ser combinado com qualquer objeto que usa uma stream, no flutter [StreamBuilder]
  ///
  /// Ao usar esse objeto, devemos se atentar em chamar o método [dispose] quando o objeto não tiver utilidade
  ///
  /// variável generica [dynamic]
  final T _initialValue;

  final StreamController<T> streamController = StreamController<T>.broadcast();

  DataStream(this._initialValue) {
    streamController.stream.listen((value) {
      _dataValue = value;
    });
  }

  ///[input]
  Sink<T> get sink => streamController.sink;

  ///[output]
  Stream<T> get stream => streamController.stream;

  T? _dataValue;

  T get value => _dataValue ?? _initialValue;

  set value(T newValue) => sink.add(newValue);

  @mustCallSuper
  void dispose() {
    sink.close();
    streamController.close();
  }
}

abstract class DisposeDataStream {
  void dispose() {}
}
