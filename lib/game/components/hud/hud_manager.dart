import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../constants/globals.dart';
import '../../river_raid_game.dart';
import 'hud.dart';

abstract interface class _IHudManager {
  String get totalScoreString;
  int get totalScoreStringLength;
  double get adjustScorePosition;
  double get scoreHorizontalPosition;
  Vector2 get scorePosition;
}

@immutable
final class _HudManager implements _IHudManager {
  final Hud hud;

  const _HudManager(this.hud);

  @override
  String get totalScoreString => RiverRaidGame.totalScore.value.toString();

  @override
  int get totalScoreStringLength => totalScoreString.length;

  @override
  double get adjustScorePosition => (10 * (totalScoreStringLength)).toDouble();

  @override
  double get scoreHorizontalPosition =>
      (hud.game.size.hudFuelHorizontalPosition + hud.game.size.hudFuelSize.x) - adjustScorePosition;

  @override
  Vector2 get scorePosition => Vector2(scoreHorizontalPosition, -4);
}

extension HudExtension on Hud {
  _IHudManager get hudManager => _HudManager(this);
}
