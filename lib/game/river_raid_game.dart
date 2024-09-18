import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components/hud/hud.dart';
import 'constants/globals.dart';
import 'river_raid_game_manager.dart';
import 'router/river_raid_router.dart';

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

  late final riverRaidRouter = RiverRaidRouter();

  @override
  FutureOr<void> onLoad() async {
    camera.viewport.position.y = -(size.y / 7.1);
    riverRaidGameManager
      ..startGame()
      ..listAllStagesAvailable();
    add(riverRaidRouter);

    return super.onLoad();
  }
}
