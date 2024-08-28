import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';

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
}
