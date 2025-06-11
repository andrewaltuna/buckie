import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRepositoryInterface {
  User? get currentUser;

  bool get isAuthenticated;

  Stream<AuthState> get authStream;

  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<AuthResponse> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
