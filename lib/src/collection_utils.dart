class SPColllectionUtils {
  // map
  static Iterable<E> map<E, T>(
      Iterable<T> items, E Function(int index, T item) fn) sync* {
    var index = 0;

    for (final item in items) {
      yield fn(index, item);
      index = index + 1;
    }
  }
}
