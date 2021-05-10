import 'package:enum_to_string/enum_to_string.dart';
export 'package:enum_to_string/enum_to_string.dart';

class SPEnumUtils {
  static String convertToString(dynamic enumItem) {
    return EnumToString.convertToString(enumItem);
  }

  static T? fromString<T>(List<T> enumValues, String str) {
    return EnumToString.fromString<T>(enumValues, str);
  }
}
