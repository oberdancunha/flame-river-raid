import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../constants/globals.dart';
import '../../river_raid_game.dart';
import 'hud.dart';
import 'info.dart';

abstract interface class _IHudLifeManager {
  void show();
  void update();
  Vector2 get position;
}

@immutable
final class _HudLifeManager implements _IHudLifeManager {
  final Hud hud;

  const _HudLifeManager(this.hud);

  @override
  void show() => hud
    ..life = Info(
      text: RiverRaidGame.totalLife.value.toString(),
      position: position,
      fontSize: hud.game.size.infoFontSize,
    )
    ..add(hud.life);

  @override
  void update() {
    hud.remove(hud.life);
    show();
  }

  @override
  Vector2 get position => Vector2(
        hud.size.x / 3.2,
        (hud.game.size.fuelStatusBarVerticalPosition + hud.game.size.fuelStatusBarSize.y) - 3,
      );
}

extension HudLifeExtension on Hud {
  _IHudLifeManager get hudLifeManager => _HudLifeManager(this);
}
