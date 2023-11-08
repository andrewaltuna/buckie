import 'package:expense_tracker/common/components/main_scaffold.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Settings',
      body: Container(),
    );
  }
}
