import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

@immutable
final class Globals {
  const Globals._();

  static Vector2 gameSize = Vector2(300, 230);

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

extension SizeExtension on Vector2 {
  Vector2 get hudSize => Vector2(x, y / 8);
  double get joystickSize => hudSize.y * 0.9;
  double get joystickHorizontalMargin => hudSize.x * 0.025;
  double get joystickVerticalMargin => hudSize.y * 0.175;
  Vector2 get joystickButtonSize => Vector2.all(joystickSize * 0.7);
  double get joystickSizeMargin => joystickSize + joystickHorizontalMargin;
  double get joystickButtonSizeMargin => joystickButtonSize.x + joystickHorizontalMargin;
  double get sizeBetweenJoystickAndButton =>
      hudSize.x - joystickSizeMargin - joystickButtonSizeMargin;
  Vector2 get fuelStatusBarSize => Vector2(sizeBetweenJoystickAndButton * 0.6, hudSize.y / 2.5);
  double get fuelStatusBarHorizontalPosition => joystickSizeMargin + (fuelStatusBarSize.x / 3);
  double get fuelStatusBarVerticalPosition => hudSize.y / 3.6;
  Vector2 get fullFuelMarkerSize => Vector2(fuelStatusBarSize.x * 0.051, fuelStatusBarSize.y * 0.7);
  double get scoreFontSize => hudSize.y * 0.25;
  double get heightPositionOfTheRespectiveStage => y - 3.8;
  double get fuelMarkerHorizontalPosition =>
      (fuelStatusBarHorizontalPosition - (fuelStatusBarSize.x / 13));
  double get fuelMarkerVerticalPosition => hudSize.y / 8.5;
}
