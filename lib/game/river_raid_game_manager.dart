part of 'river_raid_game.dart';

abstract interface class _IRiverRaidGameManager {
  Future<void> listAllStagesAvailable();
  void start();
  void finish();
  ValueListenable get showLife;
  int get showLifeValue;
  void decreaseLife();
  ValueListenable get showScore;
  int get showScoreValue;
  void addScore(int value);
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
  void removeHudView(double dt);
  set gameState(RiverRaidGameState gameState);
  RiverRaidGameState get gameState;
  bool isGameOver();
  void gameOver();
}

final class _RiverRaidGameManager implements _IRiverRaidGameManager {
  final RiverRaidGame game;

  _RiverRaidGameManager(this.game) {
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

  late List<String> _stages;
  late int _nextStageToShow;
  late int _crossedBridges;
  late Joystick _joystick;
  late JoystickButton _joystickButton;

  final ValueNotifier<int> _totalScore = ValueNotifier<int>(Globals.initialScore);
  final ValueNotifier<int> _totalLife = ValueNotifier<int>(Globals.totalLife);

  late RiverRaidGameState _gameState;

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
  void start() {
    _nextStageToShow = 1;
    _crossedBridges = 0;
    _totalScore.value = Globals.initialScore;
    _totalLife.value = Globals.totalLife;
    _gameState = RiverRaidGameState.run;
    if (game.camera.viewport.position.y == 0) {
      game.camera.viewport.position.y = -(game.size.y / 7.1);
    }
  }

  @override
  void finish() {
    game.pauseEngine();
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
  void addScore(int score) {
    var addedScore = _totalScore.value + score;
    if (addedScore > Globals.maxScore) {
      addedScore = Globals.maxScore;
    }
    _totalScore.value = addedScore;
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

  @override
  void removeHudView(double dt) {
    final viewPortPositionY = game.camera.viewport.position.y + (dt * 60);
    if (viewPortPositionY < 0) {
      game.camera.viewport.position.y = viewPortPositionY;
    } else {
      game.camera.viewport.position.y = 0;
    }
  }

  @override
  set gameState(RiverRaidGameState gameState) => _gameState = gameState;

  @override
  RiverRaidGameState get gameState => _gameState;

  @override
  bool isGameOver() => _totalLife.value < 0;

  @override
  void gameOver() {
    game.riverRaidRouter.pushOverlay(GameOver.id);
    game.pauseEngine();
  }
}
