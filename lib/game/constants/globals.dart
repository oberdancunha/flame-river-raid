import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

@immutable
final class Globals {
  const Globals._();

  static Vector2 gameSize = Vector2(300, 230);

  // Assets path
  static String assetsTiles = 'assets/tiles';
  static String assetsImages = 'assets/images/tiles/';

  // Hud
  static const totalLife = 3;
  static const initialScore = 0;
  static const indexFullFuel = 100.0;
  static const fuelMarkerModificationIndex = 1.5;

  // Explosion time (enemy, bridge and fuel)
  static const explosionTime = 0.25;

  // Minimal plane distance to enemy movement
  static const minimumDistanceFromEnemyToPlane = 110.0;

  // Plane movement
  static const acceleration = 0.5;
  static const defaultMaxSpeed = 50.0;
  static const maximumSpeedPlane = 80.0;
  static const minimumSpeedPlane = 20;
  static const speedUpDown = 3.0;
  static const finishSpeed = 25.0;

  // Finish plane position
  static const maxPlaneRightPositionToCenterAdjust = 143.0;
  static const minPlaneLeftPositionToCenterAdjust = 133.0;

  // Finish stages
  static const finishStageBottomFileName = 'stage_finish_bottom.tmx';
  static const finishStageTopFileName = 'stage_finish_top.tmx';

  static const hudContentColor = Color(0xFFE8E84A);

  static const adjustVerticalPositionBridgeOnRestart = 30;
}
