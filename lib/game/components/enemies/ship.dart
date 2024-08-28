import 'dart:async';

import 'enemy_component.dart';
import 'enemy_manager.dart';

final class Ship extends EnemyComponent {
  Ship({
    required super.isReverse,
    required super.hasMove,
    required super.position,
    required super.size,
    required super.stage,
  }) : super(
          priority: 1,
        );

  @override
  FutureOr<void> onLoad() {
    enemyManager.showShip();

    return super.onLoad();
  }
}
