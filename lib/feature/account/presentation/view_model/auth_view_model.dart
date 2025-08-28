import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/feature/account/data/exception/auth_exception.dart';
import 'package:expense_tracker/feature/account/data/model/registration_exception_output.dart';
import 'package:expense_tracker/common/enum/view_model_status.dart';
import 'package:expense_tracker/feature/account/data/repository/auth_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthViewModel extends Bloc<AuthEvent, AuthState> {
  AuthViewModel(this._authRepository) : super(const AuthState()) {
    on<AuthStreamInitialized>(_onStreamInitialized);
    on<AuthRegistered>(_onRegistered);
    on<AuthSignedIn>(_onLoggedIn);
    on<AuthSignedOut>(_onSignedOut);

    // Initialize Auth stream
    add(const AuthStreamInitialized());
  }

  final AuthRepositoryInterface _authRepository;

  StreamSubscription<sb.AuthState>? _authStream;

  void _onStreamInitialized(
    AuthStreamInitialized _,
    Emitter<AuthState> emit,
  ) {
    _authStream = _authRepository.authStream.listen((data) {
      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          isAuthenticated: data.session != null,
        ),
      );
    });
  }

  void _onRegistered(
    AuthRegistered event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      // Validate if passwords match
      if (event.password != event.passwordConfirmation) {
        throw const AuthPasswordMismatchException();
      }

      final result = await _authRepository.registerWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (result.session != null) {
        emit(
          state.copyWith(
            status: ViewModelStatus.success,
            isAuthenticated: true,
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

  void _onLoggedIn(
    AuthSignedIn event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ViewModelStatus.loading));

      final result = await _authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (result.session != null) {
        emit(
          state.copyWith(
            status: ViewModelStatus.success,
            isAuthenticated: true,
          ),
        );
      }
    } on Exception catch (error) {
      print(error);
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  void _onSignedOut(
    AuthSignedOut event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (state.status.isLoading) return;

      await _authRepository.signOut();

      emit(
        state.copyWith(
          status: ViewModelStatus.success,
          isAuthenticated: false,
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: ViewModelStatus.error,
          error: error,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _authStream?.cancel();

    return super.close();
  }
}
