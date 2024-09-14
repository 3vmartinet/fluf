extension ScopeExtensions<T, R> on T {
  R let(R Function(T) callback) => callback(this);
}
