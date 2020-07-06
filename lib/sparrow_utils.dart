library sparrow_utils;

import 'package:intl/intl.dart' show DateFormat;

import 'package:enum_to_string/enum_to_string.dart';

export 'package:intl/intl.dart' show DateFormat;

class SPUtils {
  // map
  static Iterable<E> map<E, T>(
      Iterable<T> items, E Function(int index, T item) fn) sync* {
    var index = 0;

    for (final item in items) {
      yield fn(index, item);
      index = index + 1;
    }
  }

  // static get DateFormat => DateFormat;

  static formatDate(DateTime dt, String format) {
    return DateFormat(format).format(dt);
  }

  static String enumToString(enumItem) {
    return EnumToString.parse(enumItem);
  }

  static T enumFromString<T>(List<T> enumValues, String str) {
    return EnumToString.fromString(enumValues, str);
  }
}
