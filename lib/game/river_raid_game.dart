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
import 'extensions/size_extension.dart';
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
        );

  late final _IRiverRaidGameManager riverRaidGameManager;
  late final RiverRaidRouter riverRaidRouter;

  @override
  FutureOr<void> onLoad() async {
    riverRaidRouter = RiverRaidRouter(this);
    riverRaidGameManager = _RiverRaidGameManager(this);
    camera.viewport.position.y = -(size.y / 7.1);
    riverRaidGameManager
      ..startGame()
      ..listAllStagesAvailable();
    add(riverRaidRouter);

    return super.onLoad();
  }

  @override
  void onRemove() {
    disposeSoLoud();
    super.onRemove();
  }
}
