import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'river_raid_game.dart';

abstract interface class _IRiverRaidGameManager {
  Future<void> listAllStagesAvailable();
  void finish();
}

@immutable
final class _RiverRaidManager implements _IRiverRaidGameManager {
  final RiverRaidGame game;

  const _RiverRaidManager(this.game);

  @override
  Future<void> listAllStagesAvailable() async {
    final assets = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> assetsJson = json.decode(assets);
    game.stages = assetsJson.keys.where((asset) => asset.endsWith('.tmx')).toList();
  }

  @override
  void finish() {
    game.paused = true;
  }
}

extension RiverRaidGameExtension on RiverRaidGame {
  _IRiverRaidGameManager get riverRaidGameManager => _RiverRaidManager(this);
}
