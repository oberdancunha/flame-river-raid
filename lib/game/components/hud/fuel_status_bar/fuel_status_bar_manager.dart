import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import '../../../constants/assets.dart';
import '../../../constants/globals.dart';
import '../../../gameplay/river_raid_game_play.dart';
import 'fuel_status_bar.dart';

abstract interface class _IFuelStatusBarManager {
  void show();
  void showMarker();
  void updateFuelMarkerPosition();
}

@immutable
final class _FuelStatusBarManager implements _IFuelStatusBarManager {
  final FuelStatusBar fuelStatusBar;

  const _FuelStatusBarManager(this.fuelStatusBar);

  @override
  void show() => fuelStatusBar.add(
        SpriteComponent(
          sprite: Assets.fuelStatusBar,
          size: fuelStatusBar.game.size.fuelStatusBarSize,
          priority: 1,
        ),
      );

  @override
  void showMarker() {
    final fuelAmount = RiverRaidGamePlay.fuelMarker.value / 100;
    fuelStatusBar
      ..marker = SpriteComponent(
        sprite: Assets.fuelStatusMarker,
        paint: Paint()..color = const Color(0xFFFBFB79),
        position: Vector2(
          fuelStatusBar.game.size.fuelMarkerHorizontalPosition * fuelAmount,
          fuelStatusBar.game.size.fuelMarkerVerticalPosition,
        ),
        size: fuelStatusBar.game.size.fullFuelMarkerSize,
        priority: 0,
      )
      ..add(fuelStatusBar.marker);
  }

  @override
  void updateFuelMarkerPosition() {
    fuelStatusBar.remove(fuelStatusBar.marker);
    showMarker();
  }
}

extension FuelStatusBarManager on FuelStatusBar {
  _IFuelStatusBarManager get fuelStatusBarManager => _FuelStatusBarManager(this);
}
