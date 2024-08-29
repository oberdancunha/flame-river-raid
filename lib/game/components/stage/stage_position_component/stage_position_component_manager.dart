import 'package:flutter/foundation.dart';

import '../../../river_raid_game.dart';
import 'stage_position_component.dart';

abstract interface class _IStagePositionComponentManager {
  void remove();
  void sumScore();
}

@immutable
final class _StagePositionComponentManager implements _IStagePositionComponentManager {
  final StagePositionComponent stagePositionComponent;

  const _StagePositionComponentManager(this.stagePositionComponent);

  @override
  void remove() => stagePositionComponent.removeFromParent();

  @override
  void sumScore() => RiverRaidGame.totalScore.value += stagePositionComponent.score;
}

extension StagePositionComponentExtension on StagePositionComponent {
  _IStagePositionComponentManager get stagePositionComponentManager =>
      _StagePositionComponentManager(this);
}
