import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../constants/assets.dart';
import '../../constants/globals.dart';
import '../../gameplay/river_raid_game_play.dart';
import '../border/border.dart';
import '../stage/stage_position_component/stage_position_component.dart';

part 'enemy_manager.dart';

class EnemyComponent extends StagePositionComponent {
  bool isReverse;
  final bool hasMove;

  EnemyComponent({
    required super.position,
    required super.size,
    required super.priority,
    required super.stage,
    required this.isReverse,
    required this.hasMove,
  }) {
    enemyManager = _EnemyManager(this);
  }

  static final _random = Random();
  double speed = _random.nextDouble() * Globals.defaultMaxSpeed;
  final defaultSpeed = _random.nextDouble() * Globals.defaultMaxSpeed * 2;
  late _IEnemyManager enemyManager;

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
      enemyManager.flipDirection();
      position.x += 2 * enemyManager.moveDirection.x;
      isReverse = !isReverse;

      return;
    }
    enemyManager.explode();
    super.onCollisionStart(intersectionPoints, other);
  }
}
