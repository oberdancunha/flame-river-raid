import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../../injector.dart';
import '../../gameplay/river_raid_game_play.dart';
import '../../gameplay/river_raid_game_play_reset_timer_manager.dart';
import '../../river_raid_game.dart';
import '../../river_raid_game_manager.dart';
import '../../router/river_raid_router.dart';
import '../../world/river_raid_world.dart';
import '../../world/river_raid_world_manager.dart';
import '../fuel/fuel.dart';
import '../hud/joystick/joystick.dart';
import 'plane_controller_manager.dart';
import 'plane_manager.dart';
import 'plane_stage_manager.dart';
import 'plane_state.dart';

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

  @override
  FutureOr<void> onLoad() {
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
      if (RiverRaidGamePlay.isBridgeExploding.value == false) {
        if (!gamePlay.resetTimerManager.isTimerToResetGameRunning()) {
          gamePlay.resetTimerManager.startTimerToResetGame();
          gamePlay.resetTimerManager.executeActionsAfterTick(() async {
            game.riverRaidGameManager.resetNextStageToShow();
            (game.world as RiverRaidWorld).riverRaidWorldManager.removeAllStages();
            game.riverRaidGameManager.decreaseLife();
            if (game.riverRaidGameManager.showLifeValue < 0) {
              game.riverRaidGameManager.startGame();
            }
            await Injector.clean();
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
