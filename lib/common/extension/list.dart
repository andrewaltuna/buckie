extension ListHelper<T> on List<T> {
  void replaceAt(int index, T element) {
    this[index] = element;
  }
}
