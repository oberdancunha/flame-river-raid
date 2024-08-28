import 'package:flame/components.dart';

import 'stage.dart';

class StagePositionComponent extends PositionComponent {
  final Stage stage;

  StagePositionComponent({
    required super.position,
    required super.size,
    required super.priority,
    required this.stage,
  });
}
