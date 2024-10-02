part of 'hud_tiled.dart';

abstract interface class _IHudTiledManager {
  void showScore();
  void showFuelStatusBar();
  void showFuelStatus();
  FuelStatusMarker? getFuelStatusMarker();
  FuelStatusEmptyMarker? getFuelStatusEmptyMarker();
  void showLife();
}

@immutable
final class _HudTiledManager implements _IHudTiledManager {
  final HudTiled hudTiled;

  const _HudTiledManager(this.hudTiled);

  @override
  void showScore() {
    final scoreLayer = RiverRaidComponent.getLayer(hudTiled.tileMap, 'Score');
    if (scoreLayer.isNotEmpty) {
      final scoreObject = scoreLayer.elementAt(0);
      final score = Score(
        position: scoreObject.position,
        size: scoreObject.size,
      );
      hudTiled.add(score);
    }
  }

  @override
  void showFuelStatusBar() {
    final fuelStatusBarLayer = RiverRaidComponent.getLayer(hudTiled.tileMap, 'FuelStatusBar');
    if (fuelStatusBarLayer.isNotEmpty) {
      final fuelStatusBarObject = fuelStatusBarLayer.elementAt(0);
      final fuelStatusBar = FuelStatusBar(
        position: fuelStatusBarObject.position,
        size: fuelStatusBarObject.size,
      );
      hudTiled.add(fuelStatusBar);
    }
  }

  @override
  void showFuelStatus() {
    final fuelStatusMarker = getFuelStatusMarker();
    final fuelStatusEmptyMarker = getFuelStatusEmptyMarker();
    if (fuelStatusMarker != null && fuelStatusEmptyMarker != null) {
      hudTiled.add(FuelStatus(
        fuelStatusMarker: fuelStatusMarker,
        fuelStatusEmptyMarker: fuelStatusEmptyMarker,
        hudTiled: hudTiled,
      ));
    }
  }

  @override
  FuelStatusMarker? getFuelStatusMarker() {
    final fuelStatusMarkerLayer =
        RiverRaidComponent.getLayer(hudTiled.tileMap, 'FuelStatusFullMarker');
    if (fuelStatusMarkerLayer.isNotEmpty) {
      final fuelStatusMarkerObject = fuelStatusMarkerLayer.elementAt(0);
      final fuelStatusMarker = FuelStatusMarker(
        position: Vector2(
          fuelStatusMarkerObject.position.x + 1.5,
          fuelStatusMarkerObject.position.y,
        ),
        size: fuelStatusMarkerObject.size,
      );

      return fuelStatusMarker;
    }

    return null;
  }

  @override
  FuelStatusEmptyMarker? getFuelStatusEmptyMarker() {
    final fuelStatusEmptyMarkerLayer =
        RiverRaidComponent.getLayer(hudTiled.tileMap, 'FuelStatusEmptyMarker');
    if (fuelStatusEmptyMarkerLayer.isNotEmpty) {
      final fuelStatusEmptyMarkerObject = fuelStatusEmptyMarkerLayer.elementAt(0);
      final fuelStatusEmptyMarker = FuelStatusEmptyMarker(
        position: fuelStatusEmptyMarkerObject.position,
        size: fuelStatusEmptyMarkerObject.size,
      );

      return fuelStatusEmptyMarker;
    }

    return null;
  }

  @override
  void showLife() {
    final lifeLayer = RiverRaidComponent.getLayer(hudTiled.tileMap, 'Life');
    if (lifeLayer.isNotEmpty) {
      final lifeObject = lifeLayer.elementAt(0);
      final life = Life(
        position: lifeObject.position,
        size: lifeObject.size,
      );
      hudTiled.add(life);
    }
  }
}
