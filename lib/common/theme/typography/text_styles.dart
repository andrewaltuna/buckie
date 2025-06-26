import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  const TextStyles._();

  static const _fontFamilyPrimary = Constants.fontFamilyPrimary;
  static const _fontFamilySecondary = Constants.fontFamilySecondary;

  // Font Primary
  static const titleMedium = TextStyle(
    fontFamily: _fontFamilyPrimary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.fontPrimary,
  );

  static const titleRegular = TextStyle(
    fontFamily: _fontFamilyPrimary,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.fontPrimary,
  );

  static const titleSmall = TextStyle(
    fontFamily: _fontFamilyPrimary,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.fontPrimary,
  );

  static const titleExtraSmall = TextStyle(
    fontFamily: _fontFamilyPrimary,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.fontPrimary,
  );

  static const labelMedium = TextStyle(
    fontFamily: _fontFamilyPrimary,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.fontPrimary,
  );

  static const labelRegular = TextStyle(
    fontFamily: _fontFamilyPrimary,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.fontPrimary,
  );

  static const labelSmall = TextStyle(
    fontFamily: _fontFamilyPrimary,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.fontPrimary,
  );

  // Font Secondary
  // General
  static const bodyMedium = TextStyle(
    fontFamily: _fontFamilySecondary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.fontPrimary,
  );

  static const bodyRegular = TextStyle(
    fontFamily: _fontFamilySecondary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.fontPrimary,
  );

  static const bodySmall = TextStyle(
    fontFamily: _fontFamilySecondary,
    fontSize: 12,
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
