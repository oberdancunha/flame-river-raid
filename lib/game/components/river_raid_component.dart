import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';

import '../constants/globals.dart';

@immutable
final class RiverRaidComponent {
  const RiverRaidComponent._();

  static List<TiledObject> getLayer(RenderableTiledMap tiledMap, String componentName) {
    final layer = tiledMap.getLayer<ObjectGroup>(componentName);

    return layer?.objects ?? [];
  }

  static bool checkPropertyBoolStatus(TiledObject tiledObject, String propertyName) {
    bool status = false;
    final property = tiledObject.properties.byName[propertyName];
    if (property != null && property.value is bool) {
      status = property.value as bool;
    }

    return status;
  }

  static Future<TiledComponent<FlameGame<World>>> readTiledFile(
    String tiledFileName, {
    double? tileSize = 15,
  }) async {
    final prefixTiledFileName = tiledFileName.split('.').elementAt(0);
    final tiledStage = await TiledComponent.load(
      tiledFileName,
      Vector2.all(tileSize!),
      prefix: '${Globals.assetsTiles}/$prefixTiledFileName/',
      images: Images(
        prefix: Globals.assetsImages,
      ),
    );

    return tiledStage;
  }
}
