import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../constants/assets.dart';
import '../../constants/globals.dart';
import '../../extensions/size_extension.dart';
import '../../gameplay/river_raid_game_play.dart';
import '../../gameplay/river_raid_game_play_mixin.dart';
import '../../river_raid_game.dart';
import '../../river_raid_game_state.dart';
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
      planeControllerManager.moveUp(dt);
      if (game.riverRaidGameManager.gameState == RiverRaidGameState.run) {
        planeControllerManager.detectMovementDirection(dt);
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
            unawaited(planeStageManager.loadFinishStageBottom());
            planeStageManager.isCheckNextStage = false;
          }
        }
        if (planeStageManager.crossedTheBridge()) {
          Future.delayed(const Duration(seconds: 2), () {
            planeStageManager.removePastStage();
          });
          if (planeStageManager.isLastBridgeBroken()) {
            game.camera.stop();
            unawaited(planeStageManager.loadFinishStageTop());
            game.riverRaidGameManager.gameState = RiverRaidGameState.win;
            gamePlay.gamePlayManager.isExplodeFireworks = true;
            planeControllerManager
              ..speed = Globals.finishSpeed
              ..maxSpeed = Globals.finishSpeed;
          }
        }
      } else {
        if (game.riverRaidGameManager.gameState == RiverRaidGameState.win) {
          game.riverRaidGameManager.removeHudView(dt);
          planeControllerManager.paradeTheVictory(dt);
          if (!game.camera.canSee(this)) {
            game.riverRaidGameManager.finish();
          }
        }
      }
    } else {
      if (planeManager.planeState == PlaneState.isDead) {
        planeManager.planeExplosion();
        if (gamePlay.gamePlayManager.isBridgeExploding == false) {
          planeManager.runTimerToResetGame(dt);
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
