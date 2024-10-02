import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

import '../../constants/globals.dart';

final class Info extends TextComponent {
  Info({
    required super.text,
    required super.position,
    required super.anchor,
  }) : super(
          textRenderer: TextPaint(
            style: const TextStyle(
              fontFamily: 'River-Raid-Font',
              fontSize: 16,
              color: Globals.hudContentColor,
            ),
          ),
        );
}
