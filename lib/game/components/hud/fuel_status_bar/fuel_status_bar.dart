import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/assets.dart';
import '../../../gameplay/river_raid_game_play_mixin.dart';
import '../../../river_raid_game.dart';

part 'fuel_status_bar_manager.dart';

final class FuelStatusBar extends PositionComponent with HasGameRef<RiverRaidGame>, HasGamePlayRef {
  FuelStatusBar({
    required super.position,
    required super.size,
  }) : super(
          priority: 1,
        );

  late _IFuelStatusBarManager _fuelStatusBarManager;

  @override
  FutureOr<void> onLoad() {
    _fuelStatusBarManager = _FuelStatusBarManager(this);
    _fuelStatusBarManager.show();

    return super.onLoad();
  }
}
