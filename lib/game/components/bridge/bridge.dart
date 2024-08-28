import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../river_raid_game.dart';
import '../border/border.dart';
import '../stage/stage_position_component.dart';
import 'bridge_manager.dart';

final class Bridge extends StagePositionComponent
    with HasGameReference<RiverRaidGame>, CollisionCallbacks {
  Bridge({
    required super.position,
    required super.size,
    required super.stage,
  }) : super(
          priority: 1,
        );

  @override
  FutureOr<void> onLoad() {
    bridgeManager
      ..show()
      ..makeAreaCollideable();

    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is! BorderComponent) {
      bridgeManager
        ..explode()
        ..removeFromWorld();
      game.isBridgeExploding.value = true;
    }
  }
}
