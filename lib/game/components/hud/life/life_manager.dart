part of 'life.dart';

abstract interface class _ILifeManager {
  void show();
  void update();
}

final class _LifeManager implements _ILifeManager {
  final Life life;

  _LifeManager(this.life);

  late Info _life;

  @override
  void show() {
    _life = Info(
      text: life.game.riverRaidGameManager.showLifeValue.toString(),
      position: Vector2(life.size.x - 1, life.size.y / 2.5),
      anchor: Anchor.centerRight,
    );
    life.add(_life);
  }

  @override
  void update() {
    life.remove(_life);
    show();
  }
}
