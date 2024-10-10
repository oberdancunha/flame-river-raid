part of 'fuel_status.dart';

abstract interface class _IFuelStatusManager {
  void showFullFuelMarker();
  void loadEmptyFuelPosition();
  void checkFuel();
  void updateMarkerPosition();
  void checkLowFuel();
  bool isLowFuel(double distanceToEmptyMarker);
  void warnLowFuel();
  bool isAlmostOutOfFuel(double distanceToEmptyMarker);
  void warnAlmostOutOfFuel();
  bool isOutOfFuel();
  void deactivateLowFuelWarn();
}

final class _FuelStatusManager implements _IFuelStatusManager {
  final FuelStatus fuelStatus;

  _FuelStatusManager(this.fuelStatus);

  late final _fuelMarkerPosition = fuelStatus.fuelStatusMarker.position.x;
  late final _fuelStatusEmptyMarkerCenter =
      fuelStatus.fuelStatusEmptyMarker.position.x + (fuelStatus.fuelStatusEmptyMarker.size.x / 2);
  bool _isLowFuelWarnActive = false;

  @override
  void showFullFuelMarker() {
    fuelStatus.add(fuelStatus.fuelStatusMarker);
  }

  @override
  void loadEmptyFuelPosition() {
    fuelStatus.add(fuelStatus.fuelStatusEmptyMarker);
  }

  @override
  void checkFuel() {
    updateMarkerPosition();
    checkLowFuel();
    if (isOutOfFuel()) {
      RiverRaidGamePlay.isOutOfFuel = true;
    }
  }

  @override
  void updateMarkerPosition() {
    final fuelAmount = RiverRaidGamePlay.fuelStatusMarker.value / 100;
    final markerPosition = _fuelMarkerPosition * fuelAmount;
    fuelStatus
      ..remove(fuelStatus.fuelStatusMarker)
      ..fuelStatusMarker = FuelStatusMarker(
        position: Vector2(markerPosition, fuelStatus.fuelStatusMarker.position.y),
        size: fuelStatus.fuelStatusMarker.size,
      )
      ..add(fuelStatus.fuelStatusMarker);
  }

  @override
  void checkLowFuel() {
    final distanceToEmptyMarker =
        fuelStatus.fuelStatusMarker.position.distanceTo(fuelStatus.fuelStatusEmptyMarker.position);
    if (isLowFuel(distanceToEmptyMarker)) {
      warnLowFuel();
    } else {
      if (isAlmostOutOfFuel(distanceToEmptyMarker)) {
        warnAlmostOutOfFuel();

        return;
      }
      if (_isLowFuelWarnActive) {
        deactivateLowFuelWarn();
      }
    }
  }

  @override
  bool isLowFuel(double distanceToEmptyMarker) {
    final isLowFuel = distanceToEmptyMarker <= Globals.lowFuelIndex &&
        distanceToEmptyMarker > Globals.almostOutOfFuelIndex;

    return isLowFuel;
  }

  @override
  void warnLowFuel() {
    _isLowFuelWarnActive = true;
    unawaited(RiverRaidGamePlay.audioManager.playLowFuel());
  }

  @override
  bool isAlmostOutOfFuel(double distanceToEmptyMarker) {
    final isAlmostOutOfFuel = distanceToEmptyMarker <= Globals.almostOutOfFuelIndex;

    return isAlmostOutOfFuel;
  }

  @override
  void warnAlmostOutOfFuel() => unawaited(RiverRaidGamePlay.audioManager.playOutOfFuel());

  @override
  bool isOutOfFuel() {
    final fuelStatusMarkerCenter =
        fuelStatus.fuelStatusMarker.position.x + (fuelStatus.fuelStatusMarker.size.x / 2);
    final isOutOfFuel = fuelStatusMarkerCenter <= _fuelStatusEmptyMarkerCenter;

    return isOutOfFuel;
  }

  @override
  void deactivateLowFuelWarn() {
    _isLowFuelWarnActive = false;
    RiverRaidGamePlay.audioManager.stopLowFuel();
  }
}
