import 'dart:async';

import 'package:flame/components.dart';

import '../../../constants/globals.dart';
import '../../../river_raid_game.dart';
import 'fuel_status_bar_manager.dart';

final class FuelStatusBar extends PositionComponent with HasGameRef<RiverRaidGame> {
  FuelStatusBar();

  @override
  FutureOr<void> onLoad() {
    size = game.size.hudFuelSize;
    position = Vector2(game.size.hudFuelHorizontalPosition, 22);
    fuelStatusBarManager
      ..show()
      ..showMarker();

    return super.onLoad();
  }
}
