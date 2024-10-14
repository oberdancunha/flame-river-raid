import 'package:flutter/material.dart';

import '../gameplay/river_raid_game_play.dart';
import 'widgets/blink_widget.dart';
import 'widgets/main_title_widget.dart';
import 'widgets/menu_template_play_again_widget.dart';
import 'widgets/menu_template_widget.dart';

final class Winner extends StatelessWidget {
  const Winner({super.key});

  static const id = 'Winner';
  static const _title = 'Vencedor!';

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: RiverRaidGamePlay.isWinnerEnd,
        builder: (context, isWinnerEnd, child) {
          if (!isWinnerEnd) {
            return MenuTemplateWidget(
              child: BlinkWidget(
                children: [
                  child!,
                  MainTitleWidget(
                    title: _title,
                    textColor: Colors.transparent,
                  ),
                ],
              ),
            );
          }

          return MenuTemplatePlayAgainWidget(child: child!);
        },
        child: MainTitleWidget(title: _title),
      );
}
