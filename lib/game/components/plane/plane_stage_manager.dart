part of 'plane.dart';

abstract interface class _IPlaneStageManager {
  bool isTimeToLoadTheNextStage();
  bool lastBrokenBridgeBelongsToNewStage();
  bool isThereNewStageToLoad();
  Future<void> loadNewStage();
  bool crossedTheBridge();
  void removePastStage();
  bool isLastBridgeBroken();
  void removeAllStages();
  set isCheckNextStage(bool value);
}

final class _PlaneStageManger implements _IPlaneStageManager {
  final PlaneComponent plane;

  _PlaneStageManger(this.plane) {
    _currentStage = plane.gamePlay.stage;
    _currentStagePosition =
        plane.gamePlay.lastBridge.absolutePosition.heightPositionOfTheRespectiveStage;
  }

  late Stage _currentStage;
  late double _currentStagePosition;
  bool _isCheckNextStage = true;

  @override
  bool isTimeToLoadTheNextStage() =>
      (plane.game.camera.canSee(plane.gamePlay.lastBridge) && _isCheckNextStage);

  @override
  bool lastBrokenBridgeBelongsToNewStage() =>
      plane.game.riverRaidGameManager.crossedBridges ==
      plane.game.riverRaidGameManager.nextStageToShow - 1;

  @override
  bool isThereNewStageToLoad() =>
      plane.game.riverRaidGameManager.nextStageToShow <
      plane.game.riverRaidGameManager.allStagesTotal;

  @override
  Future<void> loadNewStage() async {
    _currentStage = await (plane.game.world as RiverRaidWorld).riverRaidWorldManager.showStage(
          plane.game.riverRaidGameManager.stageName,
          position: (plane.position.y > 0.0)
              ? Vector2(_currentStage.position.x, _currentStage.position.y + 0.2)
              : Vector2(
                  _currentStage.position.x,
                  plane.gamePlay.lastBridge.absolutePosition.heightPositionOfTheRespectiveStage,
                ),
          anchor: Anchor.bottomLeft,
        );
  }

  @override
  bool crossedTheBridge() {
    if (plane.position.y <= _currentStagePosition - 15) {
      _currentStagePosition =
          plane.gamePlay.lastBridge.absolutePosition.heightPositionOfTheRespectiveStage;
      plane.game.riverRaidGameManager.addCrossedBridges();

      return true;
    }

    return false;
  }

  @override
  void removePastStage() {
    (plane.game.world as RiverRaidWorld).riverRaidWorldManager.removeStage(0);
    if (plane.gamePlay.stagesPositionInWorld.length > 1) {
      (plane.game.world as RiverRaidWorld).riverRaidWorldManager.removeStage(0);
    }
  }

  @override
  bool isLastBridgeBroken() =>
      plane.game.riverRaidGameManager.crossedBridges ==
      plane.game.riverRaidGameManager.allStagesTotal;

  @override
  void removeAllStages() =>
      (plane.game.world as RiverRaidWorld).riverRaidWorldManager.removeAllStages();

  @override
  set isCheckNextStage(bool value) => _isCheckNextStage = value;
}
