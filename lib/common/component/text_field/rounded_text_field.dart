import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/common/theme/typography/app_text_styles.dart';
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
    this.onSubmitted,
    this.keyboardType,
    this.obscureText = false,
    this.icon,
    this.readOnly = false,
    this.allowFocus = true,
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

  /// If provided, overrides the error text derived from [validator].
  final String errorText;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? icon;
  final bool readOnly;
  final bool allowFocus;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool allowClear;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final focusNode = allowFocus ? this.focusNode ?? useFocusNode() : null;
    final controller = this.controller ?? useTextEditingController();
    final isFocused = useListenable(focusNode)?.hasFocus ?? false;

    return _NotifierWrapper(
      controller: controller,
      builder: (errorNotifierText, showClearButton, setErrorText) {
        final errorTextDisplay =
            errorText.isNotEmpty ? errorText : errorNotifierText;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 4),
                if (icon != null) ...[
                  icon ?? const SizedBox.shrink(),
                  const SizedBox(width: 4),
                ],
                Text(
                  label,
                  style: AppTextStyles.labelRegular.copyWith(
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.widgetBackgroundSecondary,
                borderRadius: BorderRadius.circular(12),
                border: isFocused
                    ? Border.all(
                        color: AppColors.accent,
                      )
                    : null,
              ),
              child: TextFormField(
                readOnly: readOnly,
                controller: controller,
                focusNode: focusNode,
                keyboardType: keyboardType,
                obscureText: obscureText,
                style: AppTextStyles.bodyRegular,
                cursorWidth: 1,
                cursorColor: AppColors.accent,
                textInputAction: textInputAction,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  border: InputBorder.none,
                  suffixIcon: allowClear && showClearButton
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
                onFieldSubmitted: onSubmitted,
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                validator: validator != null
                    ? (value) {
                        setErrorText(validator?.call(value) ?? '');

                        return null;
                      }
                    : null,
              ),
            ),
            if (errorTextDisplay.isNotEmpty) const SizedBox(height: 3),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: errorTextDisplay.isEmpty ? 0 : 1,
              child: Offstage(
                offstage: errorTextDisplay.isEmpty,
                child: Row(
                  children: [
                    const Icon(
                      Icons.info,
                      color: AppColors.fontWarning,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      errorTextDisplay,
                      style: AppTextStyles.textFieldWarning,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _NotifierWrapper extends HookWidget {
  const _NotifierWrapper({
    required this.controller,
    required this.builder,
  });

  final TextEditingController controller;
  final Widget Function(
    String errorText,
    bool showClearButton,
    void Function(String) setErrorText,
  ) builder;

  @override
  Widget build(BuildContext context) {
    final errorTextNotifier = useState('');
    final showClearButtonNotifier = useState(false);

    useEffect(
      () {
        showClearButtonNotifier.value = controller.text.isNotEmpty;

        void listener() {
          errorTextNotifier.value = '';
          showClearButtonNotifier.value = controller.text.isNotEmpty;
        }

        controller.addListener(listener);

        return () => controller.removeListener(listener);
      },
      [],
    );

    return builder(
      errorTextNotifier.value,
      showClearButtonNotifier.value,
      (errorText) => errorTextNotifier.value = errorText,
    );
  }
}
