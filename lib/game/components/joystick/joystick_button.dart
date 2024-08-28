import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../../constants/assets.dart';
import '../plane/plane.dart';
import '../plane/plane_controller_manager.dart';
import '../plane/plane_state.dart';

final class JoystickButton extends HudButtonComponent {
  final PlaneComponent plane;

  JoystickButton(this.plane)
      : super(
          button: SpriteComponent(
            sprite: Assets.joystickButton,
            size: Vector2.all(40),
          ),
          buttonDown: SpriteComponent(
            sprite: Assets.joystickButtonPressed,
            size: Vector2.all(40),
          ),
          margin: const EdgeInsets.only(right: 20, bottom: -5),
        );

  @override
  void Function()? get onPressed {
    if (plane.planeState != PlaneState.isDead) {
      plane.planeControllerManager.shootBullets();
    }

    return super.onPressed;
  }
}
