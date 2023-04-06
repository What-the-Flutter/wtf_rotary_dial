import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:wtf_rotary_dial/src/utils/utils.dart';

/// A custom painter that draws the background of the rotary dial.
class RotaryBackgroundPainter extends CustomPainter {
  /// Creates a [RotaryBackgroundPainter].
  ///
  /// The [rotaryBackgroundColor] parameter specifies the color of the
  /// background.
  const RotaryBackgroundPainter({
    required this.rotaryBackgroundColor,
  });

  /// The color of the background.
  final Color rotaryBackgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    // The width of the ring that makes up the background.
    const ringWidth = RotaryDimensions.rotaryRingWidth;

    // The paint object used to draw the background.
    final paint = Paint()
      ..color = rotaryBackgroundColor
      ..strokeWidth = ringWidth
      ..style = PaintingStyle.stroke;

    // Draw a complete circle that makes up the background.
    canvas.drawArc(
      Rect.fromCircle(
        center: size.centerOffset,
        radius: size.width / 2 - ringWidth / 2,
      ),
      0,
      math.pi * 2.0,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(RotaryBackgroundPainter oldDelegate) =>
      rotaryBackgroundColor.value != oldDelegate.rotaryBackgroundColor.value;
}
