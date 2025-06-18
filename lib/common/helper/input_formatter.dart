import 'package:flutter/services.dart';

class InputFormatter {
  const InputFormatter._();

  static final decimal = FilteringTextInputFormatter.allow(
    RegExp(r'^\d*\.?\d{0,2}'),
  );
}
