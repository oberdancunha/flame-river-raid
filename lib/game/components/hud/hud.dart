import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/globals.dart';
import '../../river_raid_game.dart';
import 'fuel_status_bar/fuel_status_bar.dart';
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

  @override
  FutureOr<void> onLoad() {
    size = game.size.hudSize;
    position = Vector2(0, game.size.y + (game.camera.viewport.position.y * -1));
    hudScoreManager.showScore();
    addAll([
      RiverRaidGame.joystick,
      RiverRaidGame.joystickButton,
      score,
      FuelStatusBar(),
    ]);
    RiverRaidGame.totalScore.addListener(hudScoreManager.updateTotalScore);

    return super.onLoad();
  }

  @override
  void onRemove() {
    RiverRaidGame.totalScore.removeListener(hudScoreManager.updateTotalScore);
    super.onRemove();
  }
}
