import 'package:flutter/material.dart';

@immutable
final class MessageMenuThemeExtension extends ThemeExtension<MessageMenuThemeExtension> {
  final Color? backgroundColor;
  final Color? textColor;

  const MessageMenuThemeExtension({
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  ThemeExtension<MessageMenuThemeExtension> copyWith({Color? backgroundColor, Color? textColor}) =>
      MessageMenuThemeExtension(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        textColor: textColor ?? this.textColor,
      );

  @override
  ThemeExtension<MessageMenuThemeExtension> lerp(
    covariant ThemeExtension<MessageMenuThemeExtension>? other,
    double t,
  ) {
    if (other is! MessageMenuThemeExtension) {
      return this;
    }

    return MessageMenuThemeExtension(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      textColor: textColor,
    );
  }
}
