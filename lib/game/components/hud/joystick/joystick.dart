import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../../constants/assets.dart';

final class Joystick extends JoystickComponent {
  final Vector2 knobSize;
  final double marginLeft;

  Joystick({
    required super.size,
    required this.knobSize,
    required this.marginLeft,
  }) : super(
          anchor: Anchor.center,
          background: SpriteComponent(
            sprite: Assets.joystickBackground,
            size: Vector2.all(size!),
          ),
          knob: SpriteComponent(
            sprite: Assets.joystickKnob,
            size: knobSize,
          ),
          margin: EdgeInsets.only(left: marginLeft, bottom: 3.5),
        );
}
