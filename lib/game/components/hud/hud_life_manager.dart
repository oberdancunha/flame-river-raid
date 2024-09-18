part of 'hud.dart';

abstract interface class _IHudLifeManager {
  void show();
  void update();
  Vector2 get position;
}

final class _HudLifeManager implements _IHudLifeManager {
  final Hud hud;

  _HudLifeManager(this.hud);

  late Info _life;

  @override
  void show() {
    _life = Info(
      text: hud.game.riverRaidGameManager.showLifeValue.toString(),
      position: position,
      fontSize: hud.game.size.infoFontSize,
    );
    hud.add(_life);
  }

  @override
  void update() {
    hud.remove(_life);
    show();
  }

  @override
  Vector2 get position => Vector2(
        hud.size.x / 3.2,
        (hud.game.size.fuelStatusBarVerticalPosition + hud.game.size.fuelStatusBarSize.y) - 3,
      );
}
