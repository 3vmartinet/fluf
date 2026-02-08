import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart';

typedef IsolateWorkArgs = List<Object>;
typedef IsolateWork = FutureOr Function(dynamic);
typedef IsolateArgs = Map<String, dynamic>;
typedef IsolateCallback<T> = FutureOr<T> Function(IsolateArgs);

mixin IsolateMixin {
  var _receivePort = ReceivePort();
  Isolate? _isolate;

  SendPort get _port => _receivePort.sendPort;

  Future<T?> waitForReceivedValue<T>() async {
    final completer = Completer<T?>();

    final subscription = _receivePort.listen(
      (message) {
        debugPrint("Received $message");
        if (message is T) {
          debugPrint("Complete with $message");
          completer.complete(message);
        } else {
          completer.completeError(
            "Received message is not of type ${T.runtimeType} : $message",
          );
        }
      },
      cancelOnError: true,
    );

    return completer.future.then((value) {
      debugPrint("Cancel Isolate return value subscription");

      subscription.cancel();
      _receivePort.close();
      _isolate?.kill();
      _isolate = null;

      return value;
    });
  }

  Future<bool?> runIsolate(IsolateCallback callback, IsolateArgs args) async {
    final rootIsolateToken = RootIsolateToken.instance;

    if (rootIsolateToken == null) {
      debugPrint("Cannot get the RootIsolateToken");
      return null;
    }

    if (_isolate != null) {
      debugPrint("Isolate is already running");
      return false;
    }

    _receivePort.close();
    _receivePort = ReceivePort();

    _isolate = await Isolate.spawn(
      _wrapToIsolateWork(callback, args, rootIsolateToken, _port),
      [rootIsolateToken, _port],
    );

    return true;
  }

  IsolateWork _wrapToIsolateWork(
    IsolateCallback callback,
    IsolateArgs args,
    RootIsolateToken rootIsolateToken,
    SendPort sendPort,
  ) {
    return (_) async {
      BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

      final result = await callback(args);

      debugPrint("Send $result to port");
      sendPort.send(result);
    };
  }
}
