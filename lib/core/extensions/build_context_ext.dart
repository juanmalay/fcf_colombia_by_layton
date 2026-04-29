import 'package:flutter/material.dart';

/// Extensiones útiles para BuildContext
extension BuildContextX on BuildContext {
  /// Media Query shortcuts
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  double get screenAspectRatio => screenSize.aspectRatio;

  /// Padding
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
  double get topPadding => viewPadding.top;
  double get bottomPadding => viewPadding.bottom;

  /// Orientation
  bool get isPortrait => screenSize.height > screenWidth;
  bool get isLandscape => !isPortrait;

  /// Theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  /// Navigation
  void push(Widget page) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void pop<T>([T? result]) {
    Navigator.pop(this, result);
  }

  /// Snackbar
  void showSnackBar(String message, {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), duration: duration),
    );
  }

  /// Dialog
  Future<T?> showCustomDialog<T>({required Widget child}) {
    return showDialog<T>(context: this, builder: (_) => child);
  }

  /// Bottom Sheet
  Future<T?> showBottomSheet<T>({required Widget child}) {
    return showModalBottomSheet<T>(context: this, builder: (_) => child);
  }
}
