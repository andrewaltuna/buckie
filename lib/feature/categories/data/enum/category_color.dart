import 'package:flutter/material.dart';

enum CategoryColor {
  red,
  purple,
  blue,
  pink,
  orange,
  yellow,
  teal,
  magenta,
  cyan,
  green,
  gray,
  darkGray;

  Color get colorData => switch (this) {
        red => const Color(0xFFE63946),
        purple => const Color(0xFFB667F1),
        blue => const Color(0xFF4CC9F0),
        pink => const Color(0xFFF72585),
        orange => const Color(0xFFFF9F1C),
        yellow => const Color(0xFFF2C464),
        teal => const Color(0xFF2EC4B6),
        magenta => const Color(0xFFFF006B),
        cyan => const Color(0xFF00B4D8),
        green => const Color(0xFF06D6A0),
        gray => const Color(0xFF7D8597),
        darkGray => const Color(0xFF6B7280),
      };
}
