import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../../constants/assets.dart';
import '../../gameplay/river_raid_game_play_mixin.dart';

final class River extends SpriteComponent with HasGamePlayRef {
  River({
    required super.position,
    required super.size,
  }) : super(
          sprite: Assets.river,
          priority: 0,
        );

  @override
  FutureOr<void> onLoad() {
    gamePlay.gamePlayManager.isBridgeExplodingNotifier.addListener(_changeBackgroundColor);

    return super.onLoad();
  }

  @override
  void onRemove() {
    gamePlay.gamePlayManager.isBridgeExplodingNotifier.removeListener(_changeBackgroundColor);
    super.onRemove();
  }

  void _changeBackgroundColor() {
    if (gamePlay.gamePlayManager.isBridgeExploding == true) {
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
            gamePlay.gamePlayManager.isBridgeExploding = false;
          }
          ..removeOnFinish = true,
      );
    }
  }
}
