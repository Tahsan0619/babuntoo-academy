import 'package:flutter/material.dart';

// App-wide color and style constants: now context-aware for dark mode!
class AppColors {
  static Color primary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.cyan.shade400
          : const Color(0xFF4A6FA5);

  static Color secondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.teal
          : const Color(0xFF6D8B74);

  static Color accent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.orangeAccent.shade200
          : const Color(0xFFD6A77A);

  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF18191A)
          : const Color(0xFFF5F7FA);

  static Color buttonBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.cyan.shade700
          : const Color(0xFF8FA8C8);

  static Color buttonFg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : const Color(0xFF2F3E56);

  static Color mainText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : const Color(0xFF394248);

  /// Improved subtitle for better contrast in dark mode!
  static Color subtitleText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white70 // much better for dark backgrounds than grey.shade300
          : const Color(0xFF6E7D89);

  static Color cardShadow(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withOpacity(0.5)
          : const Color(0xFFA1B0C1);

  // Aliases for easier migration in your codebase
  static Color textPrimary(BuildContext context) => mainText(context);
  static Color textSecondary(BuildContext context) => subtitleText(context);

// (Optional) Dev/Debug helper for text contrast:
// static void debugContrast(BuildContext context) {
//   final bg = AppColors.background(context);
//   final mainText = AppColors.mainText(context);
//   debugPrint('Contrast ratio: ${_calcContrast(bg, mainText)}');
// }
// static double _calcContrast(Color bg, Color fg) {
//   final l1 = bg.computeLuminance() + 0.05;
//   final l2 = fg.computeLuminance() + 0.05;
//   return l1 > l2 ? l1 / l2 : l2 / l1;
// }
}

class AppTextStyles {
  static TextStyle appBar(BuildContext context) => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.primary(context),
    letterSpacing: 0.5,
  );
  static TextStyle headline(BuildContext context) => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.mainText(context),
    letterSpacing: 0.2,
  );
  static TextStyle body(BuildContext context) => TextStyle(
    fontSize: 16,
    color: AppColors.mainText(context),
    fontWeight: FontWeight.normal,
  );
  static TextStyle subtitle(BuildContext context) => TextStyle(
    fontSize: 14,
    color: AppColors.subtitleText(context),
    fontWeight: FontWeight.w400,
  );
}

class AppConstants {
  static const appName = "BabunToo Academy";
  static const menuGridCrossAxisCount = 2;
  static const defaultPadding = 16.0;
  static const pagePadding = EdgeInsets.all(16.0);
  static const heroTagPrefix = "hero_";
}
