import 'dart:async' show StreamController, StreamSubscription, FutureOr, Timer;
import 'package:dependency_manager/dependency_manager.dart' show Disposeble;
// import 'package:meta/meta.dart' show mustCallSuper;

import './exceptions.dart';

/// Este objeto foi criado para facilitar e externalizar a instância de uma [StreamController]
/// deixando dentro da app apenas os códigos necessários
class DataStream<O> implements Disposeble {
  /// Criar uma instância [StreamController] e suas propriedades
  ///
  /// Este objeto pode ser combinado com qualquer objeto que usa uma stream, no flutter [StreamBuilder]
  ///
  /// Ao usar esse objeto, devemos se atentar em chamar o método [dispose] quando o objeto não tiver utilidade
  ///
  /// O tipo genérico [O] irá assumir o tipo de dado passado como parâmentro, caso o tipo de dado não seja
  /// definido, o dado será do tipo [dynamic]
  ///
  /// Os construtores, devem ser um construtor comum ou nomeados ao invés de
  /// construtores tipo factory, sendo assim, outros objetos podem herdar a mesma[DataStream] e
  /// instância-lá usando a propriedade [super]

  final StreamController<O> _streamController;
  final List<O> _listValues;

  /// Se essa propriedade[saveAllData] for [true], significa que todos os valores da stream ficaram armazenados
  /// dentro do objeto [_listValues], se [false], será armazenado apenas o valor inicial e o último valor [firstObject, lastObject]
  final bool saveAllData;

  /// Construtor com valor inicial para uma StreamController não broadcast
  DataStream(O initialValue,
      {this.saveAllData = false,
      void Function()? onListen,
      void Function()? onPause,
      void Function()? onResume,
      FutureOr<void> Function()? onCancel,
      bool sync = false})
      : _streamController = StreamController<O>(
                onListen: onListen,
                onPause: onPause,
                onResume: onResume,
                onCancel: onCancel,
                sync: sync)
            .setInitialValue(initialValue),
        _listValues = [initialValue];

  /// Construtor com valor inicial para uma StreamController broadcast
  DataStream.broadcast(O initialValue,
      {this.saveAllData = false,
      void Function()? onListen,
      FutureOr<void> Function()? onCancel,
      bool sync = false})
      : _streamController = StreamController<O>.broadcast(
                onListen: onListen, onCancel: onCancel, sync: sync)
            .setInitialValue(initialValue),
        _listValues = [initialValue];

  /// Construtor sem valor inicial para uma StreamController não broadcast
  DataStream.noInitialValue(
      {this.saveAllData = false,
      void Function()? onListen,
      void Function()? onPause,
      void Function()? onResume,
      FutureOr<void> Function()? onCancel,
      bool sync = false})
      : _streamController = StreamController<O>(
            onListen: onListen,
            onPause: onPause,
            onResume: onResume,
            onCancel: onCancel,
            sync: sync),
        _listValues = [];

  /// Construtor sem valor inicial para uma StreamController broadcast
  DataStream.noInitialValueBroadcast(
      {this.saveAllData = false,
      void Function()? onListen,
      FutureOr<void> Function()? onCancel,
      bool sync = false})
      : _streamController = StreamController<O>.broadcast(
            onListen: onListen, onCancel: onCancel, sync: sync),
        _listValues = [];

  Timer? _timer;

  /// Este objeto[DataStream.periodic] foi criado para substituir o objeto [Stream.periodic].
  ///
  /// Com ele, temos mais recursos e nos possibilita disposar o mesmo
  factory DataStream.periodic(
      {required Duration duration,
      required FutureOr<void> Function(DataStream<O>, int) callBack,
      void Function()? onListen,
      FutureOr<void> Function()? onCancel,
      bool saveAllData = false,
      bool sync = false}) {
    // Exemplo de uso
    /*
      final DataStream<int> dataStream = DataStream.periodic(
        duration: const Duration(seconds: 1), 
        callBack: (dataStream, tick) {

          if (tick >= 21) { // imprimir intervalos 0 - 5 e 10 - 20
            dataStream.dispose();
          } else if(tick >= 6 && tick <= 9) { // não imprimir os intervalos 6 - 9
            print('---- não fazer nada ----');
          } else {
            dataStream.value = tick;
          }

        },
        onListen: (){
          print('---- Um listen foi iniciado ----');
        },
        onCancel: (){
          print('---- Stream cancelada/disposada ----');
        }
      );

      dataStream.stream.listen((value) {

        print('---- listen valeu: $value ----');
      
      }).selfCancel(dataStream);
    */

    return DataStream<O>.noInitialValueBroadcast(
            onListen: onListen,
            onCancel: onCancel,
            saveAllData: saveAllData,
            sync: sync)
        ._callbackPeriodic(duration: duration, callBack: callBack);
  }

