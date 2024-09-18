import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

part 'border_manager.dart';

final class BorderComponent extends PositionComponent {
  BorderComponent({
    super.position,
    super.size,
  }) : super(
          priority: 1,
        );

  late _IBorderManager borderManager;

  @override
  FutureOr<void> onLoad() {
    borderManager = _BorderManager(this);
    borderManager.makeAreaCollideable();

    return super.onLoad();
  }
}
