part of 'river_raid_game_play.dart';

abstract interface class _IRiverRaidGamePlayResetTimerManager {
  bool isTimerToResetGameRunning();
  void startTimerToResetGame();
  void executeActionsAfterTick(Function()? onTick);
  void runtimeCount(double countValue);
  bool isTimerToResetGameFinished();
  void stopTimerToResetGame();
}

final class _RiverRaidGamePlayResetTimerManager implements _IRiverRaidGamePlayResetTimerManager {
  _RiverRaidGamePlayResetTimerManager();

  final _resetTimer = Timer(
    1,
    autoStart: false,
    repeat: false,
  );

  @override
  bool isTimerToResetGameRunning() => _resetTimer.isRunning();

  @override
  void startTimerToResetGame() {
    _resetTimer.start();
  }

  @override
  void executeActionsAfterTick(Function()? onTick) {
    _resetTimer.onTick = onTick;
  }

  @override
  void runtimeCount(double countValue) {
    _resetTimer.update(countValue);
  }

  @override
  bool isTimerToResetGameFinished() => _resetTimer.finished;

  @override
  void stopTimerToResetGame() {
    _resetTimer.stop();
  }
}
