import 'package:equatable/equatable.dart';
import 'package:expense_tracker/account/data/repository/auth_repository.dart';
import 'package:expense_tracker/common/enum/view_model_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountViewModel extends Bloc<AccountEvent, AccountState> {
  AccountViewModel(this._authRepository) : super(const AccountState()) {
    on<AccountLoggedIn>(_onLoggedIn);
    on<AccountRegistered>(onRegistered);
  }

  final AuthRepository _authRepository;

  void _onLoggedIn(
    AccountLoggedIn event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final result = await _authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (result.user != null) {
        emit(
          state.copyWith(
            status: ViewModelStatus.loaded,
            isAuth: true,
          ),
        );
      }
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  void onRegistered(
    AccountRegistered event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final result = await _authRepository.registerWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (result.user != null) {
        emit(
          state.copyWith(
            status: ViewModelStatus.loaded,
            isAuth: true,
          ),
        );
      }
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }
}
