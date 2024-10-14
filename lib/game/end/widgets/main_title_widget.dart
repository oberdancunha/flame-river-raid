import 'package:flutter/material.dart';

import '../../theme/message_menu_theme_extension.dart';

class MainTitleWidget extends StatelessWidget {
  final String title;
  final Color? textColor;

  const MainTitleWidget({
    required this.title,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);
    final themeExtension = Theme.of(context).extension<MessageMenuThemeExtension>()!;

    return Text(
      title,
      style: TextStyle(
        fontSize: mediaSize.width * 0.048,
        color: textColor ?? themeExtension.textColor,
      ),
    );
  }
}
