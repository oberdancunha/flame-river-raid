import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../constants/assets.dart';
import '../../gameplay/river_raid_game_play.dart';
import '../../river_raid_game.dart';

part 'bullet_manager.dart';

final class Bullet extends PositionComponent with HasGameRef<RiverRaidGame>, CollisionCallbacks {
  Bullet({
    required super.position,
  }) : super(
          size: Vector2(2, 7),
          priority: 1,
        );

  late _IBulletManager bulletManager;

  @override
  FutureOr<void> onLoad() {
    bulletManager = _BulletManager(this);
    bulletManager
      ..show()
      ..makeAreaCollideable();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    bulletManager.bulletPath(dt);
    if (bulletManager.isMaximumDistanceTraveled()) {
      bulletManager.removeFromWorld();
    }

    super.update(dt);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    bulletManager.removeFromWorld();
  }
}
