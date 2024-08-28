import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/river_raid_game.dart';

@immutable
final class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: GameWidget.controlled(gameFactory: RiverRaidGame.new),
          ),
        ),
      );
}
