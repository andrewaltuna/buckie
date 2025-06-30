import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // General
  static const fontPrimary = Color(0xFFFFFFFF);
  static const fontSecondary = Color(0xFF8E8E93);
  static const fontDisabled = Color(0xFF5A5A60);
  static const fontWarning = Color(0xFFF45B69);
  static const defaultBackground = Color(0xFF11151c);
  static const widgetBackgroundPrimary = Color(0xFF151B25);
  static const widgetBackgroundSecondary = Color(0xFF19212E);
  static const widgetBackgroundTertiary = Color(0xFF212C3D);
  static const accent = Color(0xFF7BF1A8);
  static const shadow = Color(0x33000000);

  // Button
  static const fontButtonPrimary = defaultBackground;
  static const fontButtonSecondary = accent;
  static const buttonBackgroundPrimary = accent;
  static const buttonBackgroundSecondary = widgetBackgroundPrimary;

  // Table Colors
  static const tableHeaderBackground = widgetBackgroundSecondary;
  static const tableRow = widgetBackgroundTertiary;
  static const tableRowAlt = Color(0xFF1D2736);

  // Category Colors
  static const categoryMagenta = Color(0xFFFF006E);
  static const categoryYellow = Color(0xFFFFBE0B);
  static const categoryOrange = Color(0xFFFB5607);
  static const categoryBlue = Color(0xFF3A86FF);
  static const categoryPurple = Color(0xFF8338EC);
}
