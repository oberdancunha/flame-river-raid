import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../../constants/assets.dart';
import '../../constants/globals.dart';
import '../../extensions/size_extension.dart';
import '../../gameplay/river_raid_game_play.dart';
import '../../gameplay/river_raid_game_play_mixin.dart';
import '../../river_raid_game.dart';
import '../../river_raid_game_state.dart';
import '../../router/river_raid_router.dart';
import '../../world/river_raid_world.dart';
import '../border/border.dart';
import '../bullet/bullet.dart';
import '../fuel/fuel.dart';
import '../hud/joystick/joystick.dart';
import '../stage/stage.dart';
import 'plane_speed_enum.dart';
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
  late _IPlaneStageManager _planeStageManager;
  bool _haveRemovePastStage = false;

  @override
  FutureOr<void> onLoad() {
    planeManager = _PlaneManager(this);
    planeControllerManager = _PlaneControllerManager(this);
    _planeStageManager = _PlaneStageManger(this);
    planeManager
      ..planeStraight()
      ..waitToStartFlight()
      ..makeAreaCollideable();
    planeControllerManager.planeSpeedTypeNotifier
        .addListener(RiverRaidGamePlay.audioManager.flyVolumeAndSpeed);

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
        if (RiverRaidGamePlay.isOutOfFuel) {
          planeManager.planeState = PlaneState.isDead;
          RiverRaidGamePlay.audioManager.stopAudios();
          RiverRaidGamePlay.audioManager.planeCrash();
        }
        if (_planeStageManager.isTimeToLoadTheNextStage() &&
            _planeStageManager.lastBrokenBridgeBelongsToNewStage()) {
          if (_planeStageManager.isThereNewStageToLoad()) {
            game.riverRaidGameManager.addNextStageToShow();
            unawaited(_planeStageManager.loadNewStage());
          } else {
            unawaited(_planeStageManager.loadFinishStageBottom());
            _planeStageManager.isCheckNextStage = false;
          }
        }
        if (_planeStageManager.crossedTheBridge()) {
          _haveRemovePastStage = true;
          Future.delayed(const Duration(seconds: 2), () {
            if (_haveRemovePastStage) {
              _planeStageManager.removePastStage();
            }
          });
          if (_planeStageManager.isLastBridgeBroken()) {
            game.camera.stop();
            unawaited(_planeStageManager.loadFinishStageTop());
            game.riverRaidGameManager.gameState = RiverRaidGameState.win;
            gamePlay.gamePlayManager.isExplodeFireworks = true;
            planeControllerManager
              ..speed = Globals.finishSpeed
              ..maxSpeed = Globals.finishSpeed
              ..planeSpeedType = PlaneSpeedEnum.slow;
          }
        }
      } else {
        if (game.riverRaidGameManager.gameState == RiverRaidGameState.win) {
          game.riverRaidGameManager.removeHudView(dt);
          planeControllerManager.paradeTheVictory(dt);
          RiverRaidGamePlay.audioManager.stopWarnFuel();
          RiverRaidGamePlay.audioManager.fireworks();
          if (!game.camera.canSee(this)) {
            game.riverRaidGameManager.finish();
            RiverRaidGamePlay.audioManager.stopAudios();
          }
        }
      }
    } else {
      if (planeManager.planeState == PlaneState.isDead) {
        _haveRemovePastStage = false;
        planeManager.planeExplosion();

        if (gamePlay.gamePlayManager.isBridgeExploding == false) {
          planeManager.runTimerToResetGame(dt);
        }
      }
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Fuel) {
      planeManager.isThePlaneBeingRefueled = true;

      return;
    }
    planeManager.planeState = PlaneState.isDead;
    RiverRaidGamePlay.audioManager.stopAudios();
    if (other is BorderComponent) {
      RiverRaidGamePlay.audioManager.planeCrash();

      return;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Fuel) {
      planeManager.refuelThePlane();

      return;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Fuel) {
      planeManager.isThePlaneBeingRefueled = false;
    }
  }

  @override
  void onRemove() {
    planeControllerManager.planeSpeedTypeNotifier
        .removeListener(RiverRaidGamePlay.audioManager.flyVolumeAndSpeed);
    super.onRemove();
  }
}
