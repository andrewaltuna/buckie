import 'package:expense_tracker/common/component/skeleton/skeleton_display.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TransactionPreviewSkeleton extends StatelessWidget {
  const TransactionPreviewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: AppColors.widgetBackgroundSecondary,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonDisplay(
            height: 16,
            width: 150,
          ),
          SkeletonDisplay(
            height: 16,
            width: 120,
          ),
        ],
      ),
    );
  }
}
