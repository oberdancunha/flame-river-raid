import 'package:flutter/material.dart';

import '../constants/globals.dart';
import 'message_menu_theme_extension.dart';

ThemeData get mainTheme => ThemeData(
      fontFamily: 'River-Raid-Font',
      extensions: const <ThemeExtension>[
        MessageMenuThemeExtension(
          backgroundColor: Color.fromARGB(147, 0, 0, 0),
          textColor: Globals.hudContentColor,
        ),
      ],
    );
