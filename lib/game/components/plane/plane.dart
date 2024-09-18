import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../constants/assets.dart';
import '../../constants/globals.dart';
import '../../gameplay/river_raid_game_play.dart';
import '../../river_raid_game.dart';
import '../../router/river_raid_router.dart';
import '../../world/river_raid_world.dart';
import '../bullet/bullet.dart';
import '../fuel/fuel.dart';
import '../hud/joystick/joystick.dart';
import '../stage/stage.dart';
import 'plane_state.dart';

part 'plane_controller_manager.dart';
part 'plane_manager.dart';
part 'plane_stage_manager.dart';

final class PlaneComponent extends SpriteComponent
    with HasGameReference<RiverRaidGame>, HasGamePlayRef, CollisionCallbacks {
  final Joystick joystick;

  PlaneComponent({
    required super.position,
    required super.size,
    required super.priority,
    required super.anchor,
    required this.joystick,
  });

  late _IPlaneManager planeManager;
  late _IPlaneControllerManager planeControllerManager;
  late _IPlaneStageManager planeStageManager;

  @override
  FutureOr<void> onLoad() {
    planeManager = _PlaneManager(this);
    planeControllerManager = _PlaneControllerManager(this);
    planeStageManager = _PlaneStageManger(this);
    planeManager
      ..planeStraight()
      ..waitToStartFlight()
      ..makeAreaCollideable();

    return super.onLoad();
  }

  @override
  void update(double dt) async {
    if (planeManager.planeState == PlaneState.isAlive) {
      super.update(dt);
      planeManager.deltaTime = dt;
      planeControllerManager
        ..moveUp(dt)
        ..detectMovementDirection(dt);
      planeManager.reduceFuel(dt);
      if (planeManager.isOutOfFuel()) {
        planeManager.planeState = PlaneState.isDead;
      }
      if (planeStageManager.isTimeToLoadTheNextStage() &&
          planeStageManager.lastBrokenBridgeBelongsToNewStage()) {
        if (planeStageManager.isThereNewStageToLoad()) {
          game.riverRaidGameManager.addNextStageToShow();
          unawaited(planeStageManager.loadNewStage());
        } else {
          game.camera.stop();
          planeStageManager.isCheckNextStage = false;
        }
      }
      if (planeStageManager.crossedTheBridge()) {
        planeStageManager.removePastStage();
        if (planeStageManager.isLastBridgeBroken()) {
          game.riverRaidGameManager.finish();
        }
      }
    }
    if (planeManager.planeState == PlaneState.isDead) {
      planeManager.planeExplosion();
      if (gamePlay.isBridgeExploding.value == false) {
        if (!gamePlay.resetTimerManager.isTimerToResetGameRunning()) {
          gamePlay.resetTimerManager.startTimerToResetGame();
          gamePlay.resetTimerManager.executeActionsAfterTick(() async {
            game.riverRaidGameManager.resetNextStageToShow();
            (game.world as RiverRaidWorld).riverRaidWorldManager.removeAllStages();
            game.riverRaidGameManager.decreaseLife();
            if (game.riverRaidGameManager.showLifeValue < 0) {
              game.riverRaidGameManager.startGame();
            }
            game.riverRaidRouter
                .pushReplacement(RiverRaidRouter.startGame, name: RiverRaidGamePlay.id);
          });
        } else {
          gamePlay.resetTimerManager.runtimeCount(dt);
          if (gamePlay.resetTimerManager.isTimerToResetGameFinished()) {
            gamePlay.resetTimerManager.stopTimerToResetGame();
          }
        }
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Fuel) {
      planeManager.fuelPlane();

      return;
    }
    planeManager.planeState = PlaneState.isDead;
  }
}
