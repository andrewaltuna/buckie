import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:expense_tracker/feature/categories/data/model/transaction_category.dart';
import 'package:flutter/material.dart';

class CategoryDisplay extends StatelessWidget {
  const CategoryDisplay({
    required this.category,
    this.iconOnly = false,
    this.height,
    this.width,
    this.iconSize,
    this.trailingSpace,
    this.onTap,
    super.key,
  });

  final TransactionCategoryType category;
  final bool iconOnly;
  final double? height;
  final double? width;
  final double? iconSize;
  final double? trailingSpace;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      color: category.color,
      borderRadius: 12,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category.icon,
              size: iconSize,
              color: AppColors.fontPrimary,
            ),
            if (!iconOnly) ...[
              const SizedBox(width: 8),
              Text(
                category.label,
                style: TextStyles.titleSmall,
              ),
              SizedBox(width: trailingSpace),
            ],
          ],
        ),
      ),
    );
  }
}