  /// Este objeto[DataStream.periodicWithInitialValue] foi criado para
  /// substituir o objeto [Stream.periodic].
  ///
  /// Com ele, temos mais recursos e nos possibilita disposar o mesmo
  factory DataStream.periodicWithInitialValue(
      {required O initialValue,
      required Duration duration,
      required FutureOr<void> Function(DataStream<O>, int) callBack,
      void Function()? onListen,
      FutureOr<void> Function()? onCancel,
      bool saveAllData = false,
      bool sync = false}) {
    // Exemplo de uso
    /*
      final DataStream<int> dataStream = DataStream.periodicWithInitialValue(
        initialValue: 0,
        duration: const Duration(seconds: 1), 
        callBack: (dataStream, tick) {

          if (tick >= 21) { // imprimir intervalos 0 - 5 e 10 - 20
            dataStream.dispose();
          } else if(tick >= 6 && tick <= 9) { // não imprimir os intervalos 6 - 9
            print('---- não fazer nada ----');
          } else {
            dataStream.value = tick;
          }

        },
        onListen: (){
          print('---- Um listen foi iniciado ----');
        },
        onCancel: (){
          print('---- Stream cancelada/disposada ----');
        }
      );

      dataStream.stream.listen((value) {

        print('---- listen valeu: $value ----');
      
      }).selfCancel(dataStream);
    */

    return DataStream<O>.broadcast(initialValue,
            onListen: onListen,
            onCancel: onCancel,
            saveAllData: saveAllData,
            sync: sync)
        ._callbackPeriodic(duration: duration, callBack: callBack);
  }

  StreamController<O> get streamController => _streamController;
  Stream<O> get stream => _streamController.stream;

  List<O> get values => [..._listValues];

  O get value => _listValues.isNotEmpty
      ? _listValues.last
      : throw DataStreamError(
          'Nenhum valor encontrado, use um construtor com um valor inicial ou insira um valor usando o método(value) set antes de obter o último valor');

  /// Embora a [streamController] está acessível neste objeto, para manter
  /// a variável [_listValues] sempre atualizada é indipensável sempre
  /// atribuir um valor usando os métodos [set]
  set value(O newValue) {
    _streamController.sink.add(newValue);

    if (saveAllData || _listValues.length <= 1) {
      _listValues.add(newValue);
    } else {
      // _listValues.setRange(1, 2, [newValue]);
      _listValues.replaceRange(1, 2, [newValue]);
    }
  }

  /// Atualizar o valor se o novo valor for diferente do valor atual
  set nonIdencalValue(O newValue) {
    try {
      if (!identical(value, newValue)) value = newValue;
    } on DataStreamError {
      value = newValue;
    }
  }

  /// Através dessa variável será possível cancelar as listeners
  /// desde que, o método [selfCancel] seja chamado quando a listen
  /// for assinada
  ///
  /// Ex:
  ///   StreamSubscription listen = anyObject.stream.listen((value) {
  ///     print('---- listen: $value ----');
  ///   }).selfcancel(anyObject);
  ///
  final List<StreamSubscription> _listListeners = [];

  /// Disposar todos os objetos necessários que compõe o objeto[DataStream]
  ///
  /// Objetos: [StreamController], [StreamSubscription], [Timer], [List]
  // @mustCallSuper
  @override
  void dispose() {
    _timer?.cancel();
    for (var listen in _listListeners) {
      listen.cancel();
    }
    _listListeners.clear();
    _listValues.clear();
    _streamController.sink.close();
    _streamController.close();
  }
}

extension ListenerAutoCancel on StreamSubscription {
  /// Cancelar automaticamente essa listen[StreamSubscription] quando
  /// o objeto[DataStream] for disposado
  StreamSubscription selfCancel<O extends DataStream>(O dataStream) {
    dataStream._listListeners.add(this);
    return this;
  }
}

extension _CallbackPeriodic<O> on DataStream<O> {
  /// Função que será chamada periodicamente para enviar dados para as listeners[StreamSubscription]
  /// os usando uma [StreamController]
  DataStream<O> _callbackPeriodic(
      {required Duration duration,
      required FutureOr<void> Function(DataStream<O>, int) callBack}) {
    _timer = Timer.periodic(duration, (timer) {
      callBack(this, timer.tick);
    });
    return this;
  }
}

extension SetInitialValue<O> on StreamController<O> {
  StreamController<O> setInitialValue(O value) {
    sink.add(value);
    return this;
  }
}
