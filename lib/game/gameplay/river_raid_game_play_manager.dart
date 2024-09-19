part of 'river_raid_game_play.dart';

abstract interface class _IRiverRaidGamePlayManager {
  set stage(Stage stage);
  Stage get stage;
  List<double> get stagesPositionInWorld;
  void addStagePositionInWorld(double position);
  set lastBridge(Bridge bridge);
  Bridge get lastBridge;
  set isBridgeExploding(bool value);
  bool get isBridgeExploding;
  ValueNotifier get isBridgeExplodingNotifier;
}

final class _RiverRaidGamePlayManager implements _IRiverRaidGamePlayManager {
  late Stage _stage;
  final _stagesPositionInWorld = <double>[];
  late Bridge _lastBridge;
  final ValueNotifier<bool> _isBridgeExploding = ValueNotifier<bool>(false);

  @override
  set stage(Stage stage) => _stage = stage;

  @override
  Stage get stage => _stage;

  @override
  List<double> get stagesPositionInWorld => _stagesPositionInWorld;

  @override
  void addStagePositionInWorld(double position) => _stagesPositionInWorld.add(position);

  @override
  set lastBridge(Bridge bridge) => _lastBridge = bridge;

  @override
  Bridge get lastBridge => _lastBridge;

  @override
  set isBridgeExploding(bool value) => _isBridgeExploding.value = value;

  @override
  bool get isBridgeExploding => _isBridgeExploding.value;

  @override
  ValueNotifier get isBridgeExplodingNotifier => _isBridgeExploding;
}
