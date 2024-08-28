import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../constants/assets.dart';
import '../stage/stage_manager.dart';
import 'fuel.dart';

abstract interface class _IFuelManager {
  void show();
  void makeAreaCollideable();
  void explode();
  void remove();
}

@immutable
final class _FuelManager implements _IFuelManager {
  final Fuel fuel;

  const _FuelManager(this.fuel);

  @override
  void show() => fuel.add(SpriteComponent(
        sprite: Assets.fuel,
      ));

  @override
  void makeAreaCollideable() => fuel.add(
        RectangleHitbox(
          collisionType: CollisionType.active,
        ),
      );

  @override
  void explode() => fuel.stage.stageManager.explode(
        horizontalPosition: fuel.position.x,
        verticalPosition: fuel.position.y,
      );

  @override
  void remove() => fuel.removeFromParent();
}

extension FuelExtension on Fuel {
  _IFuelManager get fuelManager => _FuelManager(this);
}
