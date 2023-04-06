import 'dart:math' as math;

abstract class RotaryDimensions {
  static const double none = 0;
  static const double extraSmall = 1;
  static const double small = 4;
  static const double medium = 8;
  static const double large = 16;
  static const double extraLarge = 32;

  static const double smallDigitSize = 24;
  static const double largeDigitSize = 36;

  static const double rotaryRingPadding = 4;
  static const double rotaryRingWidth = 80;

  static const dialNumberPadding = 8.0;
  static const double dialNumberRadius = 30;
  static const double firstDialNumberPosition = math.pi / 3;
  static const double rotarySweepAngle = 4.712;

  static const double maxRotaryRingAngle = math.pi * 7 / 4;
  static const double maxRotaryRingSweepAngle = math.pi / 2 * 3;

  static const double logoWidth = 128;
  static const double logoHeight = 128;
}
