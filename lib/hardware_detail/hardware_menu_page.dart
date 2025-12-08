import 'package:flutter/material.dart';
import 'mouse_detail_page.dart';
import 'cpu_detail_page.dart';
import 'gpu_detail_page.dart';
// Other detail page imports (unlocked ones don't need to exist for unfinished pages)

class MenuOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? page; // null if locked
  final bool isLocked;

  const MenuOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.page,
    this.isLocked = false,
  });
}

class HardwareMenuPage extends StatelessWidget {
  const HardwareMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MenuOption> options = [
      MenuOption(
        icon: Icons.mouse,
        title: 'Mouse',
        subtitle: 'Explore types and components of computer mouse',
        page: const MouseDetailPage(),
      ),
      MenuOption(
        icon: Icons.memory,
        title: 'CPU',
        subtitle: 'Explore types and components of CPU',
        page: const CpuDetailPage(),
      ),
      MenuOption(
        icon: Icons.developer_board,
        title: 'GPU',
        subtitle: 'Explore types and components of GPU',
        page: const GpuDetailPage(),
      ),
      MenuOption(
        icon: Icons.keyboard,
        title: 'Keyboard',
        subtitle: 'Explore types and components of computer keyboard',
        isLocked: true,
      ),
      MenuOption(
        icon: Icons.power,
        title: 'PSU',
        subtitle: 'Explore types and components of Power Supply Unit',
        isLocked: true,
      ),
      MenuOption(
        icon: Icons.smartphone,
        title: 'Mobile RAM',
        subtitle: 'Explore mobile device RAM types and components',
        isLocked: true,
      ),
      MenuOption(
        icon: Icons.laptop,
        title: 'Laptop RAM',
        subtitle: 'Explore laptop RAM types and components',
        isLocked: true,
      ),
      MenuOption(
        icon: Icons.memory,
        title: 'RAM',
        subtitle: 'Explore desktop RAM types and components',
        isLocked: true,
      ),
      MenuOption(
        icon: Icons.archive,
        title: 'ROM',
        subtitle: 'Explore types and components of Read-Only Memory',
        isLocked: true,
      ),
      MenuOption(
        icon: Icons.computer,
        title: 'Motherboard',
        subtitle: 'Explore motherboard types and components',
        isLocked: true,
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Hardware Menu'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          final opt = options[index];
          return Card(
            child: ListTile(
              leading: Icon(
                opt.icon,
                color: opt.isLocked
                    ? Colors.grey
                    : Theme.of(context).colorScheme.primary,
              ),
              title: Text(opt.title),
              subtitle: Text(opt.subtitle),
              trailing: opt.isLocked
                  ? const Icon(Icons.lock, color: Colors.grey)
                  : const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                if (opt.isLocked || opt.page == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("⏳ Stay tuned! This section is coming soon."),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => opt.page!),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
