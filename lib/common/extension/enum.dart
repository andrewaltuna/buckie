import 'package:collection/collection.dart';

extension EnumHelper on Enum {
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
  ///
  /// The string should be in UPPER_SNAKE_CASE format.
  /// Returns null if no match is found.
  T fromValue(String value) {
    return firstWhereOrNull((element) => element.value == value) ?? first;
  }
}
