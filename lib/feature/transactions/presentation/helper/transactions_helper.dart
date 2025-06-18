import 'package:flutter/material.dart';

class TransactionsHelper {
  const TransactionsHelper._(this._context);

  factory TransactionsHelper(BuildContext context) =>
      TransactionsHelper._(context);

  final BuildContext _context;

  // Future<void> showCreateBottomSheet() {
  //   showModalBottomSheet(
  //     context: _context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(20),
  //       ),
  //     ),
  //     builder: (context) {
  //       return Container();
  //     },
  //   );
  // }
}
