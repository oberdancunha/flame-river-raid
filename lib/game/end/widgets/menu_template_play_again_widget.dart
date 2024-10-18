import 'package:flutter/material.dart';

import 'menu_template_body_widget.dart';
import 'play_again_widget.dart';

final class MenuTemplatePlayAgainWidget extends StatelessWidget {
  final Widget child;

  const MenuTemplatePlayAgainWidget({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => MenuTemplateBodyWidget(
        child: Stack(
          alignment: Alignment.center,
          children: [
            child,
            Align(
              alignment: Alignment.bottomCenter,
              child: PlayAgainWidget(),
            ),
          ],
        ),
      );
}
