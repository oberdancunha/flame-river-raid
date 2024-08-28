import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../river_raid_game.dart';
import '../../river_raid_game_manager.dart';
import '../fuel/fuel.dart';
import '../joystick/joystick.dart';
import '../stage/stage.dart';
import 'plane_controller_manager.dart';
import 'plane_manager.dart';
import 'plane_stage_manager.dart';
import 'plane_state.dart';

final class PlaneComponent extends SpriteComponent
    with HasGameReference<RiverRaidGame>, CollisionCallbacks {
  final Joystick joystick;

  PlaneComponent({
    required this.joystick,
    required super.position,
    required super.size,
    required super.priority,
    required super.anchor,
  });

  final moveDirection = Vector2(0, 1);
  late double speed = 0.0;
  PlaneState planeState = PlaneState.idle;
  late Stage currentStage;
  double maximumHeightPosition = 0.0;
  double currentStagePosition = 0.0;
  int nextStageLevelToShow = 1;
  int crossedBridges = 0;
  bool continueCheckingNewStage = true;

  @override
  FutureOr<void> onLoad() {
    planeManager
      ..planeStraight()
      ..makeAreaCollideable();
    Future.delayed(const Duration(milliseconds: 300), () {
      planeState = PlaneState.isAlive;
    });
    currentStage = game.stage;
    maximumHeightPosition = currentStage.size.y;

    return super.onLoad();
  }

  @override
  void update(double dt) async {
    super.update(dt);
    if (planeState == PlaneState.isAlive) {
      planeControllerManager
        ..moveUp(dt)
        ..detectMovementDirection(dt);
    }
    if (planeState == PlaneState.isDead) {
      planeManager.planeExplosion();
    }
    if (planeStageManager.isTimeToLoadTheNextStage() &&
        planeStageManager.lastBrokenBridgeBelongsToNewStage()) {
      if (planeStageManager.isThereNewStageToLoad()) {
        nextStageLevelToShow++;
        await planeStageManager.loadNewStage();
        planeStageManager.updateMaximumHeightPosition(currentStage.size.y);
      }
      if (planeStageManager.isNotThereNewStageToBeShown()) {
        game.camera.stop();
        continueCheckingNewStage = false;
      }
    }
    if (planeStageManager.crossedTheBridge()) {
      planeStageManager.removePastStage();
      if (planeStageManager.isLastBridgeBroken()) {
        game.riverRaidGameManager.finish();
      }
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Fuel) {
      return;
    }
    planeState = PlaneState.isDead;
  }
}
