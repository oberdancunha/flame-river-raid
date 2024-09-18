import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../components/bridge/bridge.dart';
import '../components/plane/plane.dart';
import '../components/stage/stage.dart';
import '../constants/globals.dart';
import '../river_raid_game.dart';
import '../world/river_raid_world.dart';

final class RiverRaidGamePlay extends Component with HasGameRef<RiverRaidGame> {
  RiverRaidGamePlay({
    super.key,
  });

  static RiverRaidGamePlay instance = RiverRaidGamePlay();

  static const id = 'Gameplay';

  late RiverRaidWorld riverRaidWorld;
  static late PlaneComponent plane;

  static late Stage stage;
  static final stagesPositionInWorld = <double>[];

  static late Bridge lastBridge;
  static ValueNotifier<bool> isBridgeExploding = ValueNotifier<bool>(false);

  static ValueNotifier<double> fuelMarker = ValueNotifier<double>(Globals.indexFullFuel);

  late final resetTimer = Timer(
    1,
    autoStart: false,
    repeat: false,
  );

  @override
  FutureOr<void> onLoad() async {
    riverRaidWorld = RiverRaidWorld();
    add(riverRaidWorld);
    game.world = riverRaidWorld;
    fuelMarker.value = Globals.indexFullFuel;

    return super.onLoad();
  }
}

mixin HasGamePlayRef on Component {
  RiverRaidGamePlay get gamePlay => RiverRaidGamePlay.instance;
}
