import 'package:flutter/material.dart';
import 'package:wtf_rotary_dial/src/rotary_dial_input.dart';
import 'package:wtf_rotary_dial/src/utils/theme/rotary_dial_theme.dart';
import 'package:wtf_rotary_dial/src/utils/theme/rotary_dial_theme_data.dart';
import 'package:wtf_rotary_dial/src/utils/utils.dart';

/// A main [RotaryDial] widget that displays a rotary dial interface.
class RotaryDial extends StatelessWidget {
  /// Creates a rotary dial widget.
  ///
  /// The [rotaryDialThemeData] parameter allows the user to specify a custom
  /// theme for the rotary dial interface.
  ///
  /// The [duration] parameter controls the duration of animations used in the
  /// rotary dial interface.
  ///
  /// The [curve] parameter controls the curve used in the animations.
  const RotaryDial({
    required this.onDigitSelected,
    this.rotaryDialThemeData,
    this.duration = RotaryDurations.extraLarge,
    this.curve = Curves.decelerate,
    super.key,
  });

  /// A [ValueSetter] callback that will be called when a digit is selected.
  /// It takes an integer value as an argument, which is the number entered
  /// into the rotary dial.
  final ValueSetter<int> onDigitSelected;

  /// Allows the user to specify a custom theme for the rotary dial interface.
  final RotaryDialThemeData? rotaryDialThemeData;

  /// Controls the duration of animations used in the rotary dial interface.
  final Duration duration;

  /// Controls the curve used in the animations.
  final Curve curve;

  /// Builds the widget tree for [RotaryDial].
  ///
  /// The [RotaryDialTheme]
  /// widget is used to wrap the child widget tree and provide them with the
  /// [RotaryDialThemeData] theme values.
  ///
  /// The [duration] and [curve] arguments
  /// passed to the constructor are used to configure the child src.
  @override
  Widget build(BuildContext context) {
    return RotaryDialTheme(
      data: rotaryDialThemeData ?? RotaryDialThemeData(),
      child: Builder(
        builder: (context) {
          return Padding(
            padding: RotaryDialTheme.of(context).margin,
            child: RotaryDialInput(
              onDigitSelected: onDigitSelected,
              curve: curve,
              duration: duration,
            ),
          );
        },
      ),
    );
  }
}
