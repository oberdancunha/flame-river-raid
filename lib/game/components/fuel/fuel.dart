import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../constants/assets.dart';
import '../bullet/bullet.dart';
import '../stage/stage_position_component/stage_position_component.dart';

part 'fuel_manager.dart';

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

  late _IFuelManager fuelManager;

  @override
  FutureOr<void> onLoad() {
    fuelManager = _FuelManager(this);
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
