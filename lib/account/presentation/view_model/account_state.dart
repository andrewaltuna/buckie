part of 'account_view_model.dart';

class AccountState extends Equatable {
  const AccountState({
    this.isAuth = false,
    this.status = ViewModelStatus.initial,
    this.error,
  });

  final bool isAuth; // TODO: replace with User object
  final ViewModelStatus status;
  final Exception? error;

  AccountState copyWith({
    bool? isAuth,
    ViewModelStatus? status,
    Exception? error,
  }) {
    return AccountState(
      isAuth: isAuth ?? this.isAuth,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        isAuth,
        status,
        error,
      ];
}
