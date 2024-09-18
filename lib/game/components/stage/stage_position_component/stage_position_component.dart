import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../../river_raid_game.dart';
import '../stage.dart';
import 'stage_position_component_manager.dart';

class StagePositionComponent extends PositionComponent
    with HasGameRef<RiverRaidGame>, CollisionCallbacks {
  final Stage stage;

  StagePositionComponent({
    required super.position,
    required super.size,
    required super.priority,
    required this.stage,
  });

  int score = 0;

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    stagePositionComponentManager
      ..remove()
      ..sumScore();
  }
}
