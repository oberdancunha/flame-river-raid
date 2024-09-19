part of 'river_raid_world.dart';

abstract interface class _IRiverRaidWorldManager {
  Future<Stage> showStage(
    String stageName, {
    double? tileSize,
    Vector2? position,
    Anchor? anchor,
  });
  PlaneComponent showPlane(RenderableTiledMap tileMap);
  void removeStage(int stageIndex);
  void removeAllStages();
}

@immutable
final class _RiverRaidWorldManager implements _IRiverRaidWorldManager {
  final RiverRaidWorld world;

  const _RiverRaidWorldManager(this.world);

  @override
  Future<Stage> showStage(
    String stageName, {
    double? tileSize = 15,
    Vector2? position,
    Anchor? anchor,
  }) async {
    final prefixStageName = stageName.split('.').elementAt(0);
    final tiledStage = await TiledComponent.load(
      stageName,
      Vector2.all(tileSize!),
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
    world.gamePlay.gamePlayManager.addStagePositionInWorld(stage.position.y);

    return stage;
  }

  @override
  PlaneComponent showPlane(RenderableTiledMap tileMap) {
    final planeLayer = RiverRaidComponent.getLayer(tileMap, 'Plane');
    final planeObject = planeLayer.elementAt(0);
    final plane = PlaneComponent(
      joystick: world.game.riverRaidGameManager.joystick,
      position: Vector2(planeObject.x, planeObject.y),
      size: Vector2(planeObject.width, planeObject.height),
      anchor: Anchor.bottomLeft,
      priority: 1,
    );
    world.add(plane);

    return plane;
  }

  @override
  void removeStage(int stageIndex) {
    world.removeWhere((component) {
      if (component is Stage) {
        return world.gamePlay.gamePlayManager.stagesPositionInWorld.length > stageIndex &&
            component.position.y ==
                world.gamePlay.gamePlayManager.stagesPositionInWorld.elementAt(stageIndex);
      }

      return false;
    });
    if (world.gamePlay.gamePlayManager.stagesPositionInWorld.length > stageIndex) {
      world.gamePlay.gamePlayManager.stagesPositionInWorld.removeAt(stageIndex);
    }
  }

  @override
  void removeAllStages() {
    world.removeWhere((component) {
      if (component is Stage) {
        return true;
      }

      return false;
    });
    world.gamePlay.gamePlayManager.stagesPositionInWorld.clear();
  }
}
