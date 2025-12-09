import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../utils/theme_provider.dart';

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
import '../games/games_menu_page.dart';
import '../hardware_detail/hardware_menu_page.dart';
import '../education_models_list_page.dart';
import 'code_playground_screen.dart';
import 'education/features/models/models_list_page.dart';
import 'login_page_with_api.dart';

class MenuOption {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget destinationPage;

  const MenuOption(this.icon, this.title, this.subtitle, this.destinationPage);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _welcomeShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_welcomeShown) {
      _showWelcomeDialog();
      _welcomeShown = true;
    }
  }

  Future<void> _showWelcomeDialog() async {
    final info = await PackageInfo.fromPlatform();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Welcome to BabunToo Academy!'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('App Version: 1.07Early (Build 1.087${info.buildNumber})'),
              const SizedBox(height: 12),
              const Text(
                "What is present:(1.01)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                  "• Explore and learn about computer hardware and software."),
              const Text(
                  "• Learn C and Python interactively—from basics to advanced (pre-OOP/DSA)."),
              const Text(
                  "• Discover legendary scientists with detailed timelines."),
              const Text("• Contact the creator or get support anytime."),
              const Text("• Clean, modern, student-friendly experience!"),
              const Text(
                "What is new:(1.02)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text("• Fixed Text size in menu"),
              const Text("• Links working in software page"),
              const Text(
                "What is new:(1.03)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text("• Challenge section"),
              const Text("• Playground Section"),
              const Text("• Latest Invention Section"),
              const Text("• 35% more responsive UI optimization"),
              const Text(
                "What is new:(1.04)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text("• Full change in all the UI sections"),
              const Text("• New improved challenge section"),
              const Text(
                  "• Upto 60% database increased across all the sections"),
              const Text("• Fixed 3 bugs and 17% more stable"),
              const Text(
                "What is new:(1.05)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text("• New Splash screen"),
              const Text("• New Interactive Learning section"),
              const Text("• New Updated UI"),
              const Text("• Dark Mode/Light Mode feature"),
              const Text("• Fixed 2 bugs and 9% more stable"),
              const Text(
                "What is new:(1.05E)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text("• Fixed Dark Mode feature"),
              const Text("• Fixed challenge section bugs and 8% more stable"),
              const Text("• Search button added onto the software section"),
              const Text(
                "What is new:(1.06)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text("• New UI in Scientist Timeline"),
              const Text("• New game section"),
              const Text("• New icons in software section"),
              const Text("• fixed dark mode issues by 90%"),
              const Text(
                "What is new:(1.06E)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text("• Fixed Scientist Timeline bugs"),
              const Text("• Full C language ready in interactive sections"),
              const Text("• Atleast 10% more stable"),
              const Text("• optimized upto - 8GB(physical) ram devices"),
              const Text(
                "What is new:(1.07Early)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text("• Fixed 1 small bug"),
              const Text(
                  "• Full remake of Hardware section(still in progress)"),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Get Started")),
        ],
      ),
    );
  }

  Future<void> _showUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName') ?? 'Guest User';
    final userPhone = prefs.getString('userPhone') ?? 'Not available';
    final isSubscribed = prefs.getBool('userSubscribed') ?? false;

    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('User Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                child: Text(
                  userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Name: $userName',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Phone: $userPhone',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Subscription: '),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSubscribed ? Colors.green : Colors.orange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isSubscribed ? 'Active' : 'Inactive',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  final List<MenuOption> options = [
    MenuOption(Icons.memory, "PC Hardware", "", HardwareMenuPage()),
    MenuOption(Icons.desktop_windows, "PC Software", "", SoftwarePage()),
    MenuOption(
        Icons.timeline, "Scientists Timeline", "", ScientistsTimelinePage()),
    MenuOption(Icons.play_circle_fill, "Interactive Learning", "",
        InteractiveLearningMenuPage()),
    MenuOption(Icons.developer_mode, "Programming Projects", "",
        ProgrammingLanguagesPage()),
    MenuOption(Icons.videogame_asset, "Games", "", const GamesMenuPage()),
    MenuOption(
        Icons.school, "Education Models", "", const ModelsListPage()),
    MenuOption(Icons.question_answer, "Challenge", "", ChallengePage()),
    MenuOption(Icons.code, "Playground", "", const CodePlaygroundScreen()),
    MenuOption(
        Icons.lightbulb, "Latest Inventions", "", LatestInventionsPage()),
    MenuOption(Icons.contact_mail, "Contact Me", "", ContactUsPage()),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;
    final double iconSize = isTablet ? 48.0 : 32.0;
    final double textSize = isTablet ? 20.0 : 16.0;

    final List<MenuOption> mainOptions = options.sublist(0, options.length - 1);
    final MenuOption contactOption = options.last;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        title: Text(
          AppConstants.appName,
          style: AppTextStyles.appBar(context),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              final isDark = themeProvider.themeMode == ThemeMode.dark;
              return Row(
                children: [
                  Text(
                    isDark ? "Dark Mode" : "Light Mode",
                    style: TextStyle(
                      color: isDark ? Colors.white : AppColors.primary(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4),
                  IconButton(
                    icon: Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      color: isDark ? Colors.white : AppColors.primary(context),
                    ),
                    tooltip:
                        isDark ? "Switch to Light Mode" : "Switch to Dark Mode",
                    onPressed: themeProvider.toggleTheme,
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'logout') {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                        if (mounted) {
                          Navigator.of(context).pushReplacementNamed('/login');
                        }
                      } else if (value == 'profile') {
                        _showUserProfile();
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'profile',
                        child: Row(
                          children: [
                            Icon(Icons.person, size: 20),
                            SizedBox(width: 8),
                            Text('Profile'),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem<String>(
                        value: 'logout',
                        child: Row(
                          children: [
                            Icon(Icons.logout, size: 20, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Logout', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: mainOptions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.3,
                ),
                itemBuilder: (context, idx) {
                  final opt = mainOptions[idx];
                  return Material(
                    color: AppColors.background(context),
                    borderRadius: BorderRadius.circular(16),
                    elevation: 2,
                    shadowColor:
                        AppColors.cardShadow(context).withOpacity(0.13),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => opt.destinationPage),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primary(context).withOpacity(0.07),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.cardShadow(context)
                                  .withOpacity(0.06),
                              blurRadius: 6,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(opt.icon,
                                color: AppColors.primary(context),
                                size: iconSize),
                            const SizedBox(height: 14),
                            Text(
                              opt.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: textSize,
                                color: AppColors.mainText(context),
                              ),
                            ),
                            Container(
                              height: 3,
                              width: 26,
                              margin: const EdgeInsets.only(top: 7, bottom: 3),
                              decoration: BoxDecoration(
                                color: AppColors.accent(context),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            if (opt.subtitle != null &&
                                opt.subtitle!.isNotEmpty)
                              Text(
                                opt.subtitle!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: textSize - 3,
                                  color: AppColors.subtitleText(context),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Centralized Contact Me button
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 12.0),
              child: Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(isTablet ? 260 : 200, isTablet ? 62 : 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    backgroundColor: AppColors.primary(context),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: AppColors.primary(context).withOpacity(0.18),
                  ),
                  icon: const Icon(Icons.contact_mail, size: 28),
                  label: const Text(
                    "Contact Me",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => contactOption.destinationPage),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
