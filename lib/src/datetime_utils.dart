import 'package:flutter/material.dart';

import 'package:intl/intl.dart' show DateFormat;
export 'package:intl/intl.dart' show DateFormat;

import 'package:time/time.dart';
export 'package:time/time.dart';

/// DateTime的工具库
class SPDateUtils {
  /// 格式化日期时间
  ///
  /// 默认格式是yyyy-MM-dd HH:mm:ss
  static String? format(DateTime? dt, [String format = 'yyyy-MM-dd HH:mm:ss']) {
    if (dt == null) return null;

    return DateFormat(format, "zh_CN").format(dt);
  }

  /// 通过字符串获得格式化的字符串
  ///
  /// 如果字符串不合法，返回null
  static String? formatFromString(String formattedString,
      [String format = 'yyyy-MM-dd HH:mm:ss']) {
    final dt = DateTime.tryParse(formattedString);

    if (dt == null) return null;

    return DateFormat(format, "zh_CN").format(dt);
  }

  /// 今天0时
  static DateTime get todayStart {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 0, 0, 0);
  }

  /// 今日24时
  static DateTime get todayEnd => todayStart + 1.days;

  /// 获得今天的时间间隔
  static DateTimeRange get today =>
      DateTimeRange(start: todayStart, end: todayEnd);

  /// 获得昨天的时间间隔
  static DateTimeRange get yesterday {
    // 今天的0时，是昨天的结束时间

    return DateTimeRange(
      start: todayStart - 1.days,
      end: todayStart,
    );
  }

  /// 本月起始时刻，本月1日0时，也是上月结束时刻
  static DateTime get thisMonthStart {
    final now = DateTime.now();

    // 今天的0时，是昨天的结束时间
    return DateTime(now.year, now.month, 1, 0, 0, 0);
  }

  /// 上月结束时刻，是本月的起始时刻
  static DateTime get lastMonthEnd => thisMonthStart;

  /// 上个月起始时刻，上月1日0时
  static DateTime get lastMonthStart {
    final now = DateTime.now();
    var year = now.year;
    var month = now.month;
    if (month == 1) {
      // 如果当前是1月份，上月为去年12月份
      year = year - 1;
      month = 12;
    } else {
      // 否则上月等于本月-1
      month = month - 1;
    }

    return DateTime(year, month, 1, 0, 0, 0);
  }

  /// 本月的结束时刻，也是下个月的起始时刻
  static DateTime get thisMonthEnd {
    // 因为不确定本月有多少天，我们计算下个月的开始时间
    final now = DateTime.now();
    var year = now.year;
    var month = now.month;
    if (month == 12) {
      // 如果当前是12月份，下个月是明年1月
      year = year + 1;
      month = 1;
    } else {
      // 否则下个月等于本月 + 1
      month = month + 1;
    }

    return DateTime(year, month, 1, 0, 0, 0);
  }

  /// 获得本月的时间间隔（本月时间）
  static DateTimeRange get thisMonth =>
      DateTimeRange(start: thisMonthStart, end: thisMonthEnd);

  /// 获得上月的时间间隔
  static DateTimeRange get lastMonth =>
      DateTimeRange(start: lastMonthStart, end: thisMonthStart);

  /// 格式化时间：日期 星期 时分秒
  static String formatWithWeek(String? time) {
    return DateFormat('yyyy-MM-dd EEEE HH:mm:ss', "zh_CN")
        .format(DateTime.parse(time ?? '').toLocal());
  }

  /// 格式化时间：日期 时分秒
  static String defaultFormatDate(String time) {
    if (time == null || time.isEmpty) return '';
    return DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(DateTime.parse(time).toLocal());
  }

  static String dateTimeNowIso() => DateTime.now().toIso8601String();

  static int dateTimeNowMilli() => DateTime.now().millisecondsSinceEpoch;

  /// 获得相对时间
  static String getRelativeFormat(DateTime dt, {bool withTime = false}) {
    // 格式化最后一条消息的显示时间
    // 如果是当天的信息，只显示具体时分；
    // 否则，如果是当年的信息，显示年月；
    // 其他情况显示年月日；
    if (dt == null) return '';

    if (dt.isToday) {
      // 今天
      return DateFormat('HH:mm').format(dt);
    } else if (dt.year == DateTime.now().year) {
      // 今年
      var formatStr = 'MM月dd日';
      if (withTime) formatStr += ' HH:mm';
      return DateFormat(formatStr).format(dt);
    } else {
      // 今年以前
      var formatStr = 'yyyy年MM月dd日';
      if (withTime) formatStr += ' HH:mm';
      return DateFormat(formatStr).format(dt);
    }
  }
}
