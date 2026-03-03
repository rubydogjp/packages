import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'keyboard_style.freezed.dart';

@freezed
abstract class KeyboardStyle with _$KeyboardStyle {
  const factory KeyboardStyle({
    required Color backgroundColor,
    required Color button1BackgroundColor,
    required Color button1ForegroundColor,
    required Color button2BackgroundColor,
    required Color button2ForegroundColor,
  }) = _KeyboardStyle;

  factory KeyboardStyle.dark() => const KeyboardStyle(
        backgroundColor: Colors.black26,
        button1BackgroundColor: Color(0xFF6D6D6E),
        button1ForegroundColor: Colors.white,
        button2BackgroundColor: Color(0xFF4A4A4B),
        button2ForegroundColor: Colors.white,
      );
}
