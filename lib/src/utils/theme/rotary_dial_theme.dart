import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wtf_rotary_dial/src/utils/theme/rotary_dial_theme_data.dart';

/// A widget that applies a rotary dial theme to its child widget subtree.
///
/// The `RotaryDialTheme` widget applies the given [data] to its
/// [child] widget subtree. If a widget in the subtree does not have
/// its own [RotaryDialTheme] data, then the widget will inherit its
/// ancestor's data.
///
/// The [data] parameter must not be null.
///
/// To obtain the current theme's data, use [RotaryDialTheme.of]. To
/// rebuild src when the theme changes, pass a unique [Key] to the
/// [RotaryDialTheme] constructor or use a [Builder] widget.
///
/// Example:
///
/// ```dart
/// RotaryDialTheme(
///   data: RotaryDialThemeData(
///     dialColor: Colors.blue,
///     spinnerColor: Colors.grey,
///   ),
///   child: RotaryDial(...),
/// )
/// ```
class RotaryDialTheme extends StatelessWidget {
  /// Creates a widget that applies a rotary dial theme to its child widget
  /// subtree.
  ///
  /// The [data] parameter must not be null.
  const RotaryDialTheme({
    required this.child,
    required this.data,
    super.key,
  });

  /// The subtree to apply the theme to.
  final Widget child;

  /// The theme data to apply to the subtree.
  final RotaryDialThemeData data;

  /// Returns the current rotary dial theme data, as inherited from
  /// the nearest ancestor [RotaryDialTheme] widget that provides a theme.
  ///
  /// If there is no [RotaryDialTheme] widget in the tree, the method
  /// will return the default theme data [RotaryDialThemeData].
  ///
  /// Example:
  ///
  /// ```dart
  /// final themeData = RotaryDialTheme.of(context);
  /// ```
  static RotaryDialThemeData of(BuildContext context) {
    final inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedRotaryDialTheme>();
    final theme = inheritedTheme?.theme.data;
    return theme ?? RotaryDialThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedRotaryDialTheme(
      theme: this,
      child: child,
    );
  }
}

/// An inherited widget that provides the [RotaryDialThemeData] to
/// its descendants.
class _InheritedRotaryDialTheme extends InheritedTheme {
  /// Creates an [_InheritedRotaryDialTheme] widget.
  const _InheritedRotaryDialTheme({
    required this.theme,
    required super.child,
  });

  /// The [RotaryDialThemeData] of this widget.
  final RotaryDialTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return RotaryDialTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedRotaryDialTheme old) =>
      theme.data != old.theme.data;
}
