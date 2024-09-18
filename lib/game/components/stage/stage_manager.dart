import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

import '../../constants/assets.dart';
import '../../gameplay/river_raid_game_play.dart';
import '../../sprites/sprites_explosion.dart';
import '../border/border.dart';
import '../bridge/bridge.dart';
import '../enemies/fighter_plane.dart';
import '../enemies/helicopter.dart';
import '../enemies/ship.dart';
import '../fuel/fuel.dart';
import '../river/river.dart';
import '../river_raid_component.dart';
import 'stage.dart';

abstract interface class _IStageManager {
  void showBridge();
  void showBorders();
  void showRivers();
  void showShips();
  void showHelicopters();
  void showFighterPlanes();
  void showFuels();
  double getHeightPositionInGame();
  void explode({required double horizontalPosition, required double verticalPosition});
}

@immutable
final class _StageManager implements _IStageManager {
  final Stage stage;

  const _StageManager(this.stage);

  @override
  void showBridge() {
    final bridgesLayer = RiverRaidComponent.getLayer(stage.tileMap, 'Bridge');
    if (bridgesLayer.isNotEmpty) {
      final bridgeObject = bridgesLayer.elementAt(0);
      final bridge = Bridge(
        position: bridgeObject.position,
        size: bridgeObject.size,
        stage: stage,
      );
      RiverRaidGamePlay.lastBridge = bridge;
      stage.add(bridge);
    }
  }

  @override
  void showBorders() {
    final bordersLayer = RiverRaidComponent.getLayer(stage.tileMap, 'Borders');
    for (final borderObject in bordersLayer) {
      final border = BorderComponent(
        position: borderObject.position,
        size: borderObject.size,
      );
      stage.add(border);
    }
  }

  @override
  void showRivers() {
    final riversLayer = RiverRaidComponent.getLayer(stage.tileMap, 'Rivers');
    for (final riverObject in riversLayer) {
      final river = River(
        position: riverObject.position,
        size: Vector2(riverObject.size.x, riverObject.size.y + 0.35),
      );
      stage.add(river);
    }
  }

  @override
  void showShips() {
    final shipsLayer = RiverRaidComponent.getLayer(stage.tileMap, 'Ships');
    for (final shipObject in shipsLayer) {
      bool isReverse = RiverRaidComponent.checkPropertyBoolStatus(shipObject, 'isReverse');
      bool hasMove = RiverRaidComponent.checkPropertyBoolStatus(shipObject, 'hasMove');
      final ship = Ship(
        isReverse: isReverse,
        hasMove: hasMove,
        position: shipObject.position,
        size: shipObject.size,
        stage: stage,
      );
      stage.add(ship);
    }
  }

  @override
  void showHelicopters() {
    final helicoptersLayer = RiverRaidComponent.getLayer(stage.tileMap, 'Helicopters');
    for (final helicopterObject in helicoptersLayer) {
      bool isReverse = RiverRaidComponent.checkPropertyBoolStatus(helicopterObject, 'isReverse');
      bool hasMove = RiverRaidComponent.checkPropertyBoolStatus(helicopterObject, 'hasMove');
      final helicopter = Helicopter(
        isReverse: isReverse,
        hasMove: hasMove,
        position: helicopterObject.position,
        size: helicopterObject.size,
        stage: stage,
      );
      stage.add(helicopter);
    }
  }

  @override
  void showFighterPlanes() {
    final fighterPlanesLayer = RiverRaidComponent.getLayer(stage.tileMap, 'FighterPlanes');
    for (final fighterPlaneObject in fighterPlanesLayer) {
      bool isReverse = RiverRaidComponent.checkPropertyBoolStatus(fighterPlaneObject, 'isReverse');
      final fighterPlane = FighterPlane(
        isReverse: isReverse,
        position: fighterPlaneObject.position,
        size: fighterPlaneObject.size,
        stage: stage,
      );
      stage.add(fighterPlane);
    }
  }

  @override
  void showFuels() {
    final fuelsLayer = RiverRaidComponent.getLayer(stage.tileMap, 'Fuels');
    for (final fuelObject in fuelsLayer) {
      final fuel = Fuel(
        position: fuelObject.position,
        size: fuelObject.size,
        stage: stage,
      );
      stage.add(fuel);
    }
  }

  @override
  void explode({
    required double horizontalPosition,
    required verticalPosition,
  }) {
    final explosionSequence = [
      Assets.firstExplosion,
      Assets.secondExplosion,
      Assets.firstExplosion
    ];
    final explosion = SpritesExplosion.buildAnimation(
      explosionSequence: explosionSequence,
      horizontalPosition: horizontalPosition,
      verticalPosition: verticalPosition,
    );
    stage.add(explosion);
  }

  @override
  double getHeightPositionInGame() => stage.position.y + (stage.size.y * -1);
}

extension StageManager on Stage {
  _IStageManager get stageManager => _StageManager(this);
}
