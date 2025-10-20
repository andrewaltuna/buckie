extension ListExtension<T> on List<T> {
  void replaceAt(int index, T element) {
    this[index] = element;
  }
}
