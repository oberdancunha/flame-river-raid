import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';

import '../../river_raid_game.dart';

final class Hud extends RectangleComponent {
  Hud()
      : super(
          size: Vector2(400, 90),
          position: Vector2(0, 690),
          paintLayers: [
            Paint()..color = const Color(0XFF8E8E8E),
            Paint()
              ..color = const Color(0xFF000000)
              ..strokeWidth = 2
              ..style = PaintingStyle.stroke
          ],
        );

  @override
  FutureOr<void> onLoad() {
    addAll([
      RiverRaidGame.joystick,
      RiverRaidGame.joystickButton,
    ]);
    return super.onLoad();
  }
}
