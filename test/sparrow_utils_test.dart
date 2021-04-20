import 'package:test/test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sparrow_utils/sparrow_utils.dart';

enum Season { Spring, Summer, Autumn, Winter }

void main() {
  test('enum To String', () {
    assert(SPEnumUtils.convertToString(Season.Autumn) == 'Autumn');
  });

  test('String to Enum', () {
    assert(SPEnumUtils.fromString<Season>(Season.values, 'Spring') ==
        Season.Spring);
  });

  test('SPDateUtils.formatFromString', () {
    initializeDateFormatting();
    assert(SPDateUtils.formatFromString('2021-01-14T14:29:37.438596') ==
        '2021-01-14 14:29:37');
  });

  test('SPDateUtils.formatFromString', () {
    initializeDateFormatting();
    assert(SPDateUtils.formatFromString('29:37.438596') == null);
  });
}
