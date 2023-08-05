import 'dart:ui';

class Palette {
  final Color _sixtyPercentLightMode = const Color(0xFFFFFDED);
  final Color _thirtyPercentLightMode = const Color(0xFF696047);
  final Color _tenPercentLightMode = const Color(0xFFE39D3F);

  final Color _sixtyPercentDarkMode = const Color(0xFF494738);
  final Color _thirtyPercentDarkMode = const Color(0xFFD3D1B5);
  final Color _tenPercentDarkMode = const Color(0xFFEFEA89);

  Color getSixtyPercent(bool isDarkMode) {
    if (isDarkMode) {
      return _sixtyPercentDarkMode;
    } else {
      return _sixtyPercentLightMode;
    }
  }

  Color getThirtyPercent(bool isDarkMode) {
    if (isDarkMode) {
      return _thirtyPercentDarkMode;
    } else {
      return _thirtyPercentLightMode;
    }
  }

  Color getTenPercent(bool isDarkMode) {
    if (isDarkMode) {
      return _tenPercentDarkMode;
    } else {
      return _tenPercentLightMode;
    }
  }
}
