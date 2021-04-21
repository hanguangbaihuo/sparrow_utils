class SPCollectionUtils {
  /// map
  /// * E - 输入参数类型
  /// * T - 输出参数类型
  static Iterable<E> map<E, T>(
      Iterable<T> items, E Function(int index, T item) fn) sync* {
    var index = 0;

    for (final item in items) {
      yield fn(index, item);
      index = index + 1;
    }
  }

  /// join，一个类型的元素列表，在每个元素之间插入同一个元素
  static List<E> join<E>(List<E> list, E split) {
    List<E> result = [];
    for (int ii = 0; ii < list.length; ii++) {
      result.add(list[ii]);
      result.add(split);
    }

    if (result.length > 0) {
      result.removeLast();
    }

    return result;
  }
}
