import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

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

@immutable
final class _PlaneControllerManager implements _IPlaneControllerManager {
  final PlaneComponent plane;

  const _PlaneControllerManager(this.plane);

  @override
  void moveUp(double dt) {
    plane.moveDirection.y = -1;
    _makeMovement(dt);
  }

  @override
  void moveLeft(double dt) {
    plane.moveDirection.x = -1;
    _makeMovement(dt);
  }

  @override
  void moveRight(double dt) {
    plane.moveDirection.x = 1;
    _makeMovement(dt);
  }

  void _makeMovement(double dt) {
    plane.moveDirection.normalize();
    plane.speed = lerpDouble(plane.speed, Globals.defaultSpeed, Globals.acceleration * dt)!;
    plane.position.addScaled(plane.moveDirection, plane.speed * dt);
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
        position: plane.position,
      ),
    );
  }

  @override
  void speedUp() {
    if (plane.speed < Globals.maximumSpeedPlane) {
      plane.speed += Globals.speedUpDown;
    }
  }

  @override
  void speedDown() {
    if (plane.speed > Globals.minimumSpeedPlane) {
      plane.speed -= Globals.speedUpDown;
    }
  }
}

extension PlaneControllerExtension on PlaneComponent {
  _IPlaneControllerManager get planeControllerManager => _PlaneControllerManager(this);
}
