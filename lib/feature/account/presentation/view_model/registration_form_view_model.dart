import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'registration_form_state.dart';

class RegistrationFormViewModel extends Cubit<RegistrationFormState> {
  RegistrationFormViewModel() : super(const RegistrationFormState());

  /// Sets the error text for the email field. If [text] is null, then the error
  /// text is cleared.
  void emailErrorText(String? text) {
    emit(
      state.copyWith(
        emailErrorText: text ?? '',
      ),
    );
  }

  void validatePassword({
    required String password,
    required String passwordConfirmation,
  }) {
    String passwordErrorText = '';
    String passwordConfirmationErrorText = '';

    if (password.length < 6) {
      passwordErrorText = 'Password must be at least 6 characters';
    }

    if (password != passwordConfirmation) {
      passwordConfirmationErrorText = 'Passwords do not match';
    }

    emit(
      state.copyWith(
        passwordErrorText: passwordErrorText,
        passwordConfirmationErrorText: passwordConfirmationErrorText,
      ),
    );
  }
}
