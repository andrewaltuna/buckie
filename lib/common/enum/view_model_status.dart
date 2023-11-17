enum ViewModelStatus {
  initial,
  loading,
  loadingMore,
  loaded,
  error;

  bool get isInitial => this == initial;
  bool get isLoading => this == loading;
  bool get isLoadingMore => this == loadingMore;
  bool get isLoaded => this == loaded;
  bool get isError => this == error;
}
