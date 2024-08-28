import 'package:flame_tiled/flame_tiled.dart';

import '../../river_raid_game.dart';
import 'stage_manager.dart';

final class Stage extends TiledComponent<RiverRaidGame> {
  Stage(
    super.tileMap, {
    super.position,
    super.anchor,
  });

  @override
  Future<void>? onLoad() {
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
