import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../gameplay/river_raid_game_play.dart';
import 'widgets/blink_widget.dart';
import 'widgets/main_title_widget.dart';
import 'widgets/menu_template_play_again_widget.dart';
import 'widgets/menu_template_widget.dart';

final class Winner extends StatelessWidget {
  const Winner({super.key});

  static const id = 'Winner';

  @override
  Widget build(BuildContext context) {
    final title = AppLocalizations.of(context)!.youWin;

    return ValueListenableBuilder(
      valueListenable: RiverRaidGamePlay.isWinnerEnd,
      builder: (context, isWinnerEnd, child) {
        if (!isWinnerEnd) {
          return MenuTemplateWidget(
            child: BlinkWidget(
              children: [
                child!,
                MainTitleWidget(
                  title: title,
                  textColor: Colors.transparent,
                ),
              ],
            ),
          );
        }

        return MenuTemplatePlayAgainWidget(child: child!);
      },
      child: MainTitleWidget(title: title),
    );
  }
}
