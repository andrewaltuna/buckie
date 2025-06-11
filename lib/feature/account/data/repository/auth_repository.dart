import 'package:expense_tracker/feature/account/data/repository/auth_repository_interface.dart';
import 'package:expense_tracker/feature/account/data/service/auth_service_interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository implements AuthRepositoryInterface {
  const AuthRepository({
    required AuthServiceInterface authService,
  }) : _authService = authService;

  final AuthServiceInterface _authService;

  @override
  User? get currentUser => _authService.currentUser;

  @override
  bool get isAuthenticated => currentUser != null;

  @override
  Stream<AuthState> get authStream => _authService.authStream;

  @override
  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResponse> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _authService.registerWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    return await _authService.signOut();
  }
}
