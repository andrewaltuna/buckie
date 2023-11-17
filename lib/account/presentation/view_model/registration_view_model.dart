import 'package:expense_tracker/account/data/exception/registration_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'registration_state.dart';

class RegistrationViewModel extends Cubit<RegistrationState> {
  RegistrationViewModel() : super(const RegistrationState());

  void emailErrorText(RegistrationException? error) {
    emit(state.copyWith(emailErrorText: error.toString()));
  }

  void passwordErrorText(RegistrationException? error) {
    emit(state.copyWith(passwordErrorText: error.toString()));
  }

  void passwordConfirmationErrorText(RegistrationException? error) {
    emit(state.copyWith(passwordConfirmationErrorText: error.toString()));
  }
}
