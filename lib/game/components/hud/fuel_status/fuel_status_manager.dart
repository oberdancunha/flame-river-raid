part of 'fuel_status.dart';

abstract interface class _IFuelStatusManager {
  void show();
  void update();
}

final class _FuelStatusManager implements _IFuelStatusManager {
  final FuelStatus fuelStatus;

  _FuelStatusManager(this.fuelStatus);

  late final double _fuelMarkerPosition = fuelStatus.fuelStatusMarker.position.x;
  late final double _fuelStatusEmptyMarkerCenter =
      fuelStatus.fuelStatusEmptyMarker.position.x + (fuelStatus.fuelStatusEmptyMarker.size.x / 2);

  @override
  void show() {
    fuelStatus
      ..add(fuelStatus.fuelStatusMarker)
      ..add(fuelStatus.fuelStatusEmptyMarker);
  }

  @override
  void update() {
    final fuelAmount = RiverRaidGamePlay.fuelStatusMarker.value / 100;
    final markerPosition = _fuelMarkerPosition * fuelAmount;
    fuelStatus
      ..remove(fuelStatus.fuelStatusMarker)
      ..fuelStatusMarker = FuelStatusMarker(
        position: Vector2(markerPosition, fuelStatus.fuelStatusMarker.position.y),
        size: fuelStatus.fuelStatusMarker.size,
      )
      ..add(fuelStatus.fuelStatusMarker);
    final fuelStatusMarkerCenter =
        fuelStatus.fuelStatusMarker.position.x + (fuelStatus.fuelStatusMarker.size.x / 2);
    if (fuelStatusMarkerCenter <= _fuelStatusEmptyMarkerCenter) {
      RiverRaidGamePlay.isOutOfFuel = true;
    }
  }
}
