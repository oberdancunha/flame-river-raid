import 'package:flame/components.dart';

import '../../../injector.dart';
import '../../constants/globals.dart';
import '../../gameplay/river_raid_game_play.dart';
import '../../river_raid_game_manager.dart';
import '../../world/river_raid_world.dart';
import '../../world/river_raid_world_manager.dart';
import '../stage/stage.dart';
import 'plane.dart';

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

  _PlaneStageManger(this.plane);

  Stage _currentStage = RiverRaidGamePlay.stage;
  double _currentStagePosition =
      RiverRaidGamePlay.lastBridge.absolutePosition.heightPositionOfTheRespectiveStage;
  bool _isCheckNextStage = true;

  @override
  bool isTimeToLoadTheNextStage() =>
      (plane.game.camera.canSee(RiverRaidGamePlay.lastBridge) && _isCheckNextStage);

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
                  RiverRaidGamePlay.lastBridge.absolutePosition.heightPositionOfTheRespectiveStage,
                ),
          anchor: Anchor.bottomLeft,
        );
  }

  @override
  bool crossedTheBridge() {
    if (plane.position.y <= _currentStagePosition - 15) {
      _currentStagePosition =
          RiverRaidGamePlay.lastBridge.absolutePosition.heightPositionOfTheRespectiveStage;
      plane.game.riverRaidGameManager.addCrossedBridges();

      return true;
    }

    return false;
  }

  @override
  void removePastStage() {
    (plane.game.world as RiverRaidWorld).riverRaidWorldManager.removeStage(0);
    if (RiverRaidGamePlay.stagesPositionInWorld.length > 1) {
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

extension PlaneStageExtension on PlaneComponent {
  _IPlaneStageManager get planeStageManager =>
      Injector.getOrAdd<_IPlaneStageManager>(_PlaneStageManger(this));
}
