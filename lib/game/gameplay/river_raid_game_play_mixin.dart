import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../extensions/iterable_extension.dart';
import 'river_raid_game_play.dart';

mixin HasGamePlayRef<T extends RiverRaidGamePlay> on Component {
  T? _gamePlay;

  T get gamePlay => _gamePlay ??= _findWorldAndCheck();

  @visibleForTesting
  set gamePlay(T? value) => _gamePlay = value;

  T? findGamePlayRef() =>
      ancestors(includeSelf: true).firstWhereOrNull((ancestor) => ancestor is T) as T?;

  T _findWorldAndCheck() {
    final gamePlay = findGamePlayRef();
    assert(
      gamePlay != null,
      'Could not find a GamePlay instance of type $T',
    );

    return gamePlay!;
  }
}
