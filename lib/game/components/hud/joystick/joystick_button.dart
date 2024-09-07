import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../../../constants/assets.dart';
import '../../../river_raid_game.dart';
import '../../plane/plane.dart';
import '../../plane/plane_controller_manager.dart';
import '../../plane/plane_state.dart';

final class JoystickButton extends HudButtonComponent {
  final double marginRight;
  final double marginBottom;

  JoystickButton({
    required super.size,
    required this.marginRight,
    required this.marginBottom,
  }) : super(
          button: SpriteComponent(
            sprite: Assets.joystickButton,
            size: size,
          ),
          buttonDown: SpriteComponent(
            sprite: Assets.joystickButtonPressed,
            size: size,
          ),
          margin: EdgeInsets.only(right: marginRight, bottom: marginBottom),
        );

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
