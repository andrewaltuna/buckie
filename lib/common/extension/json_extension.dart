extension JsonExtension on Map<String, dynamic> {
  String? tryParseString(String key) {
    final value = this[key];

    if (value is! String) return null;

    return value;
  }

  String parseString(String key) => tryParseString(key) ?? '';

  int? tryParseInt(String key) {
    final value = this[key];

    if (value is int) return value;
    if (value is double) return value.toInt();

    try {
      return int.tryParse(value);
    } catch (_) {
      return null;
    }
  }

  int parseInt(String key) => tryParseInt(key) ?? 0;

  double? tryParseDouble(String key) {
    final value = this[key];

    if (value is double) return value;
    if (value is int) return value.toDouble();

    try {
      return double.tryParse(value);
    } catch (_) {
      return null;
    }
  }

  double parseDouble(String key) => tryParseDouble(key) ?? 0.0;

  bool? tryParseBool(String key) {
    final value = this[key];

    if (value is! String) return null;

    return value.toLowerCase() == 'true';
  }

  bool parseBool(String key) => tryParseBool(key) ?? false;

  DateTime? tryParseDateTime(String key) {
    final value = this[key];

    try {
      return DateTime.tryParse(value);
    } catch (_) {
      return null;
    }
  }

  DateTime parseDateTime(String key) => tryParseDateTime(key) ?? DateTime.now();

  Map<String, dynamic> parseMap(String key) => tryParseMap(key) ?? {};

  Map<String, dynamic>? tryParseMap(String key) {
    final value = this[key];

    if (value is! Map<String, dynamic>) return null;

    return value;
  }
}
