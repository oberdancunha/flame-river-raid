import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../constants/globals.dart';

@immutable
final class SpritesExplosion {
  const SpritesExplosion._();

  static SpriteAnimationComponent buildAnimation({
    required List<Sprite> explosionSequence,
    required double horizontalPosition,
    required double verticalPosition,
  }) =>
      SpriteAnimationComponent(
        animation: SpriteAnimation.spriteList(
          explosionSequence,
          stepTime: Globals.explosionTime,
          loop: false,
        ),
        position: Vector2(horizontalPosition, verticalPosition),
        removeOnFinish: true,
      );
}
