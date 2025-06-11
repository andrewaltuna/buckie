part of 'auth_view_model.dart';

class AuthState extends Equatable {
  const AuthState({
    this.isAuthenticated = false,
    this.status = ViewModelStatus.initial,
    this.error,
  });

  final bool isAuthenticated; // TODO: replace with User object
  final ViewModelStatus status;
  final Exception? error;

  AuthState copyWith({
    bool? isAuthenticated,
    ViewModelStatus? status,
    RegistrationExceptionOutput? registrationExceptions,
    Exception? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        isAuthenticated,
        status,
        error,
      ];
}
