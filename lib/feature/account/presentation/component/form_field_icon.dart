import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FormFieldIcon extends StatelessWidget {
  const FormFieldIcon({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: AppColors.accent,
      size: 16,
    );
  }
}
