import 'package:expense_tracker/common/enum/button_state.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.state = ButtonState.loading,
  });

  static const _loadingIndicatorSize = 15.0;

  final String label;
  final Function? onPressed;
  final ButtonState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: state.isIdle ? () => onPressed?.call() : null,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.accent,
        ),
        child: switch (state) {
          ButtonState.idle => Text(
              label,
              style: TextStyles.btnPrimary,
            ),
          ButtonState.loading => const SizedBox(
              height: _loadingIndicatorSize,
              width: _loadingIndicatorSize,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.defaultBackground,
              ),
            ),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }
}
