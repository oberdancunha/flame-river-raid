part of 'river_raid_game_play.dart';

abstract interface class _IRiverRaidGamePlayAudioManager {
  void playFlyStart();
  void playFly({int timeToStartInMilliseconds});
  void flyVolumeAndSpeed();
  void stopFly();
  void stopAudios();
  void stopWarnFuel();
  void playFuelUp(AudioSource soloudFuel);
  Future<void> playLowFuel();
  void stopLowFuel();
  Future<void> playOutOfFuel();
  void stopOutOfFuel();
  void playShootBullet();
  void playPlaneCrash();
  void playComponentCrash();
  set isAudioStopped(bool isAudioStopped);
  void playFireworks();
}

final class _RiverRaidGamePlayAudioSoloudManager implements _IRiverRaidGamePlayAudioManager {
  _RiverRaidGamePlayAudioSoloudManager();

  SoundHandle? _soLoudFlyHandle;
  SoundHandle? _soLoudLowFuelHandle;
  SoundHandle? _soLoudOutOfFuelHandle;
  bool _isAudioStopped = false;

  @override
  void playFlyStart() {
    soLoud.play(soLoudFlyStart);
  }

  @override
  void playFly({int timeToStartInMilliseconds = 0}) {
    Future.delayed(Duration(milliseconds: timeToStartInMilliseconds), () async {
      if (RiverRaidGamePlay.plane.planeManager.planeState == PlaneState.isAlive) {
        _soLoudFlyHandle = await soLoud.play(
          soLoudFlyNoise,
          looping: true,
        );
      }
    });
  }

  @override
  void flyVolumeAndSpeed() {
    if (_soLoudFlyHandle != null) {
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
      soLoud
        ..setVolume(_soLoudFlyHandle!, volume)
        ..setRelativePlaySpeed(_soLoudFlyHandle!, speed);
    }
  }

  @override
  void stopFly() {
    if (_soLoudFlyHandle != null) {
      soLoud.stop(_soLoudFlyHandle!);
    }
  }

  @override
  void stopAudios() {
    stopFly();
    stopWarnFuel();
  }

  @override
  void stopWarnFuel() {
    stopLowFuel();
    stopOutOfFuel();
  }

  @override
  void playFuelUp(AudioSource soloudFuel) async {
    final noFuelAudioActive = soLoud.activeSounds
        .where(
          (sound) => sound.hashCode == soloudFuel.hashCode,
        )
        .first
        .handles
        .isEmpty;
    if (noFuelAudioActive) {
      await soLoud.play(soloudFuel);
    }
  }

  @override
  Future<void> playLowFuel() async {
    final noLowFuelAudioActive = soLoud.activeSounds
        .where(
          (sound) => sound.hashCode == soLoudLowFuel.hashCode,
        )
        .first
        .handles
        .isEmpty;
    if (noLowFuelAudioActive && !_isAudioStopped) {
      _soLoudLowFuelHandle = await soLoud.play(soLoudLowFuel, looping: true);
    }
  }

  @override
  void stopLowFuel() {
    if (_soLoudLowFuelHandle != null) {
      final isLowFuelAudioActive = soLoud.activeSounds
          .where(
            (sound) => sound.hashCode == soLoudLowFuel.hashCode,
          )
          .first
          .handles
          .isNotEmpty;
      if (isLowFuelAudioActive) {
        soLoud.stop(_soLoudLowFuelHandle!);
      }
    }
  }

  @override
  Future<void> playOutOfFuel() async {
    final noOutOfFuelAudioActive = soLoud.activeSounds
        .where(
          (sound) => sound.hashCode == soLoudOutOfFuel.hashCode,
        )
        .first
        .handles
        .isEmpty;
    if (noOutOfFuelAudioActive) {
      stopLowFuel();
      _soLoudOutOfFuelHandle = await soLoud.play(soLoudOutOfFuel);
    }
  }

  @override
  void stopOutOfFuel() {
    if (_soLoudOutOfFuelHandle != null) {
      soLoud.stop(_soLoudOutOfFuelHandle!);
    }
  }

  @override
  void playShootBullet() async => soLoud.play(soLoudShootBullets);

  @override
  void playPlaneCrash() async => soLoud.play(soLoudPlaneCrash);

  @override
  void playComponentCrash() async => soLoud.play(soLoudComponentCrash);

  @override
  set isAudioStopped(bool isAudioStopped) => _isAudioStopped = isAudioStopped;

  @override
  void playFireworks() {
    final noFireworksAudioActive = soLoud.activeSounds
        .where(
          (sound) => sound.hashCode == soLoudFireworks.hashCode,
        )
        .first
        .handles
        .isEmpty;
    if (noFireworksAudioActive) {
      soLoud.play(soLoudFireworks);
    }
  }
}
