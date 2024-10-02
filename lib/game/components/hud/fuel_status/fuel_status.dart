import 'dart:async';

import 'package:flame/components.dart';

import '../../../gameplay/river_raid_game_play.dart';
import '../../../gameplay/river_raid_game_play_mixin.dart';
import '../../../river_raid_game.dart';
import '../hud_tiled/hud_tiled.dart';
import 'fuel_status_empty.dart';
import 'fuel_status_marker.dart';

part 'fuel_status_manager.dart';

final class FuelStatus extends Component with HasGameRef<RiverRaidGame>, HasGamePlayRef {
  FuelStatusMarker fuelStatusMarker;
  final FuelStatusEmptyMarker fuelStatusEmptyMarker;
  final HudTiled hudTiled;

  FuelStatus({
    required this.fuelStatusMarker,
    required this.fuelStatusEmptyMarker,
    required this.hudTiled,
  });

  late _IFuelStatusManager _fuelStatusManager;

  @override
  FutureOr<void> onLoad() {
    _fuelStatusManager = _FuelStatusManager(this);
    _fuelStatusManager.show();
    RiverRaidGamePlay.fuelStatusMarker.addListener(_fuelStatusManager.update);

    return super.onLoad();
  }

  @override
  void onRemove() {
    RiverRaidGamePlay.fuelStatusMarker.removeListener(_fuelStatusManager.update);
    super.onRemove();
  }
}
