import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app_widget.dart';
import 'game/constants/assets.dart';
import 'game/soloud.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setPortrait();
  await Flame.device.fullScreen();
  await Assets.load();
  await initSoLoud();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration(seconds: 1), FlutterNativeSplash.remove);

  runApp(const AppWidget());
}
