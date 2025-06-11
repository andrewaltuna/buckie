import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/navigation/app_router.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:expense_tracker/env.dart';
import 'package:expense_tracker/global_listeners.dart';
import 'package:expense_tracker/global_view_models.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseKey,
  );

  runApp(
    const GlobalViewModels(
      child: GlobalListeners(
        child: App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'buckie',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: Constants.fontFamilySecondary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.defaultBackground,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.fontPrimary,
            ),
      ),
      routerConfig: AppNavigation.router,
    );
  }
}
