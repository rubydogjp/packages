import 'package:flutter/material.dart';

class ColorPalette {
  const ColorPalette({
    required this.activeButton,
    required this.background,
    required this.card,
    required this.strongText,
    required this.weakText,
  });

  final Color activeButton;
  final Color background;
  final Color card;
  final Color strongText;
  final Color weakText;

  factory ColorPalette.of(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return isDarkMode ? _darkPallete : _lightPallete;
  }
}

const _darkPallete = ColorPalette(
  activeButton: Color(0xFF1DA1F2),
  background: Color(0xFF14171A),
  card: Color(0xFF14171A),
  strongText: Colors.white,
  weakText: Colors.grey,
);

const _lightPallete = ColorPalette(
  activeButton: Color(0xFF1DA1F2),
  background: Colors.white,
  card: Colors.white,
  strongText: Colors.black,
  weakText: Colors.grey,
);
