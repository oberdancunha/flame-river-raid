import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/assets.dart';
import '../../../constants/globals.dart';
import '../../../gameplay/river_raid_game_play.dart';
import '../../../river_raid_game.dart';

part 'fuel_status_bar_manager.dart';

final class FuelStatusBar extends PositionComponent with HasGameRef<RiverRaidGame>, HasGamePlayRef {
  late _IFuelStatusBarManager fuelStatusBarManager;
  late SpriteComponent marker;

  @override
  FutureOr<void> onLoad() {
    fuelStatusBarManager = _FuelStatusBarManager(this);
    size = game.size.fuelStatusBarSize;
    position = Vector2(
      game.size.fuelStatusBarHorizontalPosition,
      game.size.fuelStatusBarVerticalPosition,
    );
    fuelStatusBarManager
      ..show()
      ..showMarker();
    RiverRaidGamePlay.fuelMarker.addListener(fuelStatusBarManager.updateFuelMarkerPosition);

    return super.onLoad();
  }

  @override
  void onRemove() {
    RiverRaidGamePlay.fuelMarker.removeListener(fuelStatusBarManager.updateFuelMarkerPosition);
    super.onRemove();
  }
}
