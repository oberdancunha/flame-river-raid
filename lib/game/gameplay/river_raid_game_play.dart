import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../components/bridge/bridge.dart';
import '../components/plane/plane.dart';
import '../components/stage/stage.dart';
import '../constants/globals.dart';
import '../river_raid_game.dart';
import '../world/river_raid_world.dart';

part 'river_raid_game_play_reset_timer_manager.dart';

final class RiverRaidGamePlay extends Component with HasGameRef<RiverRaidGame> {
  RiverRaidGamePlay({
    super.key,
  });

  static const id = 'Gameplay';

  late _IRiverRaidGamePlayResetTimerManager resetTimerManager;

  late RiverRaidWorld riverRaidWorld;
  static late PlaneComponent plane;

  late Stage stage;
  final stagesPositionInWorld = <double>[];

  late Bridge lastBridge;
  ValueNotifier<bool> isBridgeExploding = ValueNotifier<bool>(false);

  static ValueNotifier<double> fuelMarker = ValueNotifier<double>(Globals.indexFullFuel);

  @override
  FutureOr<void> onLoad() async {
    resetTimerManager = _RiverRaidGamePlayResetTimerManager();
    riverRaidWorld = RiverRaidWorld();
    add(riverRaidWorld);
    game.world = riverRaidWorld;
    fuelMarker.value = Globals.indexFullFuel;

    return super.onLoad();
  }
}

mixin HasGamePlayRef<T extends RiverRaidGamePlay> on Component {
  T? _gamePlay;

  T get gamePlay => _gamePlay ??= _findWorldAndCheck();

  @visibleForTesting
  set gamePlay(T? value) => _gamePlay = value;

  T? findGamePlayRef() =>
      ancestors(includeSelf: true).firstWhereOrNull((ancestor) => ancestor is T) as T?;

  T _findWorldAndCheck() {
    final gamePlay = findGamePlayRef();
    assert(
      gamePlay != null,
      'Could not find a GamePlay instance of type $T',
    );

    return gamePlay!;
  }
}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }

    return null;
  }
}
