import 'package:flutter/material.dart';
import 'package:wtf_rotary_dial/src/utils/theme/rotary_dial_theme.dart';
import 'package:wtf_rotary_dial/src/utils/utils.dart';

/// A widget that displays a dial number.
class DialNumber extends StatelessWidget {
  /// Creates a dial number widget.
  ///
  /// The [number] parameter is required and represents the number
  /// to be displayed.
  const DialNumber({
    required this.number,
    super.key,
  });

  /// The number to be displayed.
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: RotaryDimensions.dialNumberRadius * 2,
      width: RotaryDimensions.dialNumberRadius * 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: RotaryDialTheme.of(context).dialColor,
        borderRadius: BorderRadius.all(
          Radius.circular(RotaryDialTheme.of(context).dialBorderRadius),
        ),
      ),
      child: Text(
        '$number',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: RotaryDialTheme.of(context).numberColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
