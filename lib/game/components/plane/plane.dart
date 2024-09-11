import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../river_raid_game.dart';
import '../../river_raid_game_manager.dart';
import '../fuel/fuel.dart';
import '../hud/joystick/joystick.dart';
import '../stage/stage.dart';
import 'plane_controller_manager.dart';
import 'plane_manager.dart';
import 'plane_stage_manager.dart';
import 'plane_state.dart';

final class PlaneComponent extends SpriteComponent
    with HasGameReference<RiverRaidGame>, CollisionCallbacks {
  final Joystick joystick;

  PlaneComponent({
    required super.position,
    required super.size,
    required super.priority,
    required super.anchor,
    required this.joystick,
  });

  final moveDirection = Vector2(0, 1);
  late double speed = 0.0;
  late double deltaTime;

  PlaneState planeState = PlaneState.idle;

  late Stage currentStage;
  double currentStagePosition = 0.0;
  int nextStageLevelToShow = 1;
  int crossedBridges = 0;
  bool isCheckNextStage = true;

  @override
  FutureOr<void> onLoad() {
    planeManager
      ..planeStraight()
      ..waitToStartFlight()
      ..makeAreaCollideable();
    currentStage = game.stage;

    return super.onLoad();
  }

  @override
  void update(double dt) async {
    super.update(dt);
    deltaTime = dt;
    if (planeState == PlaneState.isAlive) {
      planeControllerManager
        ..moveUp(dt)
        ..detectMovementDirection(dt);
    }
    if (planeState == PlaneState.isDead) {
      planeManager.planeExplosion();
      game.paused = true;
    }
    if (planeStageManager.isTimeToLoadTheNextStage() &&
        planeStageManager.lastBrokenBridgeBelongsToNewStage()) {
      if (planeStageManager.isThereNewStageToLoad()) {
        nextStageLevelToShow++;
        unawaited(planeStageManager.loadNewStage());
      } else {
        game.camera.stop();
        isCheckNextStage = false;
      }
    }
    if (planeStageManager.crossedTheBridge()) {
      planeStageManager.removePastStage();
      if (planeStageManager.isLastBridgeBroken()) {
        game.riverRaidGameManager.finish();
      }
    }
    planeManager.reduceFuel(dt);
    if (planeManager.isOutOfFuel()) {
      planeState = PlaneState.isDead;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Fuel) {
      planeManager.fuelPlane();

      return;
    }
    planeState = PlaneState.isDead;
  }
}
