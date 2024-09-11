import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../constants/globals.dart';
import '../../river_raid_game.dart';
import 'hud.dart';
import 'info.dart';

abstract interface class _IHudScoreManager {
  void showScore();
  void updateTotalScore();
  String get totalScoreString;
  int get totalScoreStringLength;
  double get adjustScorePosition;
  double get scoreHorizontalPosition;
  Vector2 get scorePosition;
}

@immutable
final class _HudScoreManager implements _IHudScoreManager {
  final Hud hud;

  const _HudScoreManager(this.hud);

  @override
  void showScore() => hud
    ..score = Info(
      text: RiverRaidGame.totalScore.value.toString(),
      position: scorePosition,
      fontSize: hud.game.size.scoreFontSize,
    )
    ..add(hud.score);

  @override
  void updateTotalScore() {
    hud.remove(hud.score);
    scorePosition.x -= adjustScorePosition;
    showScore();
  }

  @override
  String get totalScoreString => RiverRaidGame.totalScore.value.toString();

  @override
  int get totalScoreStringLength => totalScoreString.length;

  @override
  double get adjustScorePosition => (10 * (totalScoreStringLength)).toDouble();

  @override
  double get scoreHorizontalPosition =>
      (hud.game.size.fuelStatusBarHorizontalPosition + hud.game.size.fuelStatusBarSize.x) -
      adjustScorePosition;

  @override
  Vector2 get scorePosition => Vector2(scoreHorizontalPosition, -4);
}

extension HudScoreExtension on Hud {
  _IHudScoreManager get hudScoreManager => _HudScoreManager(this);
}
