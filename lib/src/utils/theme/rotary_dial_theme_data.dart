import 'package:flutter/widgets.dart';
import 'package:wtf_rotary_dial/src/utils/utils.dart';

/// A class that contains the theme data for the RotaryDial.
///
/// This class is used to define the visual appearance of the rotary dial
/// widget. It contains several properties, such as [rotaryDialColor],
/// [spinnerColor], [dialColor], and [numberColor], that determine the color
/// of different parts of the RotaryDial.
///
/// To create an instance of this class, use the [RotaryDialThemeData]
/// constructor and pass in the desired values for the properties.
/// If a property is not specified, a default value will be used instead.
///
/// Example:
/// ```dart
/// RotaryDialThemeData(
///   rotaryDialColor: Colors.blue,
///   spinnerColor: Colors.white,
///   dialColor: Colors.grey,
///   numberColor: Colors.white,
///   pointColor: Colors.white,
///   margin: EdgeInsets.only(top: 16.0),
///   dialPadding: 12.0,
///   dialBorderRadius: 30.0,
/// )
/// ```
@immutable
class RotaryDialThemeData {
  /// Creates a [RotaryDialThemeData] object.
  ///
  /// If a property is not specified, a default value will be used instead.
  ///
  /// * [rotaryDialColor] - The background color of the rotary dial.
  /// * [spinnerColor] - The color of the spinner that appears when the rotary
  /// dial is tapped.
  /// * [dialColor] - The color of the dial that contains the numbers and the
  /// point.
  /// * [numberColor] - The color of the numbers on the dial.
  /// * [margin] - The margin around the rotary dial.
  /// * [dialBorderRadius] - The radius of the rotary dial's border.
  factory RotaryDialThemeData({
    // Assign default values to the properties that were not specified.
    Color? rotaryDialColor,
    Color? spinnerColor,
    Color? dialColor,
    Color? numberColor,
    EdgeInsets? margin,
    double? dialBorderRadius,
  }) {
    rotaryDialColor ??= RotaryColors.mainColorDark;
    spinnerColor ??= RotaryColors.white;
    dialColor ??= RotaryColors.mainColor;
    numberColor ??= RotaryColors.white;
    margin ??= const EdgeInsets.only(
      left: RotaryDimensions.large,
      right: RotaryDimensions.large,
    );
    dialBorderRadius ??= RotaryDimensions.dialNumberRadius;

    // Return a new instance of this class with the specified values.
    return RotaryDialThemeData._defaultTheme(
      rotaryDialColor: rotaryDialColor,
      spinnerColor: spinnerColor,
      dialColor: dialColor,
      numberColor: numberColor,
      margin: margin,
      dialBorderRadius: dialBorderRadius,
    );
  }

  /// The background color of the rotary dial.
  /// Defaults to [RotaryColors.mainColorDark].
  final Color rotaryDialColor;

  ///The color of the spinner that appears when the dial is rotated.
  ///Defaults to [RotaryColors.white].
  final Color spinnerColor;

  ///The color of the dial numbers.
  ///Defaults to [RotaryColors.mainColor].
  final Color dialColor;

  ///The color of the selected dial number.
  ///Defaults to [RotaryColors.white].
  final Color numberColor;

  /// The margin around the rotary dial.
  /// Defaults to [EdgeInsets.only(
  ///  left: [RotaryDimensions.large],
  ///  right: [RotaryDimensions.large],
  /// )].
  final EdgeInsets margin;

  /// The border radius of the dial numbers.
  /// Defaults to [RotaryDimensions.dialNumberRadius].
  final double dialBorderRadius;

  /// Creates a default [RotaryDialThemeData] instance with the given values.
  ///
  /// If a value is not specified, it will default to a standard value.
  const RotaryDialThemeData._defaultTheme({
    required this.rotaryDialColor,
    required this.spinnerColor,
    required this.dialColor,
    required this.numberColor,
    required this.margin,
    required this.dialBorderRadius,
  });
}
