part of 'stage_position_component.dart';

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
  void sumScore() =>
      stagePositionComponent.game.riverRaidGameManager.sumScore(stagePositionComponent.score);
}
