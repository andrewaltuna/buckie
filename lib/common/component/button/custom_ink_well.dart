import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    this.child,
    this.borderRadius,
    this.borderSide,
    this.color,
    this.onTap,
    this.onLongPressStart,
    this.width,
    this.height,
    this.padding,
    super.key,
  });

  final VoidCallback? onTap;
  final void Function(LongPressStartDetails)? onLongPressStart;
  final Color? color;
  final double? borderRadius;
  final BorderSide? borderSide;
  final Widget? child;
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius ?? 0),
          ),
          side: borderSide ?? BorderSide.none,
        ),
        child: GestureDetector(
          onLongPressStart: onLongPressStart,
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
      ),
    );
  }
}
