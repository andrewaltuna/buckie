import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/helper/modal_helper.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:flutter/material.dart';

class DeleteCategoryModalContent extends StatelessWidget {
  const DeleteCategoryModalContent({
    this.onDeleted,
    super.key,
  });

  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    return ModalBase(
      header: Row(
        children: [
          const Expanded(
            child: Text(
              'Delete Category?',
              style: AppTextStyles.titleRegular,
            ),
          ),
          CustomInkWell(
            width: 36,
            height: 36,
            borderRadius: 12,
            color: AppColors.fontWarning,
            onTap: onDeleted,
            child: const Icon(
              Icons.delete,
              color: AppColors.fontButtonPrimary,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text:
                      'All transactions in this category will be reassigned to ',
                  style: AppTextStyles.bodyMedium,
                ),
                WidgetSpan(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CategoryDetails.fallback.icon.iconData,
                        size: 12,
                        color: AppColors.fontPrimary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        CategoryDetails.fallback.name,
                        style: AppTextStyles.titleExtraSmall,
                      ),
                    ],
                  ),
                ),
                const TextSpan(
                  text: ' upon deletion.',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
