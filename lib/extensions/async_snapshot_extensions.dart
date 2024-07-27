library fluf;

import 'package:flutter/material.dart';

extension AsyncSnapshotExtensions on AsyncSnapshot {
  bool isReady() => isComplete() && hasData && !hasError;

  bool isLoading() => connectionState == ConnectionState.waiting;

  bool isComplete() => connectionState == ConnectionState.done;
}
