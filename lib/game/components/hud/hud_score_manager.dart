part of 'hud.dart';

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

  _HudScoreManager(this.hud);

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
