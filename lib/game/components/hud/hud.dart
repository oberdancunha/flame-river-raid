import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/globals.dart';
import '../../river_raid_game.dart';
import 'fuel_status_bar/fuel_status_bar.dart';
import 'info.dart';

part 'hud_life_manager.dart';
part 'hud_score_manager.dart';

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

  late _IHudScoreManager hudScoreManager;
  late _IHudLifeManager hudLifeManager;

  @override
  FutureOr<void> onLoad() {
    hudScoreManager = _HudScoreManager(this);
    hudLifeManager = _HudLifeManager(this);
    size = game.size.hudSize;
    position = Vector2(0, game.size.y + (game.camera.viewport.position.y * -1));
    hudScoreManager.show();
    hudLifeManager.show();
    addAll([
      game.riverRaidGameManager.joystick,
      FuelStatusBar(),
      game.riverRaidGameManager.joystickButton,
    ]);
    game.riverRaidGameManager.showScore.addListener(hudScoreManager.update);
    game.riverRaidGameManager.showLife.addListener(hudLifeManager.update);

    return super.onLoad();
  }

  @override
  void onRemove() {
    game.riverRaidGameManager.showScore.removeListener(hudScoreManager.update);
    game.riverRaidGameManager.showLife.removeListener(hudLifeManager.update);

    super.onRemove();
  }
}
