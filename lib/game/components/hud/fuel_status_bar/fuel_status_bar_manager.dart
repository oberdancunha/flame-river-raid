import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/assets.dart';
import '../../../constants/globals.dart';
import 'fuel_status_bar.dart';

abstract interface class _IFuelStatusBarManager {
  void show();
  void showMarker();
}

@immutable
final class _FuelStatusBarManager implements _IFuelStatusBarManager {
  final FuelStatusBar fuelStatusBar;

  const _FuelStatusBarManager(this.fuelStatusBar);

  @override
  void show() => fuelStatusBar.add(
        SpriteComponent(
          sprite: Assets.fuelStatusBar,
          size: fuelStatusBar.game.size.hudFuelSize,
          priority: 1,
        ),
      );

  @override
  void showMarker() => fuelStatusBar.add(
        SpriteComponent(
          sprite: Assets.fuelStatusMarker,
          position: Vector2(
            fuelStatusBar.game.size.hudFuelHorizontalPosition -
                (fuelStatusBar.game.size.hudFuelSize.x / 15),
            Globals.fuelMarkerVerticalPosition,
          ),
          size: fuelStatusBar.game.size.fullFuelMarkerSize,
          priority: 0,
        ),
      );
}

extension FuelStatusBarManager on FuelStatusBar {
  _IFuelStatusBarManager get fuelStatusBarManager => _FuelStatusBarManager(this);
}
