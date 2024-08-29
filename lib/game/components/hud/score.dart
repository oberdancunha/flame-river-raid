import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

final class Score extends TextComponent {
  Score({
    required super.text,
    required super.position,
  }) : super(
          textRenderer: TextPaint(
            style: const TextStyle(
              fontFamily: 'Atari-Bzzz1',
              fontSize: 20,
              color: Color(0xFFE8E84A),
              letterSpacing: 1.5,
            ),
          ),
          anchor: Anchor.topCenter,
        );
}
