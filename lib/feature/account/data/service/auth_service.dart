import 'package:expense_tracker/feature/account/data/exception/auth_exception.dart'
    as ae;
import 'package:expense_tracker/feature/account/data/service/auth_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService implements AuthServiceInterface {
  const AuthService(this._supabaseClient);

  final SupabaseClient _supabaseClient;

  GoTrueClient get _supabaseAuth => _supabaseClient.auth;

  @override
  User? get currentUser => _supabaseAuth.currentUser;

  @override
  bool get isAuthenticated => currentUser != null;

  @override
  Stream<AuthState> get authStream => _supabaseAuth.onAuthStateChange;

  @override
  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _supabaseAuth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResponse> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('registerWithEmailAndPassword');

      return await _supabaseAuth.signUp(
        email: email,
        password: password,
      );
    } on AuthApiException catch (error) {
      debugPrint(error.code);

      switch (error.code) {
        case 'email_address_invalid':
          throw const ae.AuthInvalidEmailException();
        case 'email_exists':
          throw const ae.AuthEmailAlreadyInUseException();
        case 'weak_password':
          throw const ae.AuthWeakPasswordException();
        default:
          throw const ae.AuthDefaultException();
      }
    }
  }

  @override
  Future<void> signOut() async {
    return await _supabaseAuth.signOut();
  }
}
