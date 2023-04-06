import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:wtf_rotary_dial/src/utils/utils.dart';

/// A custom painter that draws the foreground of the rotary dial widget.
class RotaryForegroundPainter extends CustomPainter {
  /// Creates a new `RotaryDialForegroundPainter` with the given parameters.
  ///
  /// The [spinnerColor] parameter specifies the color of the spinner.
  ///
  /// The [numberRadiusFromCenter] parameter specifies the distance from the
  /// center of the dial to the numbers on the dial.
  ///
  /// The [startAngleOffset] parameter specifies the offset angle from which
  /// to start drawing the spinner.
  const RotaryForegroundPainter({
    required this.spinnerColor,
    required this.numberRadiusFromCenter,
    required this.startAngleOffset,
  });

  /// The color of the spinner.
  final Color spinnerColor;

  /// The distance from the center of the dial to the numbers on the dial.
  final double numberRadiusFromCenter;

  /// The offset angle from which to start drawing the spinner.
  final double startAngleOffset;

  @override
  void paint(Canvas canvas, Size size) {
    // Define constants used for drawing.
    const firstDialNumberPosition = RotaryDimensions.firstDialNumberPosition;
    const ringWidth = RotaryDimensions.rotaryRingWidth;

    // Define the paint object used for drawing.
    final angleOffset = startAngleOffset * firstDialNumberPosition;
    final paint = Paint()
      ..color = spinnerColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = ringWidth - RotaryDimensions.rotaryRingPadding
      ..style = PaintingStyle.stroke;

    // Draw the spinner.
    canvas
      ..saveLayer(Rect.largest, paint)
      ..drawArc(
        Rect.fromCircle(
          center: size.centerOffset,
          radius: size.width / 2 - ringWidth / 2,
        ),
        angleOffset + firstDialNumberPosition,
        RotaryDimensions.rotarySweepAngle,
        false,
        paint,
      );

    // Draw the numbers on the dial.
    for (var i = 0; i < 10; i++) {
      final offset = Offset.fromDirection(
        angleOffset + math.pi * (-30 - i * 30) / 180,
        numberRadiusFromCenter,
      );

      canvas.drawCircle(
        size.centerOffset + offset,
        RotaryDimensions.dialNumberRadius,
        Paint()..blendMode = BlendMode.clear,
      );
    }

    // Draw the progress indicator for the spinner.
    canvas
      ..drawCircle(
        size.centerOffset +
            Offset.fromDirection(math.pi / 6, numberRadiusFromCenter),
        ringWidth / 6,
        Paint()..color = spinnerColor,
      )
      ..restore();
  }

  @override
  bool shouldRepaint(RotaryForegroundPainter oldDelegate) =>
      oldDelegate.numberRadiusFromCenter != numberRadiusFromCenter &&
      oldDelegate.startAngleOffset != startAngleOffset;
}
