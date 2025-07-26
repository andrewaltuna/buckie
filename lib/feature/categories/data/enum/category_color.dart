import 'package:flutter/material.dart';

enum CategoryColor {
  red,
  purple,
  blue,
  pink,
  orange,
  teal,
  magenta,
  cyan,
  green,
  gray,
  darkGray;

  Color get colorData => switch (this) {
        CategoryColor.red => const Color(0xFFE63946),
        CategoryColor.purple => const Color(0xFFB667F1),
        CategoryColor.blue => const Color(0xFF4CC9F0),
        CategoryColor.pink => const Color(0xFFF72585),
        CategoryColor.orange => const Color(0xFFFF9F1C),
        CategoryColor.teal => const Color(0xFF2EC4B6),
        CategoryColor.magenta => const Color(0xFFFF006B),
        CategoryColor.cyan => const Color(0xFF00B4D8),
        CategoryColor.green => const Color(0xFF06D6A0),
        CategoryColor.gray => const Color(0xFF7D8597),
        CategoryColor.darkGray => const Color(0xFF6B7280),
      };
}
