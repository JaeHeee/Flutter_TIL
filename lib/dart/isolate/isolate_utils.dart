import 'dart:isolate';

class IsolateUtils {
  late Isolate _isolate;
  late SendPort _sendPort;
  late ReceivePort _receivePort;

  SendPort get sendPort => _sendPort;

  Future<void> initIsolate() async {
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn<SendPort>(
      _entryPoint,
      _receivePort.sendPort,
    );

    _sendPort = await _receivePort.first;
  }

  static void _entryPoint(SendPort mainSendPort) async {
    final childReceivePort = ReceivePort();
    mainSendPort.send(childReceivePort.sendPort);

    await for (final _IsolateData isolateData in childReceivePort) {
      final results = await isolateData.handler(isolateData.params);

      isolateData.responsePort.send(results);
    }
  }

  void sendMessage(
    Function handler,
    SendPort sendPort,
    ReceivePort responsePort, {
    dynamic params,
  }) {
    final isolateData = _IsolateData(
      handler,
      params,
      responsePort.sendPort,
    );
    sendPort.send(isolateData);
  }

  void dispose() {
    _receivePort.close();
    _isolate.kill(priority: Isolate.immediate);
  }
}

class _IsolateData {
  Function handler;
  dynamic params;
  SendPort responsePort;

  _IsolateData(
    this.handler,
    this.params,
    this.responsePort,
  );
}
