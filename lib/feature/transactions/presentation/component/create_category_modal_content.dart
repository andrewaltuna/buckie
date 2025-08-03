import 'package:expense_tracker/common/component/button/rounded_button.dart';
import 'package:expense_tracker/common/component/main_scaffold.dart';
import 'package:expense_tracker/common/component/text_field/rounded_text_field.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_color.dart';
import 'package:flutter/material.dart';

import '../../../categories/data/enum/category_icon.dart';

const _kItemHeight = 46.0;

class CreateCategoryModalContent extends StatelessWidget {
  const CreateCategoryModalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Create Category',
      showBackButton: true,
      showNavBar: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _Preview(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Row(
                          children: [
                            _IconSelectorButton(),
                            const SizedBox(width: 12),
                            _ColorSelectorButton(),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    RoundedTextField(
                      label: 'Label',
                    ),
                  ],
                ),
              ),
            ),
            RoundedButton(label: 'Create'),
          ],
        ),
      ),
    );
  }
}

class _ColorSelectorButton extends StatelessWidget {
  const _ColorSelectorButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _FormItem(
      label: 'Color',
      centerLabel: true,
      child: Container(
        height: _kItemHeight,
        width: _kItemHeight,
        decoration: BoxDecoration(
          color: CategoryColor.blue.colorData,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class _IconSelectorButton extends StatelessWidget {
  const _IconSelectorButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _FormItem(
      label: 'Icon',
      centerLabel: true,
      child: Container(
        height: _kItemHeight,
        width: _kItemHeight,
        decoration: BoxDecoration(
          color: AppColors.widgetBackgroundSecondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          CategoryIcon.art.iconData,
          color: AppColors.fontPrimary,
        ),
      ),
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _FormItem(
      label: 'Preview',
      child: Container(
        height: _kItemHeight,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: CategoryColor.blue.colorData,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              CategoryIcon.art.iconData,
              color: AppColors.fontPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              'Art',
              style: AppTextStyles.bodyRegular,
            ),
          ],
        ),
      ),
    );
  }
}

class _FormItem extends StatelessWidget {
  const _FormItem({
    required this.label,
    required this.child,
    this.centerLabel = false,
  });

  final String label;
  final bool centerLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          centerLabel ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          padding: centerLabel ? null : const EdgeInsets.only(left: 4),
          child: Text(
            label,
            style: AppTextStyles.textFieldLabel,
          ),
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}
