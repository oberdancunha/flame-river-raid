import 'dart:developer';

import 'package:flutter/material.dart';

import '../../theme/message_menu_theme_extension.dart';
import '../river_raid_router.dart';

final class PlayAgainWidget extends StatelessWidget {
  const PlayAgainWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);
    final themeExtension = Theme.of(context).extension<MessageMenuThemeExtension>()!;

    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        RiverRaidRouter.startGame();
        log('Recomeçar o jogo......');
      },
      child: Text(
        'Jogar novamente',
        style: TextStyle(
          fontSize: mediaSize.width * 0.024,
          color: themeExtension.textColor,
        ),
      ),
    );
  }
}
