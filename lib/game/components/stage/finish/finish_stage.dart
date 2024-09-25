import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';

import '../../../river_raid_game.dart';
import '../../firework/firework.dart';
import '../../river_raid_component.dart';
import '../stage_mixin.dart';

part 'finish_stage_manager.dart';

final class FinishStage extends TiledComponent<RiverRaidGame> with StageMixin {
  final bool isExplodeFireworksAutomatically;

  FinishStage(
    super.tileMap, {
    super.position,
    super.anchor,
    this.isExplodeFireworksAutomatically = false,
  });

  late _IFinishStageManager _finishStageManager;

  @override
  Future<void>? onLoad() {
    _finishStageManager = _FinishStageManager(this);
    showRivers(tileMap);
    _finishStageManager.showFireworks();

    return super.onLoad();
  }
}
