abstract interface class AuthRepositoryInterface {
  bool get isAuth;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
