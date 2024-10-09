import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

import '../components/bridge/bridge.dart';
import '../components/plane/plane.dart';
import '../components/plane/plane_speed_enum.dart';
import '../components/plane/plane_state.dart';
import '../components/stage/stage.dart';
import '../constants/globals.dart';
import '../river_raid_game.dart';
import '../soloud.dart';
import '../world/river_raid_world.dart';

part 'river_raid_game_play_audio_manager.dart';
part 'river_raid_game_play_manager.dart';
part 'river_raid_game_play_reset_timer_manager.dart';

final class RiverRaidGamePlay extends Component with HasGameRef<RiverRaidGame> {
  RiverRaidGamePlay({
    super.key,
  });

  static const id = 'Gameplay';

  late _IRiverRaidGamePlayResetTimerManager resetTimerManager;
  late _IRiverRaidGamePlayManager gamePlayManager;
  late _IRiverRaidGamePlayAudioManager audioManager;
  late RiverRaidWorld _riverRaidWorld;

  static late PlaneComponent plane;
  static ValueNotifier<double> fuelStatusMarker = ValueNotifier<double>(Globals.indexFullFuel);
  static bool isOutOfFuel = false;

  @override
  FutureOr<void> onLoad() async {
    resetTimerManager = _RiverRaidGamePlayResetTimerManager();
    gamePlayManager = _RiverRaidGamePlayManager();
    audioManager = _RiverRaidGamePlayAudioSoloudManager();
    _riverRaidWorld = RiverRaidWorld();
    add(_riverRaidWorld);
    game.world = _riverRaidWorld;
    fuelStatusMarker.value = Globals.indexFullFuel;
    isOutOfFuel = false;

    return super.onLoad();
  }
}
