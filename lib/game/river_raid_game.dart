import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

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
            ..viewport.position = Vector2(0, -Globals.paddingVerticalStartPosition)
            ..viewfinder.visibleGameSize = Globals.gameSize
            ..viewfinder.position = Vector2(0, 0)
            ..viewfinder.anchor = Anchor.bottomLeft,
        );

  late PlaneComponent plane;
  late Stage stage;
  ValueNotifier<bool> isBridgeExploding = ValueNotifier<bool>(false);
  static final joystick = Joystick();
  static final joystickButton = JoystickButton();
  var stages = <String>[];
  final stagesPositionInWord = <double>[];

  @override
  FutureOr<void> onLoad() async {
    riverRaidGameManager.listAllStagesAvailable();

    return super.onLoad();
  }
}
