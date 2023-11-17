part of 'account_view_model.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class AccountRegistered extends AccountEvent {
  const AccountRegistered({
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

class AccountLoggedIn extends AccountEvent {
  const AccountLoggedIn({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
