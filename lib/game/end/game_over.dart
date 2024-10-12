import 'package:flutter/material.dart';

import 'widgets/main_title_widget.dart';
import 'widgets/menu_template_widget.dart';

final class GameOver extends StatelessWidget {
  const GameOver({
    super.key,
  });

  static const id = 'GameOver';

  @override
  Widget build(BuildContext context) => MenuTemplateWidget(
        child: MainTitleWidget(title: 'Game Over!'),
      );
}
