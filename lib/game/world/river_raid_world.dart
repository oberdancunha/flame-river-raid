import 'dart:async';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';

import '../components/plane/plane.dart';
import '../components/river_raid_component.dart';
import '../components/stage/stage.dart';
import '../gameplay/river_raid_game_play.dart';
import '../river_raid_game.dart';

part 'river_raid_world_manager.dart';

final class RiverRaidWorld extends World with HasGameReference<RiverRaidGame>, HasGamePlayRef {
  RiverRaidWorld() : super();

  late _IRiverRaidWorldManager riverRaidWorldManager;

  @override
  FutureOr<void> onLoad() async {
    riverRaidWorldManager = _RiverRaidWorldManager(this);
    if (game.riverRaidGameManager.crossedBridges == 0) {
      gamePlay.stage = await riverRaidWorldManager.showStage('stage_1.tmx');
      RiverRaidGamePlay.plane = riverRaidWorldManager.showPlane(gamePlay.stage.tileMap);
    } else {
      final bridge = await riverRaidWorldManager.showStage('bridge.tmx', tileSize: 13);
      gamePlay.stage = await riverRaidWorldManager.showStage(
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
