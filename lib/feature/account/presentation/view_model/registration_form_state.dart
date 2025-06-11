part of 'registration_form_view_model.dart';

class RegistrationFormState extends Equatable {
  const RegistrationFormState({
    this.emailErrorText = '',
    this.passwordErrorText = '',
    this.passwordConfirmationErrorText = '',
  });

  final String emailErrorText;
  final String passwordErrorText;
  final String passwordConfirmationErrorText;

  RegistrationFormState copyWith({
    String? emailErrorText,
    String? passwordErrorText,
    String? passwordConfirmationErrorText,
  }) {
    return RegistrationFormState(
      emailErrorText: emailErrorText ?? this.emailErrorText,
      passwordErrorText: passwordErrorText ?? this.passwordErrorText,
      passwordConfirmationErrorText:
          passwordConfirmationErrorText ?? this.passwordConfirmationErrorText,
    );
  }

  bool get isErrorFree {
    return emailErrorText.isEmpty &&
        passwordErrorText.isEmpty &&
        passwordConfirmationErrorText.isEmpty;
  }

  @override
  List<Object> get props => [
        emailErrorText,
        passwordErrorText,
        passwordConfirmationErrorText,
      ];
}
