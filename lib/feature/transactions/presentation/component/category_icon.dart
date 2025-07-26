import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    required this.category,
    this.size,
    this.trailingSpace,
    this.onTap,
    super.key,
  });

  final CategoryDetails category;
  final double? size;
  final double? trailingSpace;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      color: category.color.colorData,
      borderRadius: 14,
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        child: Icon(
          category.icon.iconData,
          size: size != null ? size! * 0.5 : null,
          color: AppColors.fontPrimary,
        ),
      ),
    );
  }
}
