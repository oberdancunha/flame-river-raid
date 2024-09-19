import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';

import '../../constants/assets.dart';
import '../../gameplay/river_raid_game_play_mixin.dart';
import '../../river_raid_game.dart';
import '../../sprites/sprites_explosion.dart';
import '../border/border.dart';
import '../bridge/bridge.dart';
import '../enemies/fighter_plane.dart';
import '../enemies/helicopter.dart';
import '../enemies/ship.dart';
import '../fuel/fuel.dart';
import '../river/river.dart';
import '../river_raid_component.dart';

part 'stage_manager.dart';

final class Stage extends TiledComponent<RiverRaidGame> with HasGamePlayRef {
  Stage(
    super.tileMap, {
    super.position,
    super.anchor,
  });

  late _IStageManager stageManager;

  @override
  Future<void>? onLoad() {
    stageManager = _StageManager(this);
    stageManager
      ..showBridge()
      ..showBorders()
      ..showRivers()
      ..showShips()
      ..showHelicopters()
      ..showFighterPlanes()
      ..showFuels();

    return super.onLoad();
  }
}
