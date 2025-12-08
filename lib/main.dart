import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/theme_provider.dart';
import '../utils/constants.dart';

import 'login_page.dart';
import 'signup_page.dart';
import 'home_page.dart';
import 'splash_screen.dart';
import 'latest_inventions_page.dart';
import 'hardware_page.dart';
import 'software_page.dart';
import 'scientists_timeline_page.dart';
import 'programming_languages_page.dart';
import 'learn_programming_menu_page.dart';
import 'contact_us_page.dart';
import '../challenge/challenge_page.dart';
import '../playground/playground_page.dart';
import '../interactive learning/interactive_learning_menu_page.dart';
import '../education_models_list_page.dart';
import 'code_playground_screen.dart';
import 'education/features/models/models_list_page.dart';
import 'education/features/models/detail/blooms_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await Future.delayed(Duration.zero);

  runApp(
    ChangeNotifierProvider<ThemeProvider>.value(
      value: themeProvider,
      child: const BabuntooApp(),
    ),
  );
}

class BabuntooApp extends StatelessWidget {
  const BabuntooApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF5F7FA),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF4A6FA5),
              iconTheme: IconThemeData(color: Color(0xFF4A6FA5)),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.white),
            ),
          ),
          themeMode: themeProvider.themeMode,
          initialRoute: '/splash',
          routes: {
            '/login': (context) => LoginPage(),
            '/signup': (context) => SignupPage(),
            '/home': (context) => HomePage(),
            '/splash': (context) => const SplashScreen(),
            '/latestInventions': (context) => const LatestInventionsPage(),
            '/hardware': (context) => HardwarePage(),
            '/software': (context) => SoftwarePage(),
            '/scientistsTimeline': (context) => ScientistsTimelinePage(),
            '/programmingLanguages': (context) => ProgrammingLanguagesPage(),
            '/learnProgrammingMenu': (context) =>
                const LearnProgrammingMenuPage(),
            '/contactUs': (context) => const ContactUsPage(),
            '/challenge': (context) => const ChallengePage(),
            '/playground': (context) => const CodePlaygroundScreen(),
            '/interactiveLearningMenu': (context) =>
                InteractiveLearningMenuPage(),
            // List page for education models only:
            '/educationModels': (context) => const ModelsListPage(),
            '/models/blooms': (context) => const BloomsDetailPage(),
          },
        );
      },
    );
  }
}
