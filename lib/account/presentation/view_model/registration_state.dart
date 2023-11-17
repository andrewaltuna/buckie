part of 'registration_view_model.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    this.emailErrorText = '',
    this.passwordErrorText = '',
    this.passwordConfirmationErrorText = '',
  });

  final String emailErrorText;
  final String passwordErrorText;
  final String passwordConfirmationErrorText;

  RegistrationState copyWith({
    String? emailErrorText,
    String? passwordErrorText,
    String? passwordConfirmationErrorText,
  }) {
    return RegistrationState(
      emailErrorText: emailErrorText ?? this.emailErrorText,
      passwordErrorText: passwordErrorText ?? this.passwordErrorText,
      passwordConfirmationErrorText:
          passwordConfirmationErrorText ?? this.passwordConfirmationErrorText,
    );
  }

  @override
  List<Object> get props => [];
}
