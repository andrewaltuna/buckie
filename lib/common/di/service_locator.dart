import 'package:expense_tracker/feature/account/data/repository/auth_repository.dart';
import 'package:expense_tracker/feature/account/data/repository/auth_repository_interface.dart';
import 'package:expense_tracker/feature/account/data/service/auth_service.dart';
import 'package:expense_tracker/feature/account/data/service/auth_service_interface.dart';
import 'package:expense_tracker/feature/budget/data/remote/budget_remote_source.dart';
import 'package:expense_tracker/feature/budget/data/remote/budget_remote_source_interface.dart';
import 'package:expense_tracker/feature/budget/data/repository/budget_repository.dart';
import 'package:expense_tracker/feature/budget/data/repository/budget_repository_interface.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository.dart';
import 'package:expense_tracker/feature/transactions/data/repository/transaction_repository_interface.dart';
import 'package:expense_tracker/feature/transactions/data/remote/transaction_remote_source.dart';
import 'package:expense_tracker/feature/transactions/data/remote/transaction_remote_source_interface.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

void initializeLocator() {
  // Supabase Client
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // Auth
  sl
    ..registerLazySingleton<AuthRepositoryInterface>(() => AuthRepository(sl()))
    ..registerLazySingleton<AuthServiceInterface>(() => AuthService(sl()));

  // Transactions
  sl
    ..registerLazySingleton<TransactionRepositoryInterface>(
      () => TransactionRepository(sl()),
    )
    ..registerLazySingleton<TransactionRemoteSourceInterface>(
      () => TransactionRemoteSource(sl()),
    );

  // Budget
  sl
    ..registerLazySingleton<BudgetRepositoryInterface>(
      () => BudgetRepository(sl()),
    )
    ..registerLazySingleton<BudgetRemoteSourceInterface>(
      () => BudgetRemoteSource(sl()),
    );
}
