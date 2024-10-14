import 'package:flutter/material.dart';

import 'menu_template_body_widget.dart';

final class MenuTemplateWidget extends StatelessWidget {
  final Widget child;

  const MenuTemplateWidget({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => MenuTemplateBodyWidget(
        child: Center(child: child),
      );
}
