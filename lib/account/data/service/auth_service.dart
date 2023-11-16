import 'package:expense_tracker/account/data/service/auth_service_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService implements AuthServiceInterface {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  bool get isAuth => _firebaseAuth.currentUser != null;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
