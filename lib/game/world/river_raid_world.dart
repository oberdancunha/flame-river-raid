import 'dart:async';

import 'package:flame/components.dart';

import '../gameplay/river_raid_game_play.dart';
import '../river_raid_game.dart';
import '../river_raid_game_manager.dart';
import 'river_raid_world_manager.dart';

final class RiverRaidWorld extends World with HasGameReference<RiverRaidGame> {
  RiverRaidWorld() : super();

  @override
  FutureOr<void> onLoad() async {
    if (game.riverRaidGameManager.crossedBridges == 0) {
      RiverRaidGamePlay.stage = await riverRaidWorldManager.showStage('stage_1.tmx');
      RiverRaidGamePlay.plane = riverRaidWorldManager.showPlane(RiverRaidGamePlay.stage.tileMap);
    } else {
      final bridge = await riverRaidWorldManager.showStage('bridge.tmx', tileSize: 13);
      RiverRaidGamePlay.stage = await riverRaidWorldManager.showStage(
        game.riverRaidGameManager.stageName,
        position: Vector2(bridge.position.x, bridge.position.y + 0.2),
        anchor: Anchor.bottomLeft,
      );
      RiverRaidGamePlay.plane = riverRaidWorldManager.showPlane(bridge.tileMap);
    }
    game.camera.follow(RiverRaidGamePlay.plane, verticalOnly: true);

    return super.onLoad();
  }
}
