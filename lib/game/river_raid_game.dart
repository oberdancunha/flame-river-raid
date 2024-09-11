import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'components/bridge/bridge.dart';
import 'components/hud/hud.dart';
import 'components/hud/joystick/joystick.dart';
import 'components/hud/joystick/joystick_button.dart';
import 'components/plane/plane.dart';
import 'components/stage/stage.dart';
import 'constants/globals.dart';
import 'river_raid_game_manager.dart';
import 'river_raid_world.dart';

final class RiverRaidGame extends FlameGame with HasCollisionDetection {
  RiverRaidGame()
      : super(
          world: RiverRaidWorld(),
          camera: CameraComponent(
            hudComponents: [
              Hud(),
            ],
          )
            ..viewport.size = Globals.gameSize
            ..viewfinder.visibleGameSize = Globals.gameSize
            ..viewfinder.position = Vector2(0, 0)
            ..viewfinder.anchor = Anchor.bottomLeft,
        );

  late PlaneComponent plane;

  late Stage stage;
  final stagesPositionInWorld = <double>[];
  var stages = <String>[];

  ValueNotifier<bool> isBridgeExploding = ValueNotifier<bool>(false);
  late Bridge lastBridge;

  static ValueNotifier<int> totalScore = ValueNotifier<int>(0);
  static ValueNotifier<double> fuelMarker = ValueNotifier<double>(Globals.indexFullFuel);

  static late Joystick joystick;
  static late JoystickButton joystickButton;

  @override
  FutureOr<void> onLoad() async {
    joystick = Joystick(
      size: size.joystickSize,
      knobSize: size.joystickButtonSize,
      marginLeft: size.joystickHorizontalMargin,
    );
    joystickButton = JoystickButton(
      size: size.joystickButtonSize,
      marginRight: size.joystickHorizontalMargin,
      marginBottom: size.joystickVerticalMargin,
    );
    camera.viewport.position.y = -(size.y / 7.1);
    riverRaidGameManager.listAllStagesAvailable();

    return super.onLoad();
  }
}
