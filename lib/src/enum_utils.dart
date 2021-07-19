import 'package:enum_to_string/enum_to_string.dart';
export 'package:enum_to_string/enum_to_string.dart';

class SPEnumUtils {
  /// 将枚举类型转成字符串
  static String convertToString(dynamic enumItem, {bool camelCase = false}) {
    return EnumToString.convertToString(enumItem, camelCase: camelCase);
  }

  /// 通过字符串获得枚举值
  static T? fromString<T>(List<T> enumValues, String? str) {
    if (str == null) return null;

    return EnumToString.fromString<T>(enumValues, str);
  }
}
