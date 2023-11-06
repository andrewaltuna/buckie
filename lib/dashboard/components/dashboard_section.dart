import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.title,
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
