import 'dart:io';

void main() async {
  const inputPath = '.env';
  const outputPath = 'lib/env.dart';

  final envFile = File(inputPath);
  if (!await envFile.exists()) {
    stderr.writeln('❌ .env file not found.');
    exit(1);
  }

  final lines = await envFile.readAsLines();

  final buffer = StringBuffer()
    ..writeln('// GENERATED FILE - DO NOT MODIFY BY HAND')
    ..writeln('// Run `dart generate_env.dart` to regenerate\n')
    ..writeln('class AppConfig {')
    ..writeln('  const AppConfig._();\n');

  for (final line in lines) {
    if (line.trim().isEmpty || line.trim().startsWith('#')) continue;

    final parts = line.split('=');
    if (parts.length < 2) continue;

    final key = _toCamelCase(parts[0].trim());
    final value = parts[1].trim();

    buffer.writeln("  static const String $key = '$value';");
  }

  buffer.writeln('}');

  final outputFile = File(outputPath);
  await outputFile.writeAsString(buffer.toString());

  print('✅ Generated $outputPath');
}

String _toCamelCase(String input) {
  input = input.toLowerCase();
  final parts = input.toLowerCase().split('_');

  return parts.first +
      parts
          .sublist(1)
          .map((part) => part[0].toUpperCase() + part.substring(1))
          .join();
}
