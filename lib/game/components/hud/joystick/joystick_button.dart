import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../../../constants/assets.dart';
import '../../../river_raid_game.dart';
import '../../plane/plane.dart';
import '../../plane/plane_controller_manager.dart';
import '../../plane/plane_state.dart';

final class JoystickButton extends HudButtonComponent {
  JoystickButton()
      : super(
          button: SpriteComponent(
            sprite: Assets.joystickButton,
            size: Vector2.all(buttonSize),
          ),
          buttonDown: SpriteComponent(
            sprite: Assets.joystickButtonPressed,
            size: Vector2.all(buttonSize),
          ),
          margin: const EdgeInsets.only(right: 37, bottom: 24),
        );

  static const buttonSize = 50.0;
  late PlaneComponent plane;

  @override
  void onMount() {
    super.onMount();
    plane = (game as RiverRaidGame).plane;
  }

  @override
  void Function()? get onPressed {
    if (plane.planeState != PlaneState.isDead) {
      plane.planeControllerManager.shootBullets();
    }

    return super.onPressed;
  }
}
