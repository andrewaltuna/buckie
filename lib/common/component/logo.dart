import 'package:expense_tracker/common/component/asset/app_images.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppImages.logo.copyWith(height: 35),
        const SizedBox(height: 12),
        const Text(
          'Budgeting with a smile',
          style: TextStyles.body,
        ),
      ],
    );
  }
}
