import 'package:expense_tracker/account/data/repository/auth_repository_interface.dart';
import 'package:expense_tracker/account/data/service/auth_service_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository implements AuthRepositoryInterface {
  const AuthRepository({
    required AuthServiceInterface authService,
  }) : _authService = authService;

  final AuthServiceInterface _authService;

  @override
  bool get isAuth => _authService.isAuth;

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _authService.registerWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
