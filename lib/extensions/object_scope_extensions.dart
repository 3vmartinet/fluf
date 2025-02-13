import 'dart:developer';

import 'package:flutter/material.dart';

extension ObjectScopeExtensions<T, R> on T {
  R let(R Function(T) callback) => callback(this);

  T also(void Function(T) callback) {
    callback(this);
    return this;
  }

  logType(String message) => log(message, name: runtimeType.toString());

  WidgetStateProperty<T> asWidgetStateProperty({Map<WidgetState, T>? states}) {
    return WidgetStateProperty.resolveWith((appliedStates) {
      for (final state in appliedStates) {
        if (states?.containsKey(state) == true) {
          return states?[state] ?? this;
        }
      }
      return this;
    });
  }
}
