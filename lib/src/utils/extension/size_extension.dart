import 'dart:ui';

/// An extension on [Size] providing utility methods related to size
/// and positioning.
extension SizeX on Size {
  /// Returns the center point of this [Size] as an [Offset].
  Offset get centerOffset => Offset(width / 2, height / 2);
}
