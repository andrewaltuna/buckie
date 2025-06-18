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
    Widget Function(BuildContext)? headerBuilder,
    ModalSize size = ModalSize.regular,
  }) {
    return showDialog<void>(
      context: _context,
      builder: (context) {
        return Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (headerBuilder != null)
                    Container(
                      width: size.width,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: AppColors.widgetBackgroundSecondary,
                      ),
                      child: headerBuilder.call(context),
                    ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.widgetBackgroundTertiary,
                    ),
                    child: builder(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
