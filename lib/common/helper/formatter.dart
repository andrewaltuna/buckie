import 'package:intl/intl.dart';

class Formatter {
  const Formatter._();

  static String formatNum(num num, {int decimalDigits = 2}) {
    return NumberFormat.currency(
      symbol: '',
      decimalDigits: decimalDigits,
    ).format(num);
  }
}
