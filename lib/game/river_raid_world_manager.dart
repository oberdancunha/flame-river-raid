import 'dart:async';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';

import 'components/plane/plane.dart';
import 'components/river_raid_component.dart';
import 'components/stage/stage.dart';
import 'river_raid_world.dart';

abstract interface class _IRiverRaidWorldManager {
  Future<Stage> showStage(
    String stageName, {
    Vector2? position,
    Anchor? anchor,
  });
  PlaneComponent showPlane(RenderableTiledMap tileMap);
  void removeStage();
}

@immutable
final class _RiverRaidWorldManager implements _IRiverRaidWorldManager {
  final RiverRaidWorld world;

  const _RiverRaidWorldManager(this.world);

  @override
  Future<Stage> showStage(
    String stageName, {
    Vector2? position,
    Anchor? anchor,
  }) async {
    final prefixStageName = stageName.split('.').elementAt(0);
    final tiledStage = await TiledComponent.load(
      stageName,
      Vector2.all(15),
      prefix: 'assets/tiles/$prefixStageName/',
      images: Images(
        prefix: 'assets/images/tiles/',
      ),
    );
    final stage = Stage(
      tiledStage.tileMap,
      position: position,
      anchor: anchor,
    );
    world.add(stage);
    world.game.stagesPositionInWord.add(stage.position.y);

    return stage;
  }

  @override
  PlaneComponent showPlane(RenderableTiledMap tileMap) {
    final planeLayer = RiverRaidComponent.getLayer(tileMap, 'Plane');
    final planeObject = planeLayer.elementAt(0);
    final plane = PlaneComponent(
      joystick: world.game.joystick,
      position: Vector2(planeObject.x, planeObject.y),
      size: Vector2(planeObject.width, planeObject.height),
      anchor: Anchor.center,
      priority: 1,
    );
    world.add(plane);

    return plane;
  }

  @override
  void removeStage() {
    world.removeWhere((component) {
      if (component is Stage) {
        return component.position.y == world.game.stagesPositionInWord.elementAt(0);
      }

      return false;
    });
    world.game.stagesPositionInWord.removeAt(0);
  }
}

extension RiverRaidGameExtension on RiverRaidWorld {
  _IRiverRaidWorldManager get riverRaidWorldManager => _RiverRaidWorldManager(this);
}
