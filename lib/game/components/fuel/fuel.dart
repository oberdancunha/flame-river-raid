import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../constants/assets.dart';
import '../../constants/globals.dart';
import '../../gameplay/river_raid_game_play.dart';
import '../../soloud.dart';
import '../bullet/bullet.dart';
import '../plane/plane.dart';
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

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is PlaneComponent) {
      gamePlay.audioManager.stopFlyNoise();
      gamePlay.audioManager.fuel(
        RiverRaidGamePlay.fuelStatusMarker.value.roundToDouble() == Globals.indexFullFuel
            ? soloudFuelTankFilled
            : soloudFuelUp,
      );
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is PlaneComponent) {
      gamePlay.audioManager.fly();
    }
  }
}
