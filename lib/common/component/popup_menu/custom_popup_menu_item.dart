import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomPopupMenuItem<T> extends PopupMenuEntry<T> {
  const CustomPopupMenuItem({
    required this.value,
    required this.label,
    this.icon,
    this.color,
    this.onTap,
    super.key,
  });

  final T value;
  final void Function(T value)? onTap;
  final String label;
  final IconData? icon;
  final Color? color;

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(T? value) => this.value == value;

  @override
  State createState() => _CustomPopupItemState<T>();
}

class _CustomPopupItemState<T> extends State<CustomPopupMenuItem<T>> {
  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.fontPrimary;

    return CustomInkWell(
      onTap: () => widget.onTap?.call(widget.value),
      height: widget.height,
      borderRadius: Constants.popupMenuBorderRadius,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(
            widget.icon,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            widget.label,
            style: AppTextStyles.bodyRegular.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
