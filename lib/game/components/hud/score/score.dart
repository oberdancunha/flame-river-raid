import 'dart:async';

import 'package:flame/components.dart';

import '../../../river_raid_game.dart';
import '../info.dart';

part 'score_manager.dart';

final class Score extends PositionComponent with HasGameRef<RiverRaidGame> {
  Score({
    required super.position,
    required super.size,
  });

  late _IScoreManager _scoreManager;

  @override
  FutureOr<void> onLoad() {
    _scoreManager = _ScoreManager(this);
    _scoreManager.show();
    game.riverRaidGameManager.showScore.addListener(_scoreManager.update);

    return super.onLoad();
  }

  @override
  void onRemove() {
    game.riverRaidGameManager.showScore.removeListener(_scoreManager.update);
    super.onRemove();
  }
}
