import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/assets.dart';

final class Joystick extends JoystickComponent {
  Joystick()
      : super(
          anchor: Anchor.center,
          background: SpriteComponent(
            sprite: Assets.joystickBackground,
            size: Vector2.all(75),
          ),
          knob: SpriteComponent(
            sprite: Assets.joystickKnob,
            size: Vector2.all(50),
          ),
          margin: const EdgeInsets.only(left: 20, bottom: -15),
        );
}
