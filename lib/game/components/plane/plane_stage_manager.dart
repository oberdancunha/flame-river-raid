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
  Future<void> loadFinishStageBottom();
  Future<void> loadFinishStageTop();
}

final class _PlaneStageManger implements _IPlaneStageManager {
  final PlaneComponent plane;

  _PlaneStageManger(this.plane) {
    _currentStage = plane.gamePlay.gamePlayManager.stage;
    _currentStagePositionY = plane
        .gamePlay.gamePlayManager.lastBridge.absolutePosition.heightPositionOfTheRespectiveStage;
  }

  late Stage _currentStage;
  late double _currentStagePositionY;
  var _isCheckNextStage = true;

  @override
  bool isTimeToLoadTheNextStage() =>
      (plane.game.camera.canSee(plane.gamePlay.gamePlayManager.lastBridge) && _isCheckNextStage);

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
          position: Vector2(
            _currentStage.position.x,
            _currentStagePositionY + 0.2,
          ),
          anchor: Anchor.bottomLeft,
        );
  }

  @override
  bool crossedTheBridge() {
    if (plane.position.y <= _currentStagePositionY) {
      _currentStagePositionY = plane
          .gamePlay.gamePlayManager.lastBridge.absolutePosition.heightPositionOfTheRespectiveStage;
      plane.game.riverRaidGameManager.addCrossedBridges();

      return true;
    }

    return false;
  }

  @override
  void removePastStage() {
    (plane.game.world as RiverRaidWorld).riverRaidWorldManager.removeStage(0);
    if (plane.gamePlay.gamePlayManager.stagesPositionInWorld.length > 1) {
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

  @override
  Future<void> loadFinishStageBottom() async {
    await (plane.game.world as RiverRaidWorld).riverRaidWorldManager.showFinishStageBottom(
          position: (plane.position.y > 0.0)
              ? Vector2(_currentStage.position.x, _currentStage.position.y + 0.2)
              : Vector2(
                  _currentStage.position.x,
                  _currentStagePositionY,
                ),
          anchor: Anchor.bottomLeft,
        );
  }

  @override
  Future<void> loadFinishStageTop() async {
    await (plane.game.world as RiverRaidWorld).riverRaidWorldManager.showFinishStageTop(
          positionX: _currentStage.position.x,
        );
  }
}
