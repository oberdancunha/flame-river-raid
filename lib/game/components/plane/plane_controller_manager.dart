import 'dart:ui';

import 'package:flame/components.dart';

import '../../../injector.dart';
import '../../constants/globals.dart';
import '../bullet/bullet.dart';
import 'plane.dart';
import 'plane_manager.dart';

abstract interface class _IPlaneControllerManager {
  void moveUp(double dt);
  void moveLeft(double dt);
  void moveRight(double dt);
  void detectMovementDirection(double dt);
  void shootBullets();
  void speedUp();
  void speedDown();
}

final class _PlaneControllerManager implements _IPlaneControllerManager {
  final PlaneComponent plane;

  _PlaneControllerManager(this.plane);

  final Vector2 _moveDirection = Vector2(0, 1);
  double _speed = 0.0;

  @override
  void moveUp(double dt) {
    _moveDirection.y = -1;
    _makeMovement(dt);
  }

  @override
  void moveLeft(double dt) {
    _moveDirection.x = -1;
    _makeMovement(dt);
  }

  @override
  void moveRight(double dt) {
    _moveDirection.x = 1;
    _makeMovement(dt);
  }

  void _makeMovement(double dt) {
    _moveDirection.normalize();
    _speed = lerpDouble(_speed, Globals.defaultSpeed, Globals.acceleration * dt)!;
    plane.position.addScaled(_moveDirection, _speed * dt);
  }

  @override
  void detectMovementDirection(double dt) {
    switch (plane.joystick.direction) {
      case JoystickDirection.left || JoystickDirection.upLeft || JoystickDirection.downLeft:
        plane.planeManager.planeLeft();
        moveLeft(dt);
        if (plane.joystick.direction == JoystickDirection.upLeft) {
          speedUp();
          break;
        }
        if (plane.joystick.direction == JoystickDirection.downLeft) {
          speedDown();
          break;
        }
        break;
      case JoystickDirection.right || JoystickDirection.upRight || JoystickDirection.downRight:
        plane.planeManager.planeRight();
        moveRight(dt);
        if (plane.joystick.direction == JoystickDirection.upRight) {
          speedUp();
          break;
        }
        if (plane.joystick.direction == JoystickDirection.downRight) {
          speedDown();
          break;
        }
        break;
      case JoystickDirection.up:
        speedUp();
        break;
      case JoystickDirection.down:
        speedDown();
        break;
      default:
        plane.planeManager.planeStraight();
    }
  }

  @override
  void shootBullets() {
    plane.game.world.add(
      Bullet(
        position: plane.center,
      ),
    );
  }

  @override
  void speedUp() {
    if (_speed < Globals.maximumSpeedPlane) {
      _speed += Globals.speedUpDown;
    }
  }

  @override
  void speedDown() {
    if (_speed > Globals.minimumSpeedPlane) {
      _speed -= Globals.speedUpDown;
    }
  }
}

extension PlaneControllerExtension on PlaneComponent {
  _IPlaneControllerManager get planeControllerManager =>
      Injector.getOrAdd<_IPlaneControllerManager>(_PlaneControllerManager(this));
}
