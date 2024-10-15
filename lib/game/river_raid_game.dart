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
import 'end/game_over.dart';
import 'extensions/size_extension.dart';
import 'gameplay/river_raid_game_play.dart';
import 'river_raid_game_state.dart';
import 'router/river_raid_router.dart';
import 'soloud.dart';

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
        ) {
    game = this;
  }

  late final _IRiverRaidGameManager riverRaidGameManager;
  late final RiverRaidRouter riverRaidRouter;
  static late RiverRaidGame game;

  @override
  FutureOr<void> onLoad() async {
    riverRaidRouter = RiverRaidRouter();
    riverRaidGameManager = _RiverRaidGameManager(this);
    riverRaidGameManager
      ..start()
      ..listAllStagesAvailable();
    add(riverRaidRouter);

    return super.onLoad();
  }

  @override
  void onRemove() {
    disposeSoLoud();
    super.onRemove();
  }

  static void start() {
    game.riverRaidGameManager.start();
    game.riverRaidRouter.pop();
    game.riverRaidRouter.pushReplacement(RiverRaidRouter.gamePlayRoute, name: RiverRaidGamePlay.id);
    if (game.paused) {
      game.resumeEngine();
    }
  }
}
