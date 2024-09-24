import 'package:flame_tiled/flame_tiled.dart';

import '../../../river_raid_game.dart';
import '../stage_mixin.dart';

final class FinishStage extends TiledComponent<RiverRaidGame> with StageMixin {
  FinishStage(
    super.tileMap, {
    super.position,
    super.anchor,
  });

  @override
  Future<void>? onLoad() {
    showRivers(tileMap);

    return super.onLoad();
  }
}
