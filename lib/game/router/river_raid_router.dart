import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart' hide Route, OverlayRoute;

import '../gameplay/river_raid_game_play.dart';

final class RiverRaidRouter extends RouterComponent {
  RiverRaidRouter()
      : super(
          initialRoute: RiverRaidGamePlay.id,
          routes: {
            RiverRaidGamePlay.id: startGame,
            'menu': OverlayRoute(
              (_, __) => const SizedBox.shrink(),
            ),
          },
        );

  static Route get startGame => Route(
        () => RiverRaidGamePlay(
          key: ComponentKey.named(RiverRaidGamePlay.id),
        ),
      );
}
