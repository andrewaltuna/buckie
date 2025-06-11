class CustomException implements Exception {
  const CustomException({
    this.message = 'Uh-oh! Something went wrong. Please try again later.',
  });

  final String message;

  @override
  String toString() => message;
}
