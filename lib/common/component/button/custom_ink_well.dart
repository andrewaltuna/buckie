import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    required this.child,
    this.borderRadius,
    this.color,
    this.onTap,
    this.width,
    this.height,
    this.padding,
    super.key,
  });

  final VoidCallback? onTap;
  final Color? color;
  final double? borderRadius;
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final splashColor = AppColors.fontPrimary.withValues(alpha: 0.05);

    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius ?? 0),
      ),
      child: Material(
        color: color ?? Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: splashColor,
          overlayColor: WidgetStateColor.resolveWith(
            (_) => splashColor,
          ),
          child: Container(
            width: width,
            height: height,
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
