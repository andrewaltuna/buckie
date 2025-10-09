import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_color.dart';
import 'package:expense_tracker/feature/categories/presentation/component/category_form_modal_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _kItemsPerPage = 12;
const _kItemSize = 32.0;

class CategoryColorFormModalContent extends HookWidget {
  const CategoryColorFormModalContent({
    required this.colors,
    required this.onSelect,
    this.selectedColor,
    super.key,
  });

  final List<CategoryColor> colors;
  final void Function(CategoryColor color) onSelect;
  final CategoryColor? selectedColor;

  @override
  Widget build(BuildContext context) {
    // Visibly changes selection once color is selected
    final selectedColorNotifier = useState(selectedColor);

    return CategoryFormModalBase(
      items: colors,
      itemsPerPage: _kItemsPerPage,
      builder: (color) => CustomInkWell(
        height: _kItemSize,
        width: _kItemSize,
        color: color.colorData,
        borderSide: color == selectedColorNotifier.value
            ? CategoryFormModalBase.selectedItemBorder
            : null,
        borderRadius: 16,
        onTap: () {
          selectedColorNotifier.value = color;
          onSelect(color);
        },
      ),
    );
  }
}
