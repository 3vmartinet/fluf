import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

mixin ReceivePortMixin {
  final _receivePort = ReceivePort();
  SendPort get port => _receivePort.sendPort;

  Future<T?> waitForReceivedValue<T>() async {
    final completer = Completer<T?>();

    final subscription = _receivePort.listen((message) {
      log("Received $message");
      if (message is T) {
        log("Complete with $message");
        completer.complete(message);
      } else {
        completer.completeError(
          "Received message is not of type ${T.runtimeType} : $message",
        );
      }
    });

    return completer.future.then((value) {
      subscription.cancel();
      return value;
    });
  }
}
