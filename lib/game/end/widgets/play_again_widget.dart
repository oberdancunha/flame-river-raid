import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../river_raid_game.dart';
import '../../theme/message_menu_theme_extension.dart';

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
      onTap: RiverRaidGame.start,
      child: Text(
        AppLocalizations.of(context)!.playAgain,
        style: TextStyle(
          fontSize: mediaSize.width * 0.024,
          color: themeExtension.textColor,
        ),
      ),
    );
  }
}
