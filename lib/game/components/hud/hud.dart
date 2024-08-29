import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';

import '../../constants/globals.dart';
import '../../river_raid_game.dart';
import 'score.dart';

final class Hud extends RectangleComponent {
  Hud()
      : super(
          size: Vector2(Globals.hudComponentSize, 90),
          position: Vector2(0, 690),
          paintLayers: [
            Paint()..color = const Color(0XFF8E8E8E),
            Paint()
              ..color = const Color(0xFF000000)
              ..strokeWidth = 2
              ..style = PaintingStyle.stroke
          ],
        );

  static final scorePosition = Vector2(Globals.hudComponentSize / 2, -2);
  late Score score = Score(
    text: RiverRaidGame.totalScore.value.toString(),
    position: scorePosition,
  );

  @override
  FutureOr<void> onLoad() {
    addAll([
      RiverRaidGame.joystick,
      RiverRaidGame.joystickButton,
      score,
    ]);
    RiverRaidGame.totalScore.addListener(_updateTotalScore);

    return super.onLoad();
  }

  @override
  void onRemove() {
    RiverRaidGame.totalScore.removeListener(_updateTotalScore);
    super.onRemove();
  }

  void _updateTotalScore() {
    remove(score);
    score = Score(
      text: RiverRaidGame.totalScore.value.toString(),
      position: scorePosition,
    );
    add(score);
  }
}
