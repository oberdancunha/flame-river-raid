part of 'fuel_status_bar.dart';

abstract interface class _IFuelStatusBarManager {
  void show();
}

@immutable
final class _FuelStatusBarManager implements _IFuelStatusBarManager {
  final FuelStatusBar fuelStatusBar;

  const _FuelStatusBarManager(this.fuelStatusBar);

  @override
  void show() => fuelStatusBar.add(
        SpriteComponent(
          sprite: Assets.fuelStatusBar,
          size: fuelStatusBar.size,
        ),
      );
}
