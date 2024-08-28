import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../river_raid_world.dart';
import '../../river_raid_world_manager.dart';
import 'plane.dart';

abstract interface class _IPlaneStageManager {
  bool isTimeToLoadTheNextStage();
  bool lastBrokenBridgeBelongsToNewStage();
  bool isThereNewStageToLoad();
  Future<void> loadNewStage();
  bool thePlaneIsAlmostHalfwayThroughTheCurrentStage();
  void updateMaximumHeightPosition(double nextStageHeightSize);
  bool isNotThereNewStageToBeShown();
  bool crossedTheBridge();
  void removePastStage();
  bool isLastBridgeBroken();
}

@immutable
final class _PlaneStageManger implements _IPlaneStageManager {
  final PlaneComponent plane;

  const _PlaneStageManger(this.plane);

  @override
  bool isTimeToLoadTheNextStage() => ((plane.nextStageLevelToShow == 1 || plane.position.y < 0.0) &&
      thePlaneIsAlmostHalfwayThroughTheCurrentStage() &&
      plane.continueCheckingNewStage);

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
              : Vector2(plane.currentStage.position.x, plane.maximumHeightPosition),
          anchor: Anchor.bottomLeft,
        );
  }

  @override
  void updateMaximumHeightPosition(double nextStageHeightSize) {
    if (plane.maximumHeightPosition > 0) {
      plane.maximumHeightPosition = 0.0;
    }
    plane.maximumHeightPosition = (plane.maximumHeightPosition + (nextStageHeightSize * -1)) + 0.4;
  }

  @override
  bool isNotThereNewStageToBeShown() => plane.crossedBridges == (plane.game.stages.length - 1);

  @override
  bool thePlaneIsAlmostHalfwayThroughTheCurrentStage() {
    if (plane.position.y > 0) {
      return (plane.position.y <= (plane.maximumHeightPosition + 40) / 2);
    }

    return (plane.position.y <=
        (plane.maximumHeightPosition + (plane.currentStage.size.y / 2)) + 10);
  }

  @override
  bool crossedTheBridge() {
    if (plane.position.y <= plane.currentStagePosition - 15) {
      plane.currentStagePosition = plane.maximumHeightPosition;
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
