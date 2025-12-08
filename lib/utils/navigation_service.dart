import 'package:flutter/material.dart';

// Global navigation key for app-wide navigation without BuildContext.
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static Future<dynamic>? navigateTo(Widget page) {
    return navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static void goBack() {
    navigatorKey.currentState?.pop();
  }

  static Future<dynamic>? replaceWith(Widget page) {
    return navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }
}
