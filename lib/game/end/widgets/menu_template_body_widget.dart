import 'package:flutter/material.dart';

import '../../theme/message_menu_theme_extension.dart';

class MenuTemplateBodyWidget extends StatelessWidget {
  final Widget child;

  const MenuTemplateBodyWidget({
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
          height: mediaSize.height * 0.2,
          child: child,
        ),
      ),
    );
  }
}
