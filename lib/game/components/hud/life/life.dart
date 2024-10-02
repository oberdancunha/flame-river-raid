import 'dart:async';

import 'package:flame/components.dart';

import '../../../river_raid_game.dart';
import '../info.dart';

part 'life_manager.dart';

final class Life extends PositionComponent with HasGameRef<RiverRaidGame> {
  Life({
    required super.position,
    required super.size,
  });

  late _ILifeManager _lifeManager;

  @override
  FutureOr<void> onLoad() {
    _lifeManager = _LifeManager(this);
    _lifeManager.show();
    game.riverRaidGameManager.showLife.addListener(_lifeManager.update);

    return super.onLoad();
  }

  @override
  void onRemove() {
    game.riverRaidGameManager.showLife.removeListener(_lifeManager.update);
    super.onRemove();
  }
}
