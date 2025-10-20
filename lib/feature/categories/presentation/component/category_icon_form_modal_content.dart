import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_icon.dart';
import 'package:expense_tracker/feature/categories/presentation/component/category_form_modal_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _kItemsPerPage = 16;
const _kItemSize = 32.0;

class CategoryIconFormModalContent extends HookWidget {
  const CategoryIconFormModalContent({
    required this.icons,
    required this.onSelect,
    this.selectedIcon,
    super.key,
  });

  final List<CategoryIcon> icons;
  final void Function(CategoryIcon icon) onSelect;
  final CategoryIcon? selectedIcon;

  @override
  Widget build(BuildContext context) {
    // Visibly changes selection once icon is selected
    final selectedIconNotifier = useState(selectedIcon);

    return CategoryFormModalBase(
      items: icons,
      itemsPerPage: _kItemsPerPage,
      builder: (icon) {
        final isSelected = icon == selectedIconNotifier.value;

        return CustomInkWell(
          height: _kItemSize,
          width: _kItemSize,
          color: isSelected
              ? AppColors.accent
              : AppColors.widgetBackgroundSecondary,
          borderRadius: 16,
          child: Icon(
            icon.iconData,
            color: isSelected
                ? AppColors.widgetBackgroundSecondary
                : AppColors.fontPrimary,
          ),
          onTap: () {
            selectedIconNotifier.value = icon;
            onSelect(icon);
          },
        );
      },
    );
  }
}
