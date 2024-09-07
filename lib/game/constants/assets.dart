import 'package:flame/components.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flutter/foundation.dart';

@immutable
final class Assets {
  const Assets._();

  static late TexturePackerAtlas atlas;

  static late final Sprite river;

  static late final Sprite plane;
  static late final Sprite planeExplosion;
  static late final Sprite planeLeft;
  static late final Sprite planeRight;

  static late final Sprite bridge;

  static late final Sprite firstExplosion;
  static late final Sprite secondExplosion;

  static late final Sprite joystickBackground;
  static late final Sprite joystickKnob;
  static late final Sprite joystickButton;
  static late final Sprite joystickButtonPressed;

  static late final Sprite bullet;

  static late final Sprite ship;
  static late final Sprite fighterPlane;

  static late final Sprite helicopter1;
  static late final Sprite helicopter2;
  static late final SpriteAnimation helicopter;

  static late final Sprite fuel;
  static late final Sprite fuelStatusBar;
  static late final Sprite fuelStatusMarker;

  static Future<void> load() async {
    atlas = await TexturePackerAtlas.load('atlas/river_raid.atlas');

    river = findSpriteByName('river');

    plane = findSpriteByName('plane');
    planeExplosion = findSpriteByName('plane_explosion');
    planeLeft = findSpriteByName('plane_left');
    planeRight = findSpriteByName('plane_right');

    bridge = findSpriteByName('bridge');

    firstExplosion = findSpriteByName('first_explosion');
    secondExplosion = findSpriteByName('second_explosion');

    joystickBackground = findSpriteByName('joystick_background');
    joystickKnob = findSpriteByName('joystick_knob');
    joystickButton = findSpriteByName('joystick_button');
    joystickButtonPressed = findSpriteByName('joystick_button_pressed');

    bullet = findSpriteByName('bullet');

    ship = findSpriteByName('ship');
    fighterPlane = findSpriteByName('fighter_plane');

    helicopter1 = findSpriteByName('helicopter1');
    helicopter2 = findSpriteByName('helicopter2');
    helicopter = SpriteAnimation.spriteList(
      [
        helicopter1,
        helicopter2,
      ],
      stepTime: 0.05,
      loop: true,
    );

    fuel = findSpriteByName('fuel');
    fuelStatusBar = findSpriteByName('fuel_status_bar');
    fuelStatusMarker = findSpriteByName('fuel_status_marker');
  }

  static TexturePackerSprite findSpriteByName(String name) => atlas.findSpriteByName(name)!;
}
