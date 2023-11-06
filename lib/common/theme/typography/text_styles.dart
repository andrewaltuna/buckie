import 'package:expense_tracker/common/constants.dart';
import 'package:flutter/material.dart';

class TextStyles {
  const TextStyles._();

  static const _fontFamilyPrimary = Constants.fontFamilyPrimary;
  static const _fontFamilySecondary = Constants.fontFamilySecondary;

  /// Montserrat
  static const title = TextStyle(
    fontFamily: _fontFamilyPrimary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  /// Open Sans
  static const body = TextStyle(
    fontFamily: _fontFamilySecondary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
