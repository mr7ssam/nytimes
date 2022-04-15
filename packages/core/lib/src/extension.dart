extension IterableExt<T> on Iterable<T> {
  Iterable<T> superJoin(T separator) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return [];

    final _l = [iterator.current];
    while (iterator.moveNext()) {
      _l
        ..add(separator)
        ..add(iterator.current);
    }
    return _l;
  }
}
