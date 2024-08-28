import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'app_widget.dart';
import 'game/constants/assets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setPortrait();
  await Flame.device.fullScreen();
  await Assets.load();

  runApp(const AppWidget());
}
