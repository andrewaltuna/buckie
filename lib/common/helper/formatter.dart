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
    bool includeDay = true,
    bool includeYear = true,
  }) {
    final day = includeDay ? 'dd' : '';
    final separator = includeDay && includeYear ? ', ' : '';
    final year = includeYear ? 'yyyy' : '';

    return DateFormat('MMM $day$separator$year').format(date);
  }

  static String percentage(
    double value, {
    int decimalDigits = 2,
  }) {
    return NumberFormat.percentPattern().format(value);
  }
}
