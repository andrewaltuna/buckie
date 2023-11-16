import 'package:expense_tracker/account/data/repository/auth_repository.dart';
import 'package:expense_tracker/account/data/service/auth_service.dart';

final authService = AuthService();

final authRepository = AuthRepository(authService: authService);
