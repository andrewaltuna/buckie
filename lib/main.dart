import 'package:expense_tracker/common/constants.dart';
import 'package:expense_tracker/common/database/app_database.dart';
import 'package:expense_tracker/common/di/service_locator.dart';
import 'package:expense_tracker/common/navigation/app_router.dart';
import 'package:expense_tracker/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Supabase.initialize(
  //   url: AppConfig.supabaseUrl,
  //   anonKey: AppConfig.supabaseKey,
  // );

  // Lock orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await AppDatabase.instance.initDatabase();

  // Init GetIt dependencies
  initializeLocator();

  runApp(
    const App(),
  );

  // TODO: Uncomment when auth-related features are up
  // runApp(
  //   const GlobalViewModels(
  //     child: GlobalListeners(
  //       child: App(),
  //     ),
  //   ),
  // );
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
          seedColor: AppColors.accent,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.fontPrimary,
            ),
      ),
      routerConfig: AppNavigation.router,
      builder: (_, child) => MediaQuery.withNoTextScaling(
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
