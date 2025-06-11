import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    required this.label,
    this.controller,
    this.errorText = '',
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.obscureText = false,
    this.icon,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final String errorText;
  final void Function(String value)? onChanged;
  final VoidCallback? onTap;
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
              style: TextStyles.label.copyWith(
                color: AppColors.accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: AppColors.widgetBackgroundSecondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: TextStyles.body,
            cursorWidth: 1,
            cursorColor: AppColors.accent,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              border: InputBorder.none,
            ),
            onTap: onTap,
            onChanged: onChanged,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ),
        const SizedBox(height: 3),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: errorText.isEmpty ? 0 : 1,
          child: Offstage(
            offstage: errorText.isEmpty,
            child: Row(
              children: [
                const Icon(
                  Icons.info,
                  color: AppColors.fontWarning,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  errorText,
                  style: TextStyles.textFieldWarning,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
