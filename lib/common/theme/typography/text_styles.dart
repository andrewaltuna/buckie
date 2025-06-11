import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  const TextStyles._();

  static const _fontFamilyPrimary = Constants.fontFamilyPrimary;
  static const _fontFamilySecondary = Constants.fontFamilySecondary;

  // Font Primary
  static const title = TextStyle(
    fontFamily: _fontFamilyPrimary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.fontPrimary,
  );

  static const label = TextStyle(
    fontFamily: _fontFamilyPrimary,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.fontPrimary,
  );

  // Font Secondary
  // General
  static const body = TextStyle(
    fontFamily: _fontFamilySecondary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.fontPrimary,
  );

  // Text Field
  static const textFieldWarning = TextStyle(
    fontFamily: _fontFamilySecondary,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.fontWarning,
  );

  // Button
  static const btnPrimary = TextStyle(
    fontFamily: _fontFamilySecondary,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.defaultBackground,
  );
}
