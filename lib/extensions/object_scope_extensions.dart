import 'package:flutter/material.dart';

extension ObjectScopeExtensions<T, R> on T {
  R let(R Function(T) callback) => callback(this);

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
