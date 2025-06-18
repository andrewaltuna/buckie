import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonDisplay extends StatelessWidget {
  const SkeletonDisplay({
    this.width,
    this.height,
    this.borderRadius = 12.0,
    this.color,
    super.key,
  });

  final double? width;
  final double? height;
  final double borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      child: Shimmer(
        gradient: LinearGradient(
          colors: [
            color ?? AppColors.fontSubtitle.withOpacity(0.1),
            AppColors.fontPrimary.withOpacity(0.2),
            color ?? AppColors.fontSubtitle.withOpacity(0.1),
          ],
          stops: const [0.3, 0.5, 0.7],
        ),
        child: Container(
          width: width,
          height: height,
          color: AppColors.widgetBackgroundSecondary,
        ),
      ),
    );
  }
}
