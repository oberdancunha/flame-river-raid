part of 'plane.dart';

abstract interface class _IPlaneManager {
  void planeStraight();
  void waitToStartFlight();
  void makeAreaCollideable();
  void planeLeft();
  void planeRight();
  void planeExplosion();
  void reduceFuel(double dt);
  bool isOutOfFuel();
  void fuelPlane();
  set deltaTime(dt);
  set planeState(PlaneState state);
  PlaneState get planeState;
}

final class _PlaneManager implements _IPlaneManager {
  final PlaneComponent plane;

  _PlaneManager(this.plane);

  PlaneState _planeState = PlaneState.idle;
  late double _deltaTime;

  @override
  void waitToStartFlight() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _planeState = PlaneState.isAlive;
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
  void reduceFuel(double dt) =>
      RiverRaidGamePlay.fuelMarker.value -= dt * Globals.fuelMarkerModificationIndex;

  @override
  bool isOutOfFuel() => RiverRaidGamePlay.fuelMarker.value <= Globals.indexIsOutOfFuel;

  @override
  void fuelPlane() {
    if (RiverRaidGamePlay.fuelMarker.value < Globals.indexFullFuel) {
      RiverRaidGamePlay.fuelMarker.value +=
          _deltaTime * (pow(Globals.fuelMarkerModificationIndex, 6));
    }
  }

  @override
  set deltaTime(dt) => _deltaTime = dt;

  @override
  set planeState(PlaneState state) => _planeState = state;

  @override
  PlaneState get planeState => _planeState;
}
