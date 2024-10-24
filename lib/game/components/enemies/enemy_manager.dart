part of 'enemy_component.dart';

abstract interface class _IEnemyManager {
  void showShip();
  void showHelicopter();
  void showFighterPlane();
  void makeAreaCollideable();
  void explode();
  void makeMovement(double dt);
  void resetFighterPlaneInitialPosition();
  double get distanceFromPlane;
  bool isPlaneInTheFirstStage();
  double calculateDistanceToFirstStage();
  bool planeIsNotInFirstStage();
  double calculateDistanceInOtherStages();
  void moveLeft();
  void moveRight();
  void flipDirection();
  Vector2 get moveDirection;
}

final class _EnemyManager implements _IEnemyManager {
  final EnemyComponent enemy;

  _EnemyManager(this.enemy);

  final Vector2 _moveDirection = Vector2(0, 0);

  @override
  void showShip() => enemy.add(
        SpriteComponent(
          sprite: Assets.ship,
        ),
      );

  @override
  void showHelicopter() => enemy.add(
        SpriteAnimationComponent(
          animation: Assets.helicopter,
          size: enemy.size,
        ),
      );

  @override
  void showFighterPlane() => enemy.add(
        SpriteComponent(
          sprite: Assets.fighterPlane,
        ),
      );

  @override
  void makeAreaCollideable() => enemy.add(
        RectangleHitbox(
          collisionType: CollisionType.active,
        ),
      );

  @override
  void explode() {
    final normalizePosition = enemy.size.x / 4;
    double horizontalPosition = enemy.position.x + normalizePosition;
    if (enemy.isReverse) {
      final initialPosition = enemy.position.x - enemy.size.x;
      final padding = normalizePosition / 2;
      final initialPositionPadding = initialPosition + padding;
      horizontalPosition = initialPositionPadding + normalizePosition;
    }
    enemy.stage.stageManager.explode(
      horizontalPosition: horizontalPosition,
      verticalPosition: enemy.position.y,
    );
  }

  @override
  void makeMovement(double dt) {
    if (distanceFromPlane <= Globals.minimalPlaneDistanceToEnemyMovement) {
      if (enemy.isReverse) {
        moveLeft();
      } else {
        moveRight();
      }
      _moveDirection.normalize();
      enemy.speed = lerpDouble(enemy.speed, enemy.defaultSpeed, Globals.acceleration * dt)!;
      enemy.position.addScaled(_moveDirection, enemy.speed * dt);
    }
  }

  @override
  void resetFighterPlaneInitialPosition() {
    if (enemy.isReverse && enemy.position.x <= 0) {
      enemy.position.x = enemy.stage.size.x;
    } else {
      if (enemy.position.x >= enemy.stage.size.x) {
        enemy.position.x = 0.0;
      }
    }
  }

  @override
  double get distanceFromPlane {
    if (isPlaneInTheFirstStage()) {
      return calculateDistanceToFirstStage();
    }
    if (planeIsNotInFirstStage()) {
      return calculateDistanceInOtherStages();
    }

    return Globals.minimalPlaneDistanceToEnemyMovement + 10.0;
  }

  @override
  bool isPlaneInTheFirstStage() => enemy.stage.position.y == 0.0;

  @override
  double calculateDistanceToFirstStage() => RiverRaidGamePlay.plane.position.y - enemy.position.y;

  @override
  bool planeIsNotInFirstStage() =>
      enemy.stage.position.y != 0.0 && RiverRaidGamePlay.plane.position.y < 0.0;

  @override
  double calculateDistanceInOtherStages() {
    final enemyPositionY =
        ((enemy.position.y * -1) - enemy.stage.stageManager.getHeightPositionInGame()) * -1;

    return RiverRaidGamePlay.plane.position.y - enemyPositionY;
  }

  @override
  void moveLeft() => _moveDirection.x = -1;

  @override
  void moveRight() => _moveDirection.x = 1;

  @override
  void flipDirection() => _moveDirection.x *= -1;

  @override
  Vector2 get moveDirection => _moveDirection;
}
