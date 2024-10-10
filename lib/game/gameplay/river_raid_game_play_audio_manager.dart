part of 'river_raid_game_play.dart';

abstract interface class _IRiverRaidGamePlayAudioManager {
  void flyStart();
  void fly({int timeToStartInMilliseconds});
  void flyVolumeAndSpeed();
  void stopFly();
  void stopAudios();
  void stopWarnFuel();
  void shootBullet();
  void planeCrash();
  void componentCrash();
  void fuelUp(AudioSource soloudFuel);
  Future<void> lowFuel();
  void stopLowFuel();
  Future<void> outOfFuel();
  void stopOutOfFuel();
  set isAudioStopped(bool isAudioStopped);
  void fireworks();
}

final class _RiverRaidGamePlayAudioSoloudManager implements _IRiverRaidGamePlayAudioManager {
  _RiverRaidGamePlayAudioSoloudManager();

  SoundHandle? _soloudFlyHandle;
  SoundHandle? _soloudLowFuelHandle;
  SoundHandle? _soloudOutOfFuelHandle;
  bool _isAudioStopped = false;

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
  void stopFly() {
    if (_soloudFlyHandle != null) {
      soloud.stop(_soloudFlyHandle!);
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
  void shootBullet() async => soloud.play(soloudShootBullets);

  @override
  void planeCrash() async => soloud.play(soloudPlaneCrash);

  @override
  void componentCrash() async => soloud.play(soloudComponentCrash);

  @override
  void fuelUp(AudioSource soloudFuel) async {
    final noFuelAudioActive = soloud.activeSounds
        .where(
          (sound) => sound.hashCode == soloudFuel.hashCode,
        )
        .first
        .handles
        .isEmpty;
    if (noFuelAudioActive) {
      await soloud.play(soloudFuel);
    }
  }

  @override
  Future<void> lowFuel() async {
    final noLowFuelAudioActive = soloud.activeSounds
        .where(
          (sound) => sound.hashCode == soloudLowFuel.hashCode,
        )
        .first
        .handles
        .isEmpty;
    if (noLowFuelAudioActive && !_isAudioStopped) {
      _soloudLowFuelHandle = await soloud.play(soloudLowFuel, looping: true);
    }
  }

  @override
  void stopLowFuel() {
    if (_soloudLowFuelHandle != null) {
      final isLowFuelAudioActive = soloud.activeSounds
          .where(
            (sound) => sound.hashCode == soloudLowFuel.hashCode,
          )
          .first
          .handles
          .isNotEmpty;
      if (isLowFuelAudioActive) {
        soloud.stop(_soloudLowFuelHandle!);
      }
    }
  }

  @override
  Future<void> outOfFuel() async {
    final noOutOfFuelAudioActive = soloud.activeSounds
        .where(
          (sound) => sound.hashCode == soloudOutOfFuel.hashCode,
        )
        .first
        .handles
        .isEmpty;
    if (noOutOfFuelAudioActive) {
      stopLowFuel();
      _soloudOutOfFuelHandle = await soloud.play(soloudOutOfFuel);
    }
  }

  @override
  void stopOutOfFuel() {
    if (_soloudOutOfFuelHandle != null) {
      soloud.stop(_soloudOutOfFuelHandle!);
    }
  }

  @override
  set isAudioStopped(bool isAudioStopped) => _isAudioStopped = isAudioStopped;

  @override
  void fireworks() {
    final noFireworksAudioActive = soloud.activeSounds
        .where(
          (sound) => sound.hashCode == soloudFireworks.hashCode,
        )
        .first
        .handles
        .isEmpty;
    if (noFireworksAudioActive) {
      soloud.play(soloudFireworks);
    }
  }
}
