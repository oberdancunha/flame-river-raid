import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';

import '../../../constants/assets.dart';
import '../../../constants/globals.dart';

final class FuelStatusMarker extends PositionComponent {
  FuelStatusMarker({
    required super.position,
    required super.size,
  }) : super(
          priority: 0,
        );

  @override
  FutureOr<void> onLoad() {
    add(
      SpriteComponent(
        sprite: Assets.fuelStatusMarker,
        size: size,
        scale: Vector2(0.85, 1),
        paint: Paint()..color = Globals.hudContentColor,
      ),
    );

    return super.onLoad();
  }
}
