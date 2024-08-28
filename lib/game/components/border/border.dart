import 'dart:async';

import 'package:flame/components.dart';

import 'border_manager.dart';

final class BorderComponent extends PositionComponent {
  BorderComponent({
    super.position,
    super.size,
  }) : super(
          priority: 1,
        );

  @override
  FutureOr<void> onLoad() {
    borderManager.makeAreaCollideable();

    return super.onLoad();
  }
}
