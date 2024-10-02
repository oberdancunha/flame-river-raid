import 'package:flame/components.dart';

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
  double get fuelStatusBarHorizontalPosition =>
      joystickSizeMargin + (sizeBetweenJoystickAndButton / 2);
  double get heightPositionOfTheRespectiveStage => y - 3.8;
}
