import 'package:flutter_soloud/flutter_soloud.dart';

final soLoud = SoLoud.instance;
late AudioSource soLoudFlyStart;
late AudioSource soLoudFlyNoise;
late AudioSource soLoudShootBullets;
late AudioSource soLoudPlaneCrash;
late AudioSource soLoudComponentCrash;
late AudioSource soLoudFuelUp;
late AudioSource soLoudFuelTankFilled;
late AudioSource soLoudLowFuel;
late AudioSource soLoudOutOfFuel;
late AudioSource soLoudFireworks;

Future<void> initSoLoud() async {
  await soLoud.init();
  soLoudFlyStart = await soLoud.loadAsset('assets/audio/fly_start.wav');
  soLoudFlyNoise = await soLoud.loadAsset('assets/audio/fly_noise.wav');
  soLoudShootBullets = await soLoud.loadAsset('assets/audio/shoot_bullet.wav');
  soLoudPlaneCrash = await soLoud.loadAsset('assets/audio/plane_crash.wav');
  soLoudComponentCrash = await soLoud.loadAsset('assets/audio/component_crash.wav');
  soLoudFuelUp = await soLoud.loadAsset('assets/audio/fuel_up.wav');
  soLoudFuelTankFilled = await soLoud.loadAsset('assets/audio/fuel_tank_filled.wav');
  soLoudLowFuel = await soLoud.loadAsset('assets/audio/low_fuel.wav');
  soLoudOutOfFuel = await soLoud.loadAsset('assets/audio/out_of_fuel.wav');
  soLoudFireworks = await soLoud.loadAsset('assets/audio/fireworks.wav');
}
