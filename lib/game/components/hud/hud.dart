import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/globals.dart';
import '../../river_raid_game.dart';
import './hud_manager.dart';
import 'fuel_status_bar/fuel_status_bar.dart';
import 'score.dart';

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

  late Score score;

  @override
  FutureOr<void> onLoad() {
    size = game.size.hudSize;
    position = Vector2(0, game.size.y + (game.camera.viewport.position.y * -1));
    score = Score(
      text: hudManager.totalScoreString,
      position: hudManager.scorePosition,
      fontSize: game.size.scoreFontSize,
    );
    addAll([
      RiverRaidGame.joystick,
      RiverRaidGame.joystickButton,
      score,
      FuelStatusBar(),
    ]);
    RiverRaidGame.totalScore.addListener(_updateTotalScore);

    return super.onLoad();
  }

  @override
  void onRemove() {
    RiverRaidGame.totalScore.removeListener(_updateTotalScore);
    super.onRemove();
  }

  void _updateTotalScore() {
    remove(score);
    hudManager.scorePosition.x -= hudManager.adjustScorePosition;
    score = Score(
      text: RiverRaidGame.totalScore.value.toString(),
      position: hudManager.scorePosition,
      fontSize: game.size.scoreFontSize,
    );
    add(score);
  }
}
