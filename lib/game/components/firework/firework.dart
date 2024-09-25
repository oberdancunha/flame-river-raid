import 'dart:async';

import 'package:flame/components.dart';

import '../../gameplay/river_raid_game_play_mixin.dart';
import '../../river_raid_game.dart';

final class Firework extends SpriteAnimationComponent
    with HasGameRef<RiverRaidGame>, HasGamePlayRef {
  Firework({
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          removeOnFinish: true,
        );

  @override
  FutureOr<void> onLoad() async {
    gamePlay.gamePlayManager.isExplodeFireworksNotifier.addListener(_explodeFireworks);

    return super.onLoad();
  }

  @override
  void onRemove() {
    super.onRemove();
    gamePlay.gamePlayManager.isExplodeFireworksNotifier.removeListener(_explodeFireworks);
  }

  void _explodeFireworks() async {
    if (gamePlay.gamePlayManager.isExplodeFireworks == true) {
      animation = await game.loadSpriteAnimation(
        'spritesheet/fireworks.png',
        SpriteAnimationData.sequenced(
          amountPerRow: 6,
          amount: 30,
          stepTime: 0.05,
          textureSize: Vector2.all(256),
        ),
      );
    }
  }
}
