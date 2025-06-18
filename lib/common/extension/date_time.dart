import 'package:intl/intl.dart';

extension DateTimeHelper on DateTime {
  String dayOfWeek({bool shortened = false}) {
    if (shortened) {
      return DateFormat('EEE').format(this);
    }
    return DateFormat('EEEE').format(this);
  }
}
