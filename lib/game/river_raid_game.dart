import 'dart:async';
import 'dart:convert';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'components/hud/hud.dart';
import 'components/hud/joystick/joystick.dart';
import 'components/hud/joystick/joystick_button.dart';
import 'constants/globals.dart';
import 'router/river_raid_router.dart';

part 'river_raid_game_manager.dart';

final class RiverRaidGame extends FlameGame with HasCollisionDetection {
  RiverRaidGame()
      : super(
          camera: CameraComponent(
            hudComponents: [
              Hud(),
            ],
          )
            ..viewport.size = Globals.gameSize
            ..viewfinder.visibleGameSize = Globals.gameSize
            ..viewfinder.position = Vector2(0, 0)
            ..viewfinder.anchor = Anchor.bottomLeft,
        );

  late _IRiverRaidGameManager riverRaidGameManager;
  late final riverRaidRouter = RiverRaidRouter();

  @override
  FutureOr<void> onLoad() async {
    riverRaidGameManager = _RiverRaidGameManager(this);
    camera.viewport.position.y = -(size.y / 7.1);
    riverRaidGameManager
      ..startGame()
      ..listAllStagesAvailable();
    add(riverRaidRouter);

    return super.onLoad();
  }
}
