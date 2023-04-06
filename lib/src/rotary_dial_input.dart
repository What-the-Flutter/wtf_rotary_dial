import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:wtf_rotary_dial/src/dial_number.dart';
import 'package:wtf_rotary_dial/src/painter/rotary_background_painter.dart';
import 'package:wtf_rotary_dial/src/painter/rotary_foreground_painter.dart';
import 'package:wtf_rotary_dial/src/utils/theme/rotary_dial_theme.dart';
import 'package:wtf_rotary_dial/src/utils/utils.dart';

/// A rotary dial widget that allows users to enter digits
/// by rotating a dial.
///
/// The widget takes in an [AnimationController] which can be used to
/// control the animation of the rotary dial. It also requires a
/// [ValueSetter] callback that will be called when a digit is selected,
/// [Duration] for the animation duration and a [Curve] for the animation curve.
///
/// See also:
///
///  * [RotaryBackgroundPainter].
///  * [RotaryForegroundPainter].
class RotaryDialInput extends StatefulWidget {
  const RotaryDialInput({
    required this.onDigitSelected,
    required this.duration,
    required this.curve,
    super.key,
  });

  /// A [ValueSetter] callback that will be called when a digit is selected.
  final ValueSetter<int> onDigitSelected;

  /// A [Duration] for the animation duration.
  final Duration duration;

  /// A [Curve] for the animation curve.
  final Curve curve;

  @override
  State<RotaryDialInput> createState() => _RotaryDialInputState();
}

/// The state for the `RotaryDialInput` widget.
class _RotaryDialInputState extends State<RotaryDialInput>
    with TickerProviderStateMixin {
  /// The animation controller for the rotary dial.
  ///
  /// Responsible for spinner rotation animation.
  late final AnimationController _dialController;

  /// The spinner rotation animation.
  late Animation<double> _rotationAnimation;

  /// The current drag offset of the rotary dial.
  var _currentDragOffset = Offset.zero;

  /// The starting angle offset of the rotary dial.
  var _startAngleOffset = 0.0;

  /// Determines whether or not the rotary dial is currently animating.
  bool get _isAnimate => _dialController.isAnimating;

  @override
  void initState() {
    super.initState();

    // Initializes an AnimationController to control the rotation animation
    // of the rotary dial.
    _dialController = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..addListener(
        () => setState(() => _startAngleOffset = _rotationAnimation.value),
      );
  }

  @override
  void dispose() {
    _dialController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: size(width),
              painter: RotaryBackgroundPainter(
                rotaryBackgroundColor:
                    RotaryDialTheme.of(context).rotaryDialColor,
              ),
            ),
            for (var i = 0; i < RotaryLabels.numbers.length; i++)
              Transform.translate(
                offset: Offset.fromDirection(
                  (i + 1) * -math.pi / 6,
                  dialNumberDistanceFromCenter(width),
                ),
                child: DialNumber(number: RotaryLabels.numbers[i]),
              ),
            GestureDetector(
              onPanStart: (details) => _onPanStart(
                details,
                centerOffset(size(width)),
              ),
              onPanUpdate: (details) => _onPanUpdate(
                details,
                centerOffset(size(width)),
              ),
              onPanEnd: _onPanEnd,
              child: CustomPaint(
                size: size(width),
                painter: RotaryForegroundPainter(
                  spinnerColor: RotaryDialTheme.of(context).spinnerColor,
                  numberRadiusFromCenter: dialNumberDistanceFromCenter(width),
                  startAngleOffset: _startAngleOffset,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  TickerFuture _rotateDialToStart() {
    // Define a Tween animation to rotate the dial from its current angle
    // to the start angle.
    _rotationAnimation = Tween<double>(
      begin: _startAngleOffset,
      end: RotaryDimensions.none,
    ).animate(
      // Apply a curve to the animation.
      CurvedAnimation(parent: _dialController, curve: widget.curve),
    );

    // Reset the controller to its initial state.
    _dialController.reset();

    // Start the animation and return the future.
    return _dialController.forward();
  }

  void _onPanStart(DragStartDetails details, Offset centerOffset) {
    // If the dial is not currently being animated, calculate the initial
    // drag offset.
    if (!_isAnimate) _currentDragOffset = details.localPosition - centerOffset;
  }

  void _onPanUpdate(DragUpdateDetails details, Offset centerOffset) {
    // If the dial is currently being animated, return early.
    if (_isAnimate) return;

    // Calculate the previous and current drag offsets.
    final previousOffset = _currentDragOffset;
    _currentDragOffset += details.delta;

    // Calculate the current and previous drag directions.
    final currentDirection = _currentDragOffset.direction;
    final previousDirection = previousOffset.direction;

    // If the current and previous drag directions have opposite signs,
    // return early.
    if (currentDirection * previousDirection < 0.0) return;

    // Calculate the new angle based on the current and previous
    // drag directions.
    final angle = _startAngleOffset + currentDirection - previousDirection;

    // If the new angle is outside the valid range, return early.
    if (angle < 0.0 || angle >= RotaryDimensions.maxRotaryRingAngle) return;

    // Update the start angle offset to the new angle.
    setState(() => _startAngleOffset = angle);
  }

  void _onPanEnd(DragEndDetails details) {
    // If the dial is currently being animated, return early.
    if (_isAnimate) return;

    // Calculate the offset of the first dial number based on the start
    // angle offset.
    final offset =
        RotaryDimensions.firstDialNumberPosition * (_startAngleOffset - 1);

    // If the offset is less than -3.14.../ 12 degrees, rotate the dial
    // back to the start.
    if (offset < -math.pi / 12) {
      _rotateDialToStart();
      return;
    }

    // Calculate the index of the selected digit based on the offset.
    final numberIndex = ((offset * 180 / math.pi).abs() / 30).round();
    // Rotate the dial back to the start, and call the onValidatePasscode
    // callback after the animation finishes.
    widget.onDigitSelected(numberIndex == 9 ? 0 : numberIndex + 1);

    // Rotary dial will return to start position with animation.
    _rotateDialToStart();
  }

  /// Computes the width of the rotary dial input based on the given size.
  double rotaryDialInputWidth(double size) => size;

  /// Computes the size of the rotary dial input based on the given width.
  Size size(double width) => Size(width, width);

  /// Computes the offset of the center of the rotary dial input based
  /// on its size.
  Offset centerOffset(Size size) => size.centerOffset;

  /// Computes the distance between a dial number and the center of the rotary
  /// dial input based on its width and padding values.
  double dialNumberDistanceFromCenter(double width) =>
      width / 2 -
      RotaryDimensions.large -
      RotaryDimensions.rotaryRingPadding * 2 -
      RotaryDimensions.dialNumberPadding * 2;
}
