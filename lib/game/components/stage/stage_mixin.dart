import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../river/river.dart';
import '../river_raid_component.dart';

mixin StageMixin on PositionComponent {
  void showRivers(RenderableTiledMap tileMap) {
    final riversLayer = RiverRaidComponent.getLayer(tileMap, 'Rivers');
    for (final riverObject in riversLayer) {
      final river = River(
        position: riverObject.position,
        size: Vector2(riverObject.size.x, riverObject.size.y + 0.35),
      );
      add(river);
    }
  }
}
