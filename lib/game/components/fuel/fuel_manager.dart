part of 'fuel.dart';

abstract interface class _IFuelManager {
  void show();
  void makeAreaCollideable();
  void explode();
}

@immutable
final class _FuelManager implements _IFuelManager {
  final Fuel fuel;

  const _FuelManager(this.fuel);

  @override
  void show() => fuel.add(SpriteComponent(
        sprite: Assets.fuel,
      ));

  @override
  void makeAreaCollideable() => fuel.add(
        RectangleHitbox(
          collisionType: CollisionType.active,
        ),
      );

  @override
  void explode() => fuel.stage.stageManager.explode(
        horizontalPosition: fuel.position.x,
        verticalPosition: fuel.position.y,
      );
}
