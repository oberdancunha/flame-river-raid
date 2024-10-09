import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../../gameplay/river_raid_game_play_mixin.dart';
import '../../../river_raid_game.dart';
import '../stage.dart';

part 'stage_position_component_manager.dart';

class StagePositionComponent extends PositionComponent
    with HasGameRef<RiverRaidGame>, HasGamePlayRef, CollisionCallbacks {
  final Stage stage;

  StagePositionComponent({
    required super.position,
    required super.size,
    required super.priority,
    required this.stage,
  });

  late _IStagePositionComponentManager stagePositionComponentManager;
  int score = 0;

  @override
  FutureOr<void> onLoad() {
    stagePositionComponentManager = _StagePositionComponentManager(this);

    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    stagePositionComponentManager
      ..remove()
      ..sumScore();
    gamePlay.audioManager.componentCrash();
  }
}
