import 'package:test/test.dart';

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
}
