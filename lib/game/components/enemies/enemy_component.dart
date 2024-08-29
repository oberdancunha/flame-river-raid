import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';

import '../../constants/globals.dart';
import '../../river_raid_game.dart';
import '../border/border.dart';
import '../stage/stage_position_component/stage_position_component.dart';
import 'enemy_manager.dart';

class EnemyComponent extends StagePositionComponent with HasGameReference<RiverRaidGame> {
  bool isReverse;
  final bool hasMove;

  EnemyComponent({
    required super.position,
    required super.size,
    required super.priority,
    required super.stage,
    required this.isReverse,
    required this.hasMove,
  });

  static final random = Random();
  Vector2 moveDirection = Vector2(0, 0);
  double speed = random.nextDouble() * Globals.defaultSpeed;
  final defaultSpeed = random.nextDouble() * Globals.defaultSpeed * 2;

  @override
  FutureOr<void> onLoad() {
    enemyManager.makeAreaCollideable();
    if (isReverse) {
      flipHorizontallyAroundCenter();
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (hasMove == true) {
      enemyManager.makeMovement(dt);
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BorderComponent) {
      flipHorizontallyAroundCenter();
      moveDirection.x *= -1;
      position.x += 2 * moveDirection.x;
      isReverse = !isReverse;

      return;
    }
    enemyManager.explode();
    super.onCollisionStart(intersectionPoints, other);
  }
}
