part of 'auth_view_model.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStreamInitialized extends AuthEvent {
  const AuthStreamInitialized();
}

class AuthRegistered extends AuthEvent {
  const AuthRegistered({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  final String email;
  final String password;
  final String passwordConfirmation;

  @override
  List<Object> get props => [
        email,
        password,
        passwordConfirmation,
      ];
}

class AuthSignedIn extends AuthEvent {
  const AuthSignedIn({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class AuthSignedOut extends AuthEvent {
  const AuthSignedOut();
}
