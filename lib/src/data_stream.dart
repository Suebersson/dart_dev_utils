import 'dart:async' show Stream, StreamController;
import 'package:meta/meta.dart' show mustCallSuper;
import 'disposeble.dart';

/// Este objeto foi criado para facilitar e externalizar a instância de uma [StreamController]
/// deixando dentro da app apenas os códigos necessários
class DataStream<T> implements Disposeble {
  /// Criar uma instância [StreamController] e suas propriedades
  ///
  /// Este objeto pode ser combinado com qualquer objeto que usa uma stream, no flutter [StreamBuilder]
  ///
  /// Ao usar esse objeto, devemos se atentar em chamar o método [dispose] quando o objeto não tiver utilidade
  ///
  /// variável genérica [dynamic]
  final T _initialValue;
  final StreamController<T> _streamController;

  /// Os construtores, devem ser um construtor comum e construtores nomeados ao invés de 
  /// construtores tipo factory, sendo assim, outros objetos podem herdar a mesma[DataStream] e
  /// instância-lá usando a propriedade [super]

  DataStream(this._initialValue) 
    : _streamController = StreamController<T>();

  DataStream.broadcast(this._initialValue) 
    : _streamController = StreamController<T>.broadcast();

  StreamController<T> get streamController => _streamController;
  Stream<T> get stream => _streamController.stream;//output

  T? _dataValue;

  T get value => _dataValue ?? _initialValue;

  /// Embora a [streamController] está acessível neste objeto, para manter
  /// a variável [_dataValue] sempre atualizada é indipensável sempre
  /// atribuir um valor usando esté método [set]
  set value(T newValue) {
    _streamController.sink.add(newValue);
    _dataValue = newValue;
  }

  @mustCallSuper
  @override
  void dispose() {
    _streamController.sink.close();
    _streamController.close();
  }

}


/*
  // Construtores factory
  DataStream._(this._initialValue, this._streamController);

  factory DataStream(T initialValue) {
    return DataStream<T>._(initialValue, StreamController<T>());
  }

  factory DataStream.broadcast(T initialValue) {
    return DataStream<T>._(initialValue, StreamController<T>.broadcast());
  }

*/
