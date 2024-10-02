import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';

import '../../../river_raid_game.dart';
import '../../river_raid_component.dart';
import '../fuel_status/fuel_status.dart';
import '../fuel_status/fuel_status_empty.dart';
import '../fuel_status/fuel_status_marker.dart';
import '../fuel_status_bar/fuel_status_bar.dart';
import '../life/life.dart';
import '../score/score.dart';

part 'hud_tiled_manager.dart';

final class HudTiled extends TiledComponent<RiverRaidGame> {
  HudTiled(
    super.tileMap, {
    required super.position,
    super.scale,
  }) : super(
          priority: 0,
        );

  late _IHudTiledManager _hudTiledManager;

  @override
  Future<void>? onLoad() {
    _hudTiledManager = _HudTiledManager(this);
    _hudTiledManager
      ..showScore()
      ..showFuelStatusBar()
      ..showFuelStatus()
      ..showLife();

    return super.onLoad();
  }
}
