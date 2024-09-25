part of 'finish_stage.dart';

abstract interface class _IFinishStageManager {
  void showFireworks();
}

@immutable
final class _FinishStageManager implements _IFinishStageManager {
  final FinishStage finishStage;

  const _FinishStageManager(this.finishStage);

  @override
  void showFireworks() {
    final fireworksLayer = RiverRaidComponent.getLayer(finishStage.tileMap, 'Fireworks');
    for (final fireworkObject in fireworksLayer) {
      final firework = Firework(
        position: fireworkObject.position,
        size: fireworkObject.size,
      );
      finishStage.add(firework);
    }
  }
}
