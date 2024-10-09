part of 'river_raid_game_play.dart';

abstract interface class _IRiverRaidGamePlayAudioManager {
  void flyStart();
  void fly({int timeToStartInMilliseconds});
  void flyVolumeAndSpeed();
  Future<void> stopFlyNoise();
  Future<void> shootBullet();
  Future<void> planeCrash();
  Future<void> componentCrash();
  Future<void> fuel(AudioSource soloudFuel);
}

final class _RiverRaidGamePlayAudioSoloudManager implements _IRiverRaidGamePlayAudioManager {
  _RiverRaidGamePlayAudioSoloudManager();

  SoundHandle? _soloudFlyHandle;

  @override
  void flyStart() {
    soloud.play(soloudFlyStart);
  }

  @override
  void fly({int timeToStartInMilliseconds = 0}) {
    Future.delayed(Duration(milliseconds: timeToStartInMilliseconds), () async {
      if (RiverRaidGamePlay.plane.planeManager.planeState == PlaneState.isAlive) {
        _soloudFlyHandle = await soloud.play(
          soloudFlyNoise,
          looping: true,
        );
      }
    });
  }

  @override
  void flyVolumeAndSpeed() {
    if (_soloudFlyHandle != null) {
      late double volume;
      late double speed;
      switch (RiverRaidGamePlay.plane.planeControllerManager.planeSpeedType) {
        case PlaneSpeedEnum.normal:
          volume = 1.0;
          speed = 1.0;
        case PlaneSpeedEnum.fast:
          volume = 2.0;
          speed = 1.1;
        case PlaneSpeedEnum.slow:
          volume = 0.9;
          speed = 0.9;
      }
      soloud
        ..setVolume(_soloudFlyHandle!, volume)
        ..setRelativePlaySpeed(_soloudFlyHandle!, speed);
    }
  }

  @override
  Future<void> stopFlyNoise() async {
    if (_soloudFlyHandle != null) {
      await soloud.stop(_soloudFlyHandle!);
    }
  }

  @override
  Future<void> shootBullet() async => soloud.play(soloudShootBullets);

  @override
  Future<void> planeCrash() async => soloud.play(soloudPlaneCrash);

  @override
  Future<void> componentCrash() async => soloud.play(soloudComponentCrash);

  @override
  Future<void> fuel(AudioSource soloudFuel) async {
    final noAudioActive = soloud.activeSounds
        .where(
          (sound) => sound.hashCode == soloudFuel.hashCode,
        )
        .first
        .handles
        .isEmpty;
    if (noAudioActive) {
      await soloud.play(soloudFuel);
    }
  }
}
