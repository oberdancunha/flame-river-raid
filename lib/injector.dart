import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

@immutable
class Injector {
  const Injector._();

  static final _getIt = GetIt.instance;

  static T getOrAdd<T extends Object>(T component) {
    if (!_getIt.isRegistered<T>(instanceName: component.runtimeType.toString())) {
      _getIt.registerFactory<T>(
        () => component,
        instanceName: component.runtimeType.toString(),
      );
    }

    return _getIt.get<T>(instanceName: component.runtimeType.toString());
  }

  static Future<void> clean() async {
    await _getIt.reset(dispose: true);
  }
}
