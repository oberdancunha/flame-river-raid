import 'package:flame/components.dart';
import 'package:flame/game.dart';

import '../end/game_over.dart';
import '../end/winner.dart';
import '../gameplay/river_raid_game_play.dart';

final class RiverRaidRouter extends RouterComponent {
  RiverRaidRouter()
      : super(
          initialRoute: RiverRaidGamePlay.id,
          routes: {
            RiverRaidGamePlay.id: gamePlayRoute,
            GameOver.id: gameOverRoute,
            Winner.id: winnerRoute,
          },
        );

  static Route get gamePlayRoute => Route(
        () => RiverRaidGamePlay(
          key: ComponentKey.named(RiverRaidGamePlay.id),
        ),
      );

  static OverlayRoute get gameOverRoute => OverlayRoute(
        (_, __) => GameOver(),
      );

  static OverlayRoute get winnerRoute => OverlayRoute(
        (_, __) => Winner(),
      );
}
