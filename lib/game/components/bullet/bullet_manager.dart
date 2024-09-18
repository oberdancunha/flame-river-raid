part of 'bullet.dart';

abstract interface class _IBulletManager {
  void show();
  void bulletPath(double dt);
  void makeAreaCollideable();
  void removeFromWorld();
  bool isMaximumDistanceTraveled();
}

@immutable
final class _BulletManager implements _IBulletManager {
  final Bullet bullet;

  const _BulletManager(this.bullet);

  @override
  void show() => bullet.add(
        SpriteComponent(
          sprite: Assets.bullet,
          size: Vector2(2, 7),
          priority: 1,
        ),
      );

  @override
  void bulletPath(double dt) {
    bullet.position.y += dt * -500;
  }

  @override
  void makeAreaCollideable() => bullet.add(
        RectangleHitbox(
          collisionType: CollisionType.passive,
        ),
      );

  @override
  void removeFromWorld() {
    bullet.game.world.remove(bullet);
  }

  @override
  bool isMaximumDistanceTraveled() => bullet.position.y < RiverRaidGamePlay.plane.position.y - 300;
}
