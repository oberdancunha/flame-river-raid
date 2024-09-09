import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../constants/globals.dart';
import '../../river_raid_world.dart';
import '../../river_raid_world_manager.dart';
import 'plane.dart';

abstract interface class _IPlaneStageManager {
  bool isTimeToLoadTheNextStage();
  bool lastBrokenBridgeBelongsToNewStage();
  bool isThereNewStageToLoad();
  Future<void> loadNewStage();
  bool crossedTheBridge();
  void removePastStage();
  bool isLastBridgeBroken();
}

@immutable
final class _PlaneStageManger implements _IPlaneStageManager {
  final PlaneComponent plane;

  const _PlaneStageManger(this.plane);

  @override
  bool isTimeToLoadTheNextStage() =>
      (plane.game.camera.canSee(plane.game.lastBridge) && plane.isCheckNextStage);

  @override
  bool lastBrokenBridgeBelongsToNewStage() =>
      plane.crossedBridges == plane.nextStageLevelToShow - 1;

  @override
  bool isThereNewStageToLoad() => plane.nextStageLevelToShow < plane.game.stages.length;

  @override
  Future<void> loadNewStage() async {
    final stageName = 'stage_${plane.nextStageLevelToShow}.tmx';
    plane.currentStage = await (plane.game.world as RiverRaidWorld).riverRaidWorldManager.showStage(
          stageName,
          position: (plane.position.y > 0.0)
              ? Vector2(plane.currentStage.position.x, plane.currentStage.position.y + 0.2)
              : Vector2(
                  plane.currentStage.position.x,
                  plane.game.lastBridge.absolutePosition.heightPositionOfTheRespectiveStage,
                ),
          anchor: Anchor.bottomLeft,
        );
  }

  @override
  bool crossedTheBridge() {
    if (plane.position.y <= plane.currentStagePosition - 15) {
      plane.currentStagePosition =
          plane.game.lastBridge.absolutePosition.heightPositionOfTheRespectiveStage;
      plane.crossedBridges++;

      return true;
    }

    return false;
  }

  @override
  void removePastStage() =>
      (plane.game.world as RiverRaidWorld).riverRaidWorldManager.removeStage();

  @override
  bool isLastBridgeBroken() => plane.crossedBridges == plane.game.stages.length;
}

extension PlaneStageExtension on PlaneComponent {
  _IPlaneStageManager get planeStageManager => _PlaneStageManger(this);
}
