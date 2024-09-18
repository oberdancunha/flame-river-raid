import 'package:flutter/material.dart';

import 'river_raid_game_play.dart';

abstract interface class _IRiverRaidGamePlayResetTimerManager {
  bool isTimerToResetGameRunning();
  void startTimerToResetGame();
  void executeActionsAfterTick(Function()? onTick);
  void runtimeCount(double countValue);
  bool isTimerToResetGameFinished();
  void stopTimerToResetGame();
}

@immutable
final class _RiverRaidGamePlayResetTimerManager implements _IRiverRaidGamePlayResetTimerManager {
  final RiverRaidGamePlay gamePlay;

  const _RiverRaidGamePlayResetTimerManager(this.gamePlay);

  @override
  bool isTimerToResetGameRunning() => gamePlay.resetTimer.isRunning();

  @override
  void startTimerToResetGame() {
    gamePlay.resetTimer.start();
  }

  @override
  void executeActionsAfterTick(Function()? onTick) {
    gamePlay.resetTimer.onTick = onTick;
  }

  @override
  void runtimeCount(double countValue) {
    gamePlay.resetTimer.update(countValue);
  }

  @override
  bool isTimerToResetGameFinished() => gamePlay.resetTimer.finished;

  @override
  void stopTimerToResetGame() {
    gamePlay.resetTimer.stop();
  }
}

extension RiverRaidGamePlayTimerExtension on RiverRaidGamePlay {
  _IRiverRaidGamePlayResetTimerManager get resetTimerManager =>
      _RiverRaidGamePlayResetTimerManager(this);
}
