part of 'plane.dart';

abstract interface class _IPlaneManager {
  void planeStraight();
  void waitToStartFlight();
  void makeAreaCollideable();
  void planeLeft();
  void planeRight();
  void planeExplosion();
  void reduceFuel(double dt);
  void refuelThePlane();
  set deltaTime(dt);
  set planeState(PlaneState state);
  PlaneState get planeState;
  void runTimerToResetGame(double dt);
  set isThePlaneBeingRefueled(bool isThePlaneBeingRefueled);
  bool get isThePlaneBeingRefueled;
}

final class _PlaneManager implements _IPlaneManager {
  final PlaneComponent plane;

  _PlaneManager(this.plane);

  PlaneState _planeState = PlaneState.idle;
  late double _deltaTime;
  bool _isThePlaneBeingRefueled = false;

  @override
  void waitToStartFlight() {
    Future.delayed(const Duration(milliseconds: 300), () async {
      _planeState = PlaneState.isAlive;
      RiverRaidGamePlay.audioManager.flyStart();
      RiverRaidGamePlay.audioManager.fly(timeToStartInMilliseconds: 1500);
    });
  }

  @override
  void makeAreaCollideable() => plane.add(
        RectangleHitbox(
          collisionType: CollisionType.passive,
        ),
      );

  @override
  void planeStraight() => plane.sprite = Assets.plane;

  @override
  void planeLeft() => plane.sprite = Assets.planeLeft;

  @override
  void planeRight() => plane.sprite = Assets.planeRight;

  @override
  void planeExplosion() => plane.sprite = Assets.planeExplosion;

  @override
  void reduceFuel(double dt) {
    if (_isThePlaneBeingRefueled == false) {
      RiverRaidGamePlay.fuelStatusMarker.value -= dt * Globals.fuelMarkerModificationIndex;
    }
  }

  @override
  void refuelThePlane() {
    if (RiverRaidGamePlay.fuelStatusMarker.value < Globals.fullFuelIndex) {
      RiverRaidGamePlay.fuelStatusMarker.value +=
          _deltaTime * (pow(Globals.fuelMarkerModificationIndex, 6));
    }
  }

  @override
  set deltaTime(dt) => _deltaTime = dt;

  @override
  set planeState(PlaneState state) => _planeState = state;

  @override
  PlaneState get planeState => _planeState;

  @override
  void runTimerToResetGame(double dt) {
    if (!plane.gamePlay.resetTimerManager.isTimerToResetGameRunning()) {
      plane.gamePlay.resetTimerManager.startTimerToResetGame();
      plane.gamePlay.resetTimerManager.executeActionsAfterTick(
        () {
          plane.game.riverRaidGameManager.resetNextStageToShow();
          (plane.game.world as RiverRaidWorld).riverRaidWorldManager.removeAllStages();
          plane.game.riverRaidGameManager.decreaseLife();
          if (plane.game.riverRaidGameManager.showLifeValue < 0) {
            plane.game.riverRaidGameManager.startGame();
          }
          plane.game.riverRaidRouter
              .pushReplacement(RiverRaidRouter.startGame, name: RiverRaidGamePlay.id);
        },
      );
    } else {
      plane.gamePlay.resetTimerManager.runtimeCount(dt);
      if (plane.gamePlay.resetTimerManager.isTimerToResetGameFinished()) {
        plane.gamePlay.resetTimerManager.stopTimerToResetGame();
      }
    }
  }

  @override
  set isThePlaneBeingRefueled(bool isThePlaneBeingRefueled) =>
      _isThePlaneBeingRefueled = isThePlaneBeingRefueled;

  @override
  bool get isThePlaneBeingRefueled => _isThePlaneBeingRefueled;
}
