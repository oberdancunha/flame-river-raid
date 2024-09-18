import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'components/hud/joystick/joystick.dart';
import 'components/hud/joystick/joystick_button.dart';
import 'constants/globals.dart';
import 'river_raid_game.dart';

abstract interface class _IRiverRaidGameManager {
  Future<void> listAllStagesAvailable();
  void startGame();
  void finish();
  ValueListenable get showLife;
  int get showLifeValue;
  void decreaseLife();
  ValueListenable get showScore;
  int get showScoreValue;
  void sumScore(int value);
  List<String> get allStagesInGame;
  int get allStagesTotal;
  void addNextStageToShow();
  void resetNextStageToShow();
  int get nextStageToShow;
  String get stageName;
  int get crossedBridges;
  void addCrossedBridges();
  Joystick get joystick;
  JoystickButton get joystickButton;
}

final class _RiverRaidManager implements _IRiverRaidGameManager {
  final RiverRaidGame game;

  factory _RiverRaidManager(RiverRaidGame game) => _instance = _RiverRaidManager._(game);

  _RiverRaidManager._(this.game) {
    _joystick = Joystick(
      size: game.size.joystickSize,
      knobSize: game.size.joystickButtonSize,
      marginLeft: game.size.joystickHorizontalMargin,
    );
    _joystickButton = JoystickButton(
      size: game.size.joystickButtonSize,
      marginRight: game.size.joystickHorizontalMargin,
      marginBottom: game.size.joystickVerticalMargin,
    );
  }

  static _RiverRaidManager? _instance;
  late List<String> _stages;
  late int _nextStageToShow = 1;
  late int _crossedBridges = 0;
  late Joystick _joystick;
  late JoystickButton _joystickButton;

  final ValueNotifier<int> _totalScore = ValueNotifier<int>(Globals.initialScore);
  final ValueNotifier<int> _totalLife = ValueNotifier<int>(Globals.totalLife);

  @override
  Future<void> listAllStagesAvailable() async {
    final assets = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> assetsJson = json.decode(assets);
    _stages = assetsJson.keys
        .where(
          (asset) => asset.contains(RegExp(r'stage_\d+.tmx')),
        )
        .toList();
  }

  @override
  void startGame() {
    _nextStageToShow = 1;
    _crossedBridges = 0;
    _totalScore.value = Globals.initialScore;
    _totalLife.value = Globals.totalLife;
  }

  @override
  void finish() {
    game.paused = true;
  }

  @override
  ValueListenable get showLife => _totalLife;

  @override
  int get showLifeValue => _totalLife.value;

  @override
  void decreaseLife() {
    _totalLife.value--;
  }

  @override
  ValueListenable get showScore => _totalScore;

  @override
  int get showScoreValue => _totalScore.value;

  @override
  void sumScore(value) {
    _totalScore.value += value;
  }

  @override
  List<String> get allStagesInGame => _stages;

  @override
  int get allStagesTotal => _stages.length;

  @override
  void addNextStageToShow() {
    _nextStageToShow++;
  }

  @override
  void resetNextStageToShow() {
    _nextStageToShow = _crossedBridges + 1;
  }

  @override
  int get nextStageToShow => _nextStageToShow;

  @override
  String get stageName => 'stage_$nextStageToShow.tmx';

  @override
  int get crossedBridges => _crossedBridges;

  @override
  void addCrossedBridges() {
    _crossedBridges++;
  }

  @override
  Joystick get joystick => _joystick;

  @override
  JoystickButton get joystickButton => _joystickButton;
}

extension RiverRaidGameExtension on RiverRaidGame {
  _IRiverRaidGameManager get riverRaidGameManager =>
      _RiverRaidManager._instance ?? _RiverRaidManager(this);
}
