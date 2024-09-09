import 'package:flame/collisions.dart';
import 'package:flutter/foundation.dart';

import '../../constants/assets.dart';
import 'plane.dart';
import 'plane_state.dart';

abstract interface class _IPlaneManager {
  void planeStraight();
  void waitToStartFlight();
  void makeAreaCollideable();
  void planeLeft();
  void planeRight();
  void planeExplosion();
}

@immutable
final class _PlaneManager implements _IPlaneManager {
  final PlaneComponent plane;

  const _PlaneManager(this.plane);

  @override
  void waitToStartFlight() {
    Future.delayed(const Duration(milliseconds: 300), () {
      plane.planeState = PlaneState.isAlive;
    });
  }

  @override
  void makeAreaCollideable() => plane.add(
        RectangleHitbox(
          collisionType: CollisionType.passive,
        ),
      );

  @override
  void planeStraight() => plane.sprite = Assets.plane;

  @override
  void planeLeft() => plane.sprite = Assets.planeLeft;

  @override
  void planeRight() => plane.sprite = Assets.planeRight;

  @override
  void planeExplosion() => plane.sprite = Assets.planeExplosion;
}

extension PlaneExtension on PlaneComponent {
  _IPlaneManager get planeManager => _PlaneManager(this);
}
