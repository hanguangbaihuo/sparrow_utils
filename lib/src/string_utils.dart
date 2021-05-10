import 'dart:math' show min, max;

class SPStringUtils {
  static bool isValidPhone(String input) {
    return input.startsWith('1') && input.length == 11;
  }

  static bool isNullOrBlank(String? content) =>
      content == null || content.isEmpty;

  static String getMaskPhone(String input) {
    if (!isValidPhone(input)) return '手机号不合法';
    return input.replaceAllMapped(
        RegExp(r'(\d{3})\d{4}(\d{4})'), (Match m) => '${m[1]}****${m[2]}');
  }

  static int getLCS(String a, String b) {
    // a.length行，b.length列
    int aLen = a.length;
    int bLen = b.length;
    List<List<int>> matrix = List<List<int>>.generate(
      aLen + 1,
      (index) => List<int>.generate(bLen + 1, (index) => 0),
    );

    int result = 0;
    for (int i = 0; i < aLen; i++) {
      for (int j = 0; j < b.length; j++) {
        if (a[i] == b[j]) {
          matrix[i + 1][j + 1] = matrix[i][j] + 1;
          result = max(result, matrix[i + 1][j + 1]);
        }
      }
    }

    return result;
  }

  static int getEditDistance(String a, String b) {
    int aLen = a.length;
    int bLen = b.length;
    List<List<int>> matrix = List<List<int>>.generate(
      aLen + 1,
      (index) => List<int>.generate(bLen + 1, (index) => 0),
    );

    //new int[a.length()+1][b.length()+1];
    for (int i = 1; i <= aLen; i++) matrix[i][0] = i;
    for (int j = 1; j <= bLen; j++) matrix[0][j] = j;
    for (int i = 1; i < aLen + 1; i++) {
      for (int j = 1; j < bLen + 1; j++) {
        int left = matrix[i - 1][j] + 1;
        int down = matrix[i][j - 1] + 1;
        int leftDown = matrix[i - 1][j - 1];
        if (a[i - 1] != b[j - 1]) leftDown += 1;
        matrix[i][j] = min(left, min(down, leftDown));
      }
    }
    return matrix[aLen][bLen];
  }
}
