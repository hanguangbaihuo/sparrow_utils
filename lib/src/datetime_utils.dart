import 'package:flutter/material.dart';

import 'package:intl/intl.dart' show DateFormat;
export 'package:intl/intl.dart' show DateFormat;

import 'package:time/time.dart';
export 'package:time/time.dart';

/// DateTime的工具库
class SPDateUtils {
  /// 常用日期格式
  static const String FORMAT_YYYY_MM_DD = "yyyy-MM-dd";

  ///
  static const String FORMAT_YYYYMMDD_HHMMSS = "yyyy-MM-dd HH:mm:ss";
  static const String FORMAT_MMDD_HHMM = "MM-dd HH:mm";

  ///
  static const String FORMAT_T_YYYYMMDD = "yyyy-MM-ddTHH:mm:ss";
  static const String FORMAT_T_YYYYMMDD_SSSSSS = "yyyy-MM-ddTHH:mm:ss.SSSSSS";

  /// 格式化日期时间
  ///
  /// 默认格式是yyyy-MM-dd HH:mm:ss
  static String? format(DateTime? dt,
      [String formatString = 'yyyy-MM-dd HH:mm:ss']) {
    if (dt == null) return null;

    return DateFormat(formatString, "zh_CN").format(dt);
  }

  /// 通过字符串获得格式化的字符串
  ///
  /// 如果字符串不合法，返回null
  static String? formatFromString(String formattedString,
      [String formatString = 'yyyy-MM-dd HH:mm:ss']) {
    final dt = DateTime.tryParse(formattedString);

    if (dt == null) return null;

    return DateFormat(formatString, "zh_CN").format(dt);
  }

  // ************************ 今天 ************************ //

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

  // ************************ 昨天 ************************ //

  /// 获得昨天的时间间隔
  static DateTimeRange get yesterday {
    // 今天的0时，是昨天的结束时间

    return DateTimeRange(
      start: todayStart - 1.days,
      end: todayStart,
    );
  }

  // ************************ 月份 ************************ //

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

  // ************************ 年份 ************************ //
  /// 获得今年的时间间隔
  static DateTimeRange get thisYear =>
      DateTimeRange(start: thisYearStart, end: todayEnd);

  ///今年1月1日
  static DateTime get thisYearStart {
    final now = DateTime.now();
    return DateTime(now.year, 1, 1, 0, 0, 0);
  }

  /// 格式化时间：日期 星期 时分秒
  static String formatWithWeek(String? time) {
    return DateFormat('yyyy-MM-dd EEEE HH:mm:ss', "zh_CN")
        .format(DateTime.parse(time ?? '').toLocal());
  }

  /// 格式化时间：日期 时分秒
  static String defaultFormatDate(String? time) {
    if (time == null || time.isEmpty) return '';
    return DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(DateTime.parse(time).toLocal());
  }

  static String dateTimeNowIso() => DateTime.now().toIso8601String();

  static int dateTimeNowMilli() => DateTime.now().millisecondsSinceEpoch;

  /// 获得相对时间
  static String getRelativeFormat(DateTime? dt, {bool withTime = false}) {
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

  /// 格式化聊天列表页的时间
  static String? formatChatListTime(String? time) {
    if (time == null || time == '') return "";

    /// 获取当前时间
    DateTime now = new DateTime.now();
    DateTime tempDate = DateFormat(SPDateUtils.FORMAT_T_YYYYMMDD).parse(time);

    /// 当天，返回时间，例如：14:26
    if (SPDateUtils.format(now, SPDateUtils.FORMAT_YYYY_MM_DD) ==
        SPDateUtils.format(tempDate, SPDateUtils.FORMAT_YYYY_MM_DD)) {
      return SPDateUtils.format(tempDate, "HH:mm");
    }

    /// 前一天，返回“昨天”
    if (SPDateUtils.format(now - 1.days, SPDateUtils.FORMAT_YYYY_MM_DD) ==
        SPDateUtils.format(tempDate, SPDateUtils.FORMAT_YYYY_MM_DD)) {
      return SPDateUtils.format(tempDate, "昨天");
    }

    /// 当年，返回 02-03
    if (SPDateUtils.format(now, 'yyyy') ==
        SPDateUtils.format(tempDate, 'yyyy')) {
      return SPDateUtils.format(tempDate, 'MM-dd');
    }

    /// 非当年 返回 2021-07-14
    return SPDateUtils.format(tempDate, SPDateUtils.FORMAT_YYYY_MM_DD);
  }

  ///yyyy-MM-ddTHH:mm:ss.SSSSSS
  static String dateFormatTDate(String outFormatStr, String? value) {
    String formatted = "";
    try {
      DateTime tempDate =
          new DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS").parse('$value');
      final DateFormat formatter = DateFormat(outFormatStr);
      formatted = formatter.format(tempDate);
    } catch (e) {}

    return formatted;
  }

  ///date format
  ///@param value 输入日期
  ///@param inFormatStr 输入日期格式化
  ///@param outFormatStr 输出日期格式化
  static String dateFormat(
      String value, String inFormatStr, String outFormatStr) {
    String formatted = "";
    try {
      DateTime tempDate = new DateFormat(inFormatStr).parse('$value');
      final DateFormat formatter = DateFormat(outFormatStr);
      formatted = formatter.format(tempDate);
    } catch (e) {}

    return formatted;
  }
}
