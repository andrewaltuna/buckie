import 'package:flutter/services.dart';

class HapticFeedbackHelper {
  const HapticFeedbackHelper._();

  /// Used for actions like tapping toggles or minor buttons.
  static void light() => HapticFeedback.selectionClick();

  /// Used for actions like tapping major action buttons.
  static void heavy() => HapticFeedback.lightImpact();
}
