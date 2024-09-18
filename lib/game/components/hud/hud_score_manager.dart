import 'package:flame/components.dart';

import '../../constants/globals.dart';
import '../../river_raid_game_manager.dart';
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

final class _HudScoreManager implements _IHudScoreManager {
  final Hud hud;

  factory _HudScoreManager(Hud hud) => _instance = _HudScoreManager._(hud);

  _HudScoreManager._(this.hud);

  static _HudScoreManager? _instance;
  late Info _score;

  @override
  void show() {
    _score = Info(
      text: hud.game.riverRaidGameManager.showScoreValue.toString(),
      position: position,
      fontSize: hud.game.size.infoFontSize,
    );
    hud.add(_score);
  }

  @override
  void update() {
    hud.remove(_score);
    position.x -= adjustPosition;
    show();
  }

  @override
  String get totalAsString => hud.game.riverRaidGameManager.showScoreValue.toString();

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
  _IHudScoreManager get hudScoreManager => _HudScoreManager._instance ?? _HudScoreManager(this);
}
