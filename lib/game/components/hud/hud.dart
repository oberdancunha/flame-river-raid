import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../extensions/size_extension.dart';
import '../../river_raid_game.dart';
import '../river_raid_component.dart';
import 'hud_tiled/hud_tiled.dart';

part 'hud_manager.dart';

final class Hud extends RectangleComponent with HasGameRef<RiverRaidGame> {
  Hud()
      : super(
          anchor: Anchor.bottomLeft,
          paintLayers: [
            Paint()..color = const Color(0XFF8E8E8E),
            Paint()
              ..color = const Color(0xFF000000)
              ..strokeWidth = 2
              ..style = PaintingStyle.stroke
          ],
        );

  late _IHudManager _hudManager;

  @override
  FutureOr<void> onLoad() async {
    size = game.size.hudSize;
    position = Vector2(0, game.size.y + (game.camera.viewport.position.y * -1));
    add(game.riverRaidGameManager.joystick);
    _hudManager = _HudManager(this);
    await _hudManager.loadHudTiled();
    add(game.riverRaidGameManager.joystickButton);

    return super.onLoad();
  }
}
