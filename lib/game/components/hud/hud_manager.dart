part of 'hud.dart';

abstract interface class _IHudManager {
  Future<void> loadHudTiled();
}

@immutable
final class _HudManager implements _IHudManager {
  final Hud hud;

  const _HudManager(this.hud);

  @override
  Future<void> loadHudTiled() async {
    final tiledHud = await RiverRaidComponent.readTiledFile('hud.tmx', tileSize: 5);
    final scaleX = (hud.size.sizeBetweenJoystickAndButton / 2) / tiledHud.size.x;
    final scaleY = hud.size.y / tiledHud.size.y;
    final adjustPosition = (tiledHud.size.x * scaleX) / 2;
    hud.add(
      HudTiled(
        tiledHud.tileMap,
        position: Vector2(hud.game.size.fuelStatusBarHorizontalPosition - adjustPosition, 1),
        scale: Vector2(scaleX, scaleY - 0.05),
      ),
    );
  }
}
