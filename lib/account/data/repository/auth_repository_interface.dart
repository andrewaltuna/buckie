import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepositoryInterface {
  bool get isAuth;

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
  });
}
