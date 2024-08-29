import 'dart:async';

import 'package:flame/components.dart';

import '../bullet/bullet.dart';
import '../stage/stage_position_component/stage_position_component.dart';
import 'fuel_manager.dart';

final class Fuel extends StagePositionComponent {
  Fuel({
    required super.position,
    required super.size,
    required super.stage,
  }) : super(
          priority: 1,
        );

  @override
  int get score => 80;

  @override
  FutureOr<void> onLoad() {
    fuelManager
      ..show()
      ..makeAreaCollideable();

    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Bullet) {
      super.onCollisionStart(intersectionPoints, other);
      fuelManager.explode();
    }
  }
}
