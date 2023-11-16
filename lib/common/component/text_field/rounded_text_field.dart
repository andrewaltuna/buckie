import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    super.key,
    required this.label,
    this.errorText,
    this.keyboardType,
    this.obscureText = false,
    this.icon,
  });

  final String label;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 5),
            if (icon != null) ...[
              icon ?? const SizedBox.shrink(),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: TextStyles.body.copyWith(
                fontSize: 16,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Container(
          decoration: BoxDecoration(
            color: AppColors.widgetBackgroundSecondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: TextStyles.body,
            cursorWidth: 1,
            cursorColor: AppColors.accent,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              border: InputBorder.none,
            ),
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ),
        const SizedBox(height: 3),
        Opacity(
          opacity: errorText == null ? 0 : 1,
          child: Row(
            children: [
              const Icon(
                Icons.info,
                color: AppColors.fontWarning,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                errorText ?? '',
                style: TextStyles.body.copyWith(
                  color: AppColors.fontWarning,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
