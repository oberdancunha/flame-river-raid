import 'dart:async';

import 'package:flame/components.dart';

import '../../../constants/globals.dart';
import '../../../river_raid_game.dart';
import 'fuel_status_bar_manager.dart';

final class FuelStatusBar extends PositionComponent with HasGameRef<RiverRaidGame> {
  FuelStatusBar();

  late SpriteComponent marker;

  @override
  FutureOr<void> onLoad() {
    size = game.size.fuelStatusBarSize;
    position = Vector2(
      game.size.fuelStatusBarHorizontalPosition,
      game.size.fuelStatusBarVerticalPosition,
    );
    fuelStatusBarManager
      ..show()
      ..showMarker();
    RiverRaidGame.fuelMarker.addListener(fuelStatusBarManager.updateFuelMarkerPosition);

    return super.onLoad();
  }

  @override
  void onRemove() {
    RiverRaidGame.fuelMarker.removeListener(fuelStatusBarManager.updateFuelMarkerPosition);
    super.onRemove();
  }
}
