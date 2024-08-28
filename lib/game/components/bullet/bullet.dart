import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../river_raid_game.dart';
import 'bullet_manager.dart';

final class Bullet extends PositionComponent
    with HasGameReference<RiverRaidGame>, CollisionCallbacks {
  Bullet({
    required super.position,
  }) : super(
          size: Vector2(2, 7),
          priority: 1,
        );

  @override
  FutureOr<void> onLoad() {
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
