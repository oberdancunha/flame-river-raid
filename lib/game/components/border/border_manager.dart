import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

import 'border.dart';

abstract interface class _IBorderManager {
  void makeAreaCollideable();
}

@immutable
final class _BorderManager implements _IBorderManager {
  final BorderComponent border;

  const _BorderManager(this.border);

  @override
  void makeAreaCollideable() => border.add(
        RectangleHitbox(
          collisionType: CollisionType.active,
        ),
      );
}

extension BorderExtenson on BorderComponent {
  _IBorderManager get borderManager => _BorderManager(this);
}
