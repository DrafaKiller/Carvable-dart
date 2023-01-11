extension NullIterable<T> on Iterable<T?> {
	Iterable<T> whereNotNull() => whereType<T>();
}