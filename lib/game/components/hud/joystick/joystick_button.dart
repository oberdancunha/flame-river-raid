import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../../../constants/assets.dart';
import '../../../gameplay/river_raid_game_play.dart';
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

  @override
  void Function()? get onPressed {
    if (RiverRaidGamePlay.plane.planeManager.planeState != PlaneState.isDead) {
      RiverRaidGamePlay.plane.planeControllerManager.shootBullets();
    }

    return super.onPressed;
  }
}
