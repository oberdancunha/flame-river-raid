import 'package:flame/components.dart';
import 'package:flame/game.dart';

import '../gameplay/river_raid_game_play.dart';
import '../river_raid_game.dart';
import 'widgets/game_over.dart';

final class RiverRaidRouter extends RouterComponent {
  final RiverRaidGame _game;

  RiverRaidRouter(this._game)
      : super(
          initialRoute: RiverRaidGamePlay.id,
          routes: {
            RiverRaidGamePlay.id: gamePlayRoute,
            GameOver.id: gameOverRoute,
          },
        ) {
    game = _game;
  }

  static late RiverRaidGame game;

  static Route get gamePlayRoute => Route(
        () => RiverRaidGamePlay(
          key: ComponentKey.named(RiverRaidGamePlay.id),
        ),
      );

  static OverlayRoute get gameOverRoute => OverlayRoute(
        (_, __) => GameOver(),
      );

  static void startGame() {
    game.riverRaidGameManager.startGame();
    game.riverRaidRouter.pop();
    game.riverRaidRouter.pushReplacement(RiverRaidRouter.gamePlayRoute, name: RiverRaidGamePlay.id);
    if (game.paused) {
      game.resumeEngine();
    }
  }
}
