import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../constants/globals.dart';
import '../../river_raid_game.dart';
import 'hud.dart';
import 'info.dart';

abstract interface class _IHudScoreManager {
  void show();
  void update();
  String get totalAsString;
  int get totalAsStringLength;
  double get adjustPosition;
  double get horizontalPosition;
  Vector2 get position;
}

@immutable
final class _HudScoreManager implements _IHudScoreManager {
  final Hud hud;

  const _HudScoreManager(this.hud);

  @override
  void show() => hud
    ..score = Info(
      text: RiverRaidGame.totalScore.value.toString(),
      position: position,
      fontSize: hud.game.size.infoFontSize,
    )
    ..add(hud.score);

  @override
  void update() {
    hud.remove(hud.score);
    position.x -= adjustPosition;
    show();
  }

  @override
  String get totalAsString => RiverRaidGame.totalScore.value.toString();

  @override
  int get totalAsStringLength => totalAsString.length;

  @override
  double get adjustPosition => (10 * (totalAsStringLength)).toDouble();

  @override
  double get horizontalPosition =>
      (hud.game.size.fuelStatusBarHorizontalPosition + hud.game.size.fuelStatusBarSize.x) -
      adjustPosition;

  @override
  Vector2 get position => Vector2(horizontalPosition, -4);
}

extension HudScoreExtension on Hud {
  _IHudScoreManager get hudScoreManager => _HudScoreManager(this);
}
