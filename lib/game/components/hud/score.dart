import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

import '../../river_raid_game.dart';

final class Score extends TextComponent with HasGameRef<RiverRaidGame> {
  final double fontSize;

  Score({
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
