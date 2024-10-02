part of 'score.dart';

abstract interface class _IScoreManager {
  void show();
  void update();
}

final class _ScoreManager implements _IScoreManager {
  final Score score;

  _ScoreManager(this.score);

  late Info _score;

  @override
  void show() {
    _score = Info(
      text: score.game.riverRaidGameManager.showScoreValue.toString(),
      position: Vector2(score.size.x - 1, score.size.y / 2.5),
      anchor: Anchor.centerRight,
    );
    score.add(_score);
  }

  @override
  void update() {
    score.remove(_score);
    show();
  }
}
