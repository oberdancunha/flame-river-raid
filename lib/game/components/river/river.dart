import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../../constants/assets.dart';
import '../../gameplay/river_raid_game_play.dart';

final class River extends SpriteComponent {
  River({
    required super.position,
    required super.size,
  }) : super(
          sprite: Assets.river,
          priority: 0,
        );

  @override
  FutureOr<void> onLoad() {
    RiverRaidGamePlay.isBridgeExploding.addListener(_changeBackgroundColor);

    return super.onLoad();
  }

  @override
  void onRemove() {
    RiverRaidGamePlay.isBridgeExploding.removeListener(_changeBackgroundColor);
    super.onRemove();
  }

  void _changeBackgroundColor() {
    if (RiverRaidGamePlay.isBridgeExploding.value == true) {
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
            RiverRaidGamePlay.isBridgeExploding.value = false;
          }
          ..removeOnFinish = true,
      );
    }
  }
}
