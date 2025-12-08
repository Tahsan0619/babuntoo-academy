import 'package:flutter/material.dart';

import '../features/models/models_list_page.dart';
import '../features/models/detail/blooms_detail_page.dart';
import '../features/quiz/quiz_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String models = '/models';
  static const String quiz = '/quiz';

  // Per-model custom detail routes
  static const String blooms = '/models/blooms';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
      case models:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ModelsListPage(),
        );
      case quiz:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const QuizPage(),
        );
      case blooms:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const BloomsDetailPage(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
