import 'package:expense_tracker/feature/account/data/repository/auth_repository.dart';
import 'package:expense_tracker/feature/account/data/service/auth_service.dart';

final authService = AuthService();

final authRepository = AuthRepository(authService: authService);
