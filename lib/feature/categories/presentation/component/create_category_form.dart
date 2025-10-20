import 'package:expense_tracker/common/component/button/custom_ink_well.dart';
import 'package:expense_tracker/common/component/button/rounded_button.dart';
import 'package:expense_tracker/common/component/text_field/rounded_text_field.dart';
import 'package:expense_tracker/common/helper/haptic_feedback_helper.dart';
import 'package:expense_tracker/common/helper/modal_helper.dart';
import 'package:expense_tracker/common/helper/title_case_formatter.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_color.dart';
import 'package:expense_tracker/feature/categories/data/enum/category_icon.dart';
import 'package:expense_tracker/feature/categories/data/model/entity/category_details.dart';
import 'package:expense_tracker/feature/categories/presentation/component/category_color_form_modal_content.dart';
import 'package:expense_tracker/feature/categories/presentation/component/category_icon_form_modal_content.dart';
import 'package:expense_tracker/feature/categories/presentation/view_model/create_category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _kItemHeight = 46.0;

class CreateCategoryForm extends HookWidget {
  const CreateCategoryForm({
    this.category,
    super.key,
  });

  static final _formKey = GlobalKey<FormState>();

  final CategoryDetails? category;

  void _onSubmit(BuildContext context) {
    HapticFeedbackHelper.heavy();

    if (_formKey.currentState!.validate()) {
      context.read<CreateCategoryViewModel>().add(
            const CreateCategorySubmitted(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(
      text: category?.name,
    );

    return BlocListener<CreateCategoryViewModel, CreateCategoryState>(
      listenWhen: (_, current) => current.status.isSuccess,
      listener: (context, _) => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: _Form(
                formKey: _formKey,
                nameController: nameController,
              ),
            ),
            RoundedButton(
              label: category == null ? 'Create' : 'Update',
              onPressed: () => _onSubmit(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({
    required this.formKey,
    required this.nameController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CreateCategoryViewModel>();

    return BlocBuilder<CreateCategoryViewModel, CreateCategoryState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Preview(
                          label: state.name,
                          selectedIcon: state.icon,
                          selectedColor: state.color,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      _IconSelectorButton(
                        selectedIcon: state.icon,
                      ),
                      const SizedBox(width: 12),
                      _ColorSelectorButton(
                        selectedColor: state.color,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              RoundedTextField(
                controller: nameController,
                label: 'Name',
                allowClear: true,
                isInitialFocus: true,
                errorText: state.nameError,
                onChanged: (value) => viewModel.add(
                  CreateCategoryNameUpdated(value),
                ),
                onClear: () => viewModel.add(
                  const CreateCategoryNameUpdated(''),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }

                  return null;
                },
                inputFormatters: [
                  TitleCaseFormatter(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ColorSelectorButton extends StatelessWidget {
  const _ColorSelectorButton({
    required this.selectedColor,
  });

  final CategoryColor selectedColor;

  void _onColorSelected(
    BuildContext parentCtx,
    BuildContext modalCtx,
    CategoryColor color,
  ) {
    HapticFeedbackHelper.light();

    parentCtx
        .read<CreateCategoryViewModel>()
        .add(CreateCategoryColorUpdated(color));

    Navigator.pop(modalCtx);
  }

  @override
  Widget build(BuildContext context) {
    return _FormItem(
      label: 'Color',
      centerLabel: true,
      child: CustomInkWell(
        height: _kItemHeight,
        width: _kItemHeight,
        color: selectedColor.colorData,
        borderRadius: 12,
        onTap: () => ModalHelper.of(context).showModal(
          builder: (modalCtx) => BlocProvider.value(
            value: BlocProvider.of<CreateCategoryViewModel>(context),
            child: CategoryColorFormModalContent(
              colors: CategoryColor.values,
              onSelect: (color) => _onColorSelected(
                context,
                modalCtx,
                color,
              ),
              selectedColor: selectedColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _IconSelectorButton extends HookWidget {
  const _IconSelectorButton({
    required this.selectedIcon,
  });

  final CategoryIcon selectedIcon;

  void _onIconSelected(
    BuildContext parentCtx,
    BuildContext modalCtx,
    CategoryIcon icon,
  ) {
    HapticFeedbackHelper.light();

    parentCtx
        .read<CreateCategoryViewModel>()
        .add(CreateCategoryIconUpdated(icon));

    Navigator.pop(modalCtx);
  }

  @override
  Widget build(BuildContext context) {
    return _FormItem(
      label: 'Icon',
      centerLabel: true,
      child: CustomInkWell(
        height: _kItemHeight,
        width: _kItemHeight,
        color: AppColors.widgetBackgroundSecondary,
        borderRadius: 12,
        onTap: () => ModalHelper.of(context).showModal(
          builder: (modalCtx) => CategoryIconFormModalContent(
            icons: CategoryIcon.values,
            onSelect: (icon) => _onIconSelected(
              context,
              modalCtx,
              icon,
            ),
            selectedIcon: selectedIcon,
          ),
        ),
        child: Icon(
          selectedIcon.iconData,
          color: AppColors.fontPrimary,
        ),
      ),
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview({
    required this.label,
    required this.selectedIcon,
    required this.selectedColor,
  });

  final String label;
  final CategoryIcon selectedIcon;
  final CategoryColor selectedColor;

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
          color: selectedColor.colorData,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              selectedIcon.iconData,
              color: AppColors.fontPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              label.isNotEmpty ? label : 'Preview',
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
