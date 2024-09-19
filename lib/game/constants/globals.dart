import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

@immutable
final class Globals {
  const Globals._();

  static Vector2 gameSize = Vector2(300, 230);

  static const totalLife = 3;
  static const initialScore = 0;
  static const explosionTime = 0.25;
  static const minimumDistanceFromEnemyToPlane = 110.0;

  static const acceleration = 0.5;
  static const defaultSpeed = 50.0;
  static const maximumSpeedPlane = 80.0;
  static const minimumSpeedPlane = 20;
  static const speedUpDown = 3.0;

  static const indexFullFuel = 100.0;
  static const fuelMarkerModificationIndex = 1.5;
  static const indexIsOutOfFuel = 8.5;
}
