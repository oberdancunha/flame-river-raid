import 'package:flutter_soloud/flutter_soloud.dart';

final soloud = SoLoud.instance;
late AudioSource soloudFlyStart;
late AudioSource soloudFlyNoise;
late AudioSource soloudShootBullets;
late AudioSource soloudPlaneCrash;
late AudioSource soloudComponentCrash;
late AudioSource soloudFuelUp;
late AudioSource soloudFuelTankFilled;
late AudioSource soloudLowFuel;
late AudioSource soloudOutOfFuel;
late AudioSource soloudFireworks;

Future<void> initSoLoud() async {
  await soloud.init();
  soloudFlyStart = await soloud.loadAsset('assets/audio/fly_start.wav');
  soloudFlyNoise = await soloud.loadAsset('assets/audio/fly_noise.wav');
  soloudShootBullets = await soloud.loadAsset('assets/audio/shoot_bullet.wav');
  soloudPlaneCrash = await soloud.loadAsset('assets/audio/plane_crash.wav');
  soloudComponentCrash = await soloud.loadAsset('assets/audio/component_crash.wav');
  soloudFuelUp = await soloud.loadAsset('assets/audio/fuel_up.wav');
  soloudFuelTankFilled = await soloud.loadAsset('assets/audio/fuel_tank_filled.wav');
  soloudLowFuel = await soloud.loadAsset('assets/audio/low_fuel.wav');
  soloudOutOfFuel = await soloud.loadAsset('assets/audio/out_of_fuel.wav');
  soloudFireworks = await soloud.loadAsset('assets/audio/fireworks.wav');
}
