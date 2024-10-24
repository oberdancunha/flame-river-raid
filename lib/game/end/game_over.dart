import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/main_title_widget.dart';
import 'widgets/menu_template_play_again_widget.dart';

final class GameOver extends StatelessWidget {
  const GameOver({super.key});

  static const id = 'GameOver';

  @override
  Widget build(BuildContext context) => MenuTemplatePlayAgainWidget(
        child: MainTitleWidget(title: AppLocalizations.of(context)!.gameOver),
      );
}
