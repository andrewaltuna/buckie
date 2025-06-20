enum ButtonState {
  idle,
  loading,
  disabled;

  bool get isIdle => this == idle;
  bool get isLoading => this == loading;
  bool get isDisabled => this == disabled;
}
