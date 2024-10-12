import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/river_raid_game.dart';
import 'game/theme/theme.dart';

@immutable
final class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: mainTheme,
        home: GameWidget.controlled(gameFactory: RiverRaidGame.new),
      );
}
