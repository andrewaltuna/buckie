import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PopupMenuHelper {
  const PopupMenuHelper._(this._context);

  factory PopupMenuHelper.of(BuildContext context) =>
      PopupMenuHelper._(context);

  final BuildContext _context;

  Future<void> showPopupMenu({
    required List<PopupMenuEntry> items,
    required Offset position,
  }) async {
    await showMenu(
      context: _context,
      color: AppColors.widgetBackgroundTertiary,
      menuPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: items,
    );
  }
}
