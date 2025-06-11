enum ButtonState {
  idle,
  loading,
  success,
  failure;

  bool get isIdle => this == idle;
  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}
