import 'package:flame/components.dart';

import '../../constants/globals.dart';
import '../../river_raid_game_manager.dart';
import 'hud.dart';
import 'info.dart';

abstract interface class _IHudLifeManager {
  void show();
  void update();
  Vector2 get position;
}

final class _HudLifeManager implements _IHudLifeManager {
  final Hud hud;

  factory _HudLifeManager(Hud hud) => _instance = _HudLifeManager._(hud);

  _HudLifeManager._(this.hud);

  static _HudLifeManager? _instance;
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

extension HudLifeExtension on Hud {
  _IHudLifeManager get hudLifeManager => _HudLifeManager._instance ?? _HudLifeManager(this);
}
