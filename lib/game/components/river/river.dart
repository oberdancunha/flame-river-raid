import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../../constants/assets.dart';
import '../../river_raid_game.dart';

final class River extends SpriteComponent with HasGameReference<RiverRaidGame> {
  River({
    required super.position,
    required super.size,
  }) : super(
          sprite: Assets.river,
          priority: 0,
        );

  @override
  FutureOr<void> onLoad() {
    game.isBridgeExploding.addListener(_changeBackgroundColor);

    return super.onLoad();
  }

  @override
  void onRemove() {
    game.isBridgeExploding.removeListener(_changeBackgroundColor);
    super.onRemove();
  }

  void _changeBackgroundColor() {
    if (game.isBridgeExploding.value == true) {
      add(
        ColorEffect(
          const Color.fromARGB(255, 210, 1, 1),
          EffectController(
            alternate: true,
            duration: 0.05,
            repeatCount: 4,
          ),
        )
          ..onComplete = () {
            game.isBridgeExploding.value = false;
          }
          ..removeOnFinish = true,
      );
    }
  }
}
