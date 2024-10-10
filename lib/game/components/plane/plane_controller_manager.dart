part of 'plane.dart';

abstract interface class _IPlaneControllerManager {
  void moveUp(double dt);
  void moveStraight(double dt);
  void moveLeft(double dt);
  void moveRight(double dt);
  void detectMovementDirection(double dt);
  void shootBullets();
  void speedUp();
  void speedDown();
  set speed(double speed);
  set maxSpeed(double maxSpeed);
  void paradeTheVictory(double dt);
  PlaneSpeedEnum get planeSpeedType;
  set planeSpeedType(PlaneSpeedEnum planeSpeedType);
  ValueNotifier get planeSpeedTypeNotifier;
}

final class _PlaneControllerManager implements _IPlaneControllerManager {
  final PlaneComponent plane;

  _PlaneControllerManager(this.plane);

  final Vector2 _moveDirection = Vector2(0, 1);
  double _speed = 0.0;
  double _maxSpeed = Globals.defaultMaxSpeed;
  final ValueNotifier<PlaneSpeedEnum> _planeSpeedType = ValueNotifier(PlaneSpeedEnum.normal);

  @override
  void moveUp(double dt) {
    _moveDirection.y = -1;
    _makeMovement(dt);
  }

  @override
  void moveStraight(double dt) {
    _moveDirection.x = 0;
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
    _speed = lerpDouble(_speed, _maxSpeed, Globals.acceleration * dt)!;
    plane.position.addScaled(_moveDirection, _speed * dt);
  }

  @override
  void detectMovementDirection(double dt) {
    switch (plane.joystick.direction) {
      case JoystickDirection.left || JoystickDirection.upLeft || JoystickDirection.downLeft:
        plane.planeManager.planeLeft();
        moveLeft(dt);
        planeSpeedType = PlaneSpeedEnum.normal;
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
        planeSpeedType = PlaneSpeedEnum.normal;
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
        moveStraight(dt);
        break;
      case JoystickDirection.down:
        speedDown();
        moveStraight(dt);
        break;
      default:
        plane.planeManager.planeStraight();
        moveStraight(dt);
        planeSpeedType = PlaneSpeedEnum.normal;
    }
  }

  @override
  void shootBullets() {
    plane.game.world.add(
      Bullet(
        position: plane.center,
      ),
    );
    RiverRaidGamePlay.audioManager.shootBullet();
  }

  @override
  void speedUp() {
    if (_speed < Globals.maximumSpeedPlane) {
      _speed += Globals.speedUpDown;
    }
    planeSpeedType = PlaneSpeedEnum.fast;
  }

  @override
  void speedDown() {
    if (_speed > Globals.minimumSpeedPlane) {
      _speed -= Globals.speedUpDown;
    }
    planeSpeedType = PlaneSpeedEnum.slow;
  }

  @override
  set speed(double speed) => _speed = speed;

  @override
  set maxSpeed(double maxSpeed) => _maxSpeed = maxSpeed;

  @override
  void paradeTheVictory(dt) {
    if (plane.position.x > Globals.maxPlaneRightPositionToCenterAdjust) {
      plane.planeManager.planeLeft();
      moveLeft(dt);
    } else if (plane.position.x < Globals.minPlaneLeftPositionToCenterAdjust) {
      plane.planeManager.planeRight();
      moveRight(dt);
    } else {
      plane.planeManager.planeStraight();
      moveStraight(dt);
    }
  }

  @override
  PlaneSpeedEnum get planeSpeedType => _planeSpeedType.value;

  @override
  set planeSpeedType(PlaneSpeedEnum planeSpeedType) => _planeSpeedType.value = planeSpeedType;

  @override
  ValueNotifier get planeSpeedTypeNotifier => _planeSpeedType;
}
