class FutureHolder {
  final List<Future> _futures = [];
  bool _disposed = false;

  bool isDisposed() => _disposed;

  Future add(Future future) {
    if (!_disposed) {
      _futures.add(future);
    } else {
      future.ignore();
    }

    return future;
  }

  void dispose() {
    _disposed = true;

    for (final element in _futures) {
      element.ignore();
    }

    _futures.clear();
  }
}
