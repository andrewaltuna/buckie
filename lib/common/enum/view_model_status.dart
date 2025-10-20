enum ViewModelStatus {
  initial,
  loading,
  loadingMore,
  success,
  error;

  bool get isInitial => this == initial;
  bool get isLoading => this == loading;
  bool get isLoadingMore => this == loadingMore;
  bool get isSuccess => this == success;
  bool get isError => this == error;
}
