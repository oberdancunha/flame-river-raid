import 'dart:async';

import 'package:flame/components.dart';

import '../../gameplay/river_raid_game_play.dart';
import '../border/border.dart';
import '../stage/stage_position_component/stage_position_component.dart';
import 'bridge_manager.dart';

final class Bridge extends StagePositionComponent {
  Bridge({
    required super.position,
    required super.size,
    required super.stage,
  }) : super(
          priority: 1,
        );

  @override
  int get score => 500;

  @override
  FutureOr<void> onLoad() {
    bridgeManager
      ..show()
      ..makeAreaCollideable();

    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is! BorderComponent) {
      super.onCollisionStart(intersectionPoints, other);
      bridgeManager.explode();
      RiverRaidGamePlay.isBridgeExploding.value = true;
    }
  }
}
