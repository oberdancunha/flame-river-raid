part of 'border.dart';

abstract interface class _IBorderManager {
  void makeAreaCollideable();
}

@immutable
final class _BorderManager implements _IBorderManager {
  final BorderComponent border;

  const _BorderManager(this.border);

  @override
  void makeAreaCollideable() => border.add(
        RectangleHitbox(
          collisionType: CollisionType.active,
        ),
      );
}
