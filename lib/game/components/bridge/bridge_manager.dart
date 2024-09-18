part of 'bridge.dart';

abstract interface class _IBridgeManager {
  void show();
  void makeAreaCollideable();
  void explode();
}

@immutable
final class _BridgeManager implements _IBridgeManager {
  final Bridge bridge;

  const _BridgeManager(this.bridge);

  @override
  void show() => bridge.add(
        SpriteComponent(
          sprite: Assets.bridge,
        ),
      );

  @override
  void makeAreaCollideable() => bridge.add(
        RectangleHitbox(
          collisionType: CollisionType.active,
        ),
      );

  @override
  void explode() async {
    final explosionSequence = [
      Assets.firstExplosion,
      Assets.secondExplosion,
      Assets.firstExplosion
    ];
    final normalizePosition = Assets.secondExplosion.srcSize.x / 2;
    final adjustHorizontalPosition = (bridge.size.x / normalizePosition).round();
    final firstHorizontalPosition = bridge.position.x + adjustHorizontalPosition;
    final bridgeEndPosition = bridge.position.x + bridge.size.x;
    final secondHorizontalPosition =
        bridgeEndPosition - adjustHorizontalPosition - normalizePosition;
    final verticalPosition = (bridge.size.y - bridge.position.y) / 2;

    final firstExplosion = SpritesExplosion.buildAnimation(
      explosionSequence: explosionSequence,
      horizontalPosition: firstHorizontalPosition,
      verticalPosition: verticalPosition,
    );
    final secondExplosion = SpritesExplosion.buildAnimation(
      explosionSequence: explosionSequence,
      horizontalPosition: secondHorizontalPosition,
      verticalPosition: verticalPosition,
    );
    bridge.stage.add(firstExplosion);
    bridge.stage.add(secondExplosion);
  }
}
