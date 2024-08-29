import 'dart:async';

import 'package:flame/components.dart';

import 'river_raid_game.dart';
import 'river_raid_world_manager.dart';

final class RiverRaidWorld extends World with HasGameReference<RiverRaidGame> {
  RiverRaidWorld() : super();

  @override
  FutureOr<void> onLoad() async {
    game
      ..stage = await riverRaidWorldManager.showStage('stage_1.tmx')
      ..plane = riverRaidWorldManager.showPlane(game.stage.tileMap);
    game.camera.follow(game.plane, verticalOnly: true);

    return super.onLoad();
  }
}
