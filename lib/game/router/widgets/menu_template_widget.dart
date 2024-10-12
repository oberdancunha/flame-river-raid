import 'package:flutter/material.dart';

import '../../theme/message_menu_theme_extension.dart';
import 'play_again_widget.dart';

final class MenuTemplateWidget extends StatelessWidget {
  final Widget child;

  const MenuTemplateWidget({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);
    final themeExtension = Theme.of(context).extension<MessageMenuThemeExtension>()!;

    return Scaffold(
      backgroundColor: themeExtension.backgroundColor,
      body: Center(
        child: SizedBox(
          width: mediaSize.width,
          height: mediaSize.height / 3,
          child: Stack(
            alignment: Alignment.center,
            children: [
              child,
              Positioned(
                bottom: 40,
                height: 20,
                child: PlayAgainWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
