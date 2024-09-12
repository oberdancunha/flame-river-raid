import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/globals.dart';
import '../../river_raid_game.dart';
import 'fuel_status_bar/fuel_status_bar.dart';
import 'hud_life_manager.dart';
import 'hud_score_manager.dart';
import 'info.dart';

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

  late Info score;
  late Info life;

  @override
  FutureOr<void> onLoad() {
    size = game.size.hudSize;
    position = Vector2(0, game.size.y + (game.camera.viewport.position.y * -1));
    hudScoreManager.show();
    hudLifeManager.show();
    addAll([
      RiverRaidGame.joystick,
      FuelStatusBar(),
      RiverRaidGame.joystickButton,
    ]);
    RiverRaidGame.totalScore.addListener(hudScoreManager.update);
    RiverRaidGame.totalLife.addListener(hudLifeManager.update);

    return super.onLoad();
  }

  @override
  void onRemove() {
    RiverRaidGame.totalScore.removeListener(hudScoreManager.update);
    RiverRaidGame.totalLife.removeListener(hudLifeManager.update);

    super.onRemove();
  }
}
