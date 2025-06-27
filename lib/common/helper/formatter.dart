import 'package:intl/intl.dart';

class Formatter {
  const Formatter._();

  static String currency(num num, {int decimalDigits = 2}) {
    return NumberFormat.currency(
      symbol: '',
      decimalDigits: decimalDigits,
    ).format(num);
  }

  static String date(
    DateTime date, {
    bool includeMonth = true,
    bool includeDay = true,
    bool includeYear = true,
  }) {
    final monthSeparator = includeDay || includeYear ? ' ' : '';
    final daySeparator = includeDay && includeYear ? ', ' : '';

    final month = includeMonth ? 'MMM$monthSeparator' : '';
    final day = includeDay ? 'dd$daySeparator' : '';
    final year = includeYear ? 'yyyy' : '';

    return DateFormat('$month$day$year').format(date);
  }

  static String percentage(
    double value, {
    int decimalDigits = 2,
  }) {
    return NumberFormat.percentPattern().format(value);
  }
}
