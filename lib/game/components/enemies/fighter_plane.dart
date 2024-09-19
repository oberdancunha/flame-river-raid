import 'dart:async';

import 'package:flame/components.dart';

import '../../constants/globals.dart';
import '../border/border.dart';
import 'enemy_component.dart';

final class FighterPlane extends EnemyComponent {
  FighterPlane({
    required super.isReverse,
    required super.position,
    required super.size,
    required super.stage,
  }) : super(
          priority: 1,
          hasMove: true,
        );

  @override
  int get score => 100;

  @override
  double get speed => Globals.defaultSpeed * 2.5;

  @override
  double get defaultSpeed => speed;

  @override
  FutureOr<void> onLoad() {
    enemyManager.showFighterPlane();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    enemyManager.resetFighterPlaneInitialPosition();
    super.update(dt);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is! BorderComponent) {
      super.onCollisionStart(intersectionPoints, other);
    }
  }
}
