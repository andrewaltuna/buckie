import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RoundedTextField extends HookWidget {
  const RoundedTextField({
    required this.label,
    this.controller,
    this.focusNode,
    this.errorText = '',
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.obscureText = false,
    this.icon,
    this.readOnly = false,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.allowClear = false,
    this.onClear,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String errorText;
  final void Function(String value)? onChanged;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? icon;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool allowClear;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final controller = this.controller ?? useTextEditingController();

    final errorNotifier = useState('');
    final clearNotifier = useState(false);

    final errorText =
        this.errorText.isNotEmpty ? this.errorText : errorNotifier.value;

    useEffect(
      () {
        clearNotifier.value = controller.text.isNotEmpty;

        void listener() {
          errorNotifier.value = '';
          clearNotifier.value = controller.text.isNotEmpty;
        }

        controller.addListener(listener);

        return () => controller.removeListener(listener);
      },
      [],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 5),
            if (icon != null) ...[
              icon ?? const SizedBox.shrink(),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: TextStyles.labelRegular.copyWith(
                color: AppColors.accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: AppColors.widgetBackgroundSecondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            readOnly: readOnly,
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: TextStyles.bodyRegular,
            cursorWidth: 1,
            cursorColor: AppColors.accent,
            textInputAction: textInputAction,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              border: InputBorder.none,
              suffixIcon: allowClear && clearNotifier.value
                  ? GestureDetector(
                      onTap: () {
                        controller.clear();
                        onClear?.call();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: AppColors.accent,
                        ),
                      ),
                    )
                  : null,
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 16,
                maxWidth: 28,
              ),
            ),
            inputFormatters: inputFormatters,
            onTap: onTap,
            onChanged: onChanged,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            validator: validator != null
                ? (value) {
                    errorNotifier.value = validator?.call(value) ?? '';

                    return null;
                  }
                : null,
          ),
        ),
        if (errorText.isNotEmpty) const SizedBox(height: 3),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: errorText.isEmpty ? 0 : 1,
          child: Offstage(
            offstage: errorText.isEmpty,
            child: Row(
              children: [
                const Icon(
                  Icons.info,
                  color: AppColors.fontWarning,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  errorText,
                  style: TextStyles.textFieldWarning,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
