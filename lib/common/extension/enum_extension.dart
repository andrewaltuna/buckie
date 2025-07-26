extension EnumExtension on Enum {
  /// Converts enum name to snake case.
  ///
  /// E.g. `Enum.thisIsAValue.value` -> `THIS_IS_A_VALUE`
  String get value {
    return name
        .replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) => '_${match.group(0)}',
        )
        .toUpperCase();
  }
}

extension EnumListHelper<T extends Enum> on List<T> {
  /// Returns the enum value that matches the given string value.
  /// Optionally, [orElse] can be provided for a default value.
  ///
  /// The string should be in UPPER_SNAKE_CASE format.
  /// Returns null if no match is found.
  T fromValue(
    String value, {
    T? orElse,
  }) {
    return firstWhere(
      (element) => element.value == value,
      orElse: () => orElse ?? first,
    );
  }
}
