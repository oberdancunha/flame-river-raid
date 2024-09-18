import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

final class Info extends TextComponent {
  final double fontSize;

  Info({
    required super.text,
    required super.position,
    required this.fontSize,
  }) : super(
          textRenderer: TextPaint(
            style: TextStyle(
              fontFamily: 'Atari-Bzzz1',
              fontSize: fontSize,
              color: const Color(0xFFE8E84A),
              letterSpacing: 1.5,
            ),
          ),
          anchor: Anchor.topCenter,
        );
}
