import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../constants/assets.dart';
import '../../gameplay/river_raid_game_play_mixin.dart';
import '../../sprites/sprites_explosion.dart';
import '../border/border.dart';
import '../stage/stage_position_component/stage_position_component.dart';

part 'bridge_manager.dart';

final class Bridge extends StagePositionComponent with HasGamePlayRef {
  Bridge({
    required super.position,
    required super.size,
    required super.stage,
  }) : super(
          priority: 1,
        );

  @override
  int get score => 500;

  late _IBridgeManager bridgeManager;

  @override
  FutureOr<void> onLoad() {
    bridgeManager = _BridgeManager(this);
    bridgeManager
      ..show()
      ..makeAreaCollideable();

    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is! BorderComponent) {
      super.onCollisionStart(intersectionPoints, other);
      bridgeManager.explode();
      gamePlay.gamePlayManager.isBridgeExploding = true;
    }
  }
}
