import 'package:flutter/services.dart';

class TitleCaseFormatter extends TextInputFormatter {
  final _pattern = RegExp(r'(^\w)|(\s\w)');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.toLowerCase();

    text = text.replaceAllMapped(_pattern, (match) {
      return match.group(0)!.toUpperCase();
    });

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
