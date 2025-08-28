import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ModalHelper {
  const ModalHelper._(this._context);

  factory ModalHelper.of(BuildContext context) {
    return ModalHelper._(context);
  }

  final BuildContext _context;

  Future<void> showModal({
    required Widget Function(BuildContext) builder,
    Widget Function(Widget)? wrapperBuilder,
    ModalSize size = ModalSize.regular,
  }) {
    final wrapper = wrapperBuilder ?? (child) => child;

    return showDialog<void>(
      context: _context,
      builder: (context) {
        return wrapper(
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(16),
                width: size.width,
                child: builder(context),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ModalBase extends StatelessWidget {
  const ModalBase({
    required this.body,
    this.header,
    this.headerPadding,
    this.bodyPadding,
    super.key,
  });

  final Widget? header;
  final Widget body;
  final EdgeInsetsGeometry? headerPadding;
  final EdgeInsetsGeometry? bodyPadding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (header != null)
              Container(
                width: double.infinity,
                padding: headerPadding ?? const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.widgetBackgroundSecondary,
                ),
                child: header,
              ),
            Flexible(
              child: Container(
                width: double.infinity,
                padding: bodyPadding ?? const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.widgetBackgroundTertiary,
                ),
                child: body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ModalSize {
  regular,
  full;

  double get width => switch (this) {
        ModalSize.regular => 300,
        ModalSize.full => double.infinity,
      };
}
