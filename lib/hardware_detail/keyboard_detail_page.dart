import 'package:flutter/material.dart';
import '../models/hardware_model.dart';
import '../models/hardware_component_model.dart';
import '../widgets/hardware_basic_info_section.dart';
import '../widgets/hardware_components_section.dart';
import '../widgets/hardware_working_section.dart';

class KeyboardDetailPage extends StatelessWidget {
  static const routeName = '/keyboard-detail';

  const KeyboardDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keyboardModel = HardwareModel(
      id: 'keyboard1',
      name: 'Computer Keyboard',
      logoAssetPath: 'assets/images/keyboard_logo.png',
      basicInfo: '''A keyboard is an input device consisting of a set of keys which allows users to input text, numbers, and commands into a computer or other devices. Modern keyboards come in various layouts and types, including mechanical and membrane switches, ergonomic designs, and wireless connectivity.''',
      inventorName: 'Christopher Latham Sholes',
      inventorPhotoAssetPath: 'assets/images/christopher_sholes.png',
      yearInvented: 1868,
      origin: '''The keyboard concept was originally designed by Christopher Latham Sholes who developed the QWERTY layout for typewriters. This layout remains the standard for most computer keyboards today.''',
      evolution: '''Over the years, keyboards have evolved from mechanical typewriters to electronic devices with various technologies introduced to improve usability, efficiency, and comfort.

Below is a table summarizing major keyboard milestones:
''',
      typeVariants: [
        TypeVariant(imageAssetPath: 'assets/images/keyboard_mechanical.png', description: 'Mechanical'),
        TypeVariant(imageAssetPath: 'assets/images/keyboard_membrane.png', description: 'Membrane'),
        TypeVariant(imageAssetPath: 'assets/images/keyboard_wireless.png', description: 'Wireless'),
        TypeVariant(imageAssetPath: 'assets/images/keyboard_ergonomic.png', description: 'Ergonomic'),
        TypeVariant(imageAssetPath: 'assets/images/keyboard_gaming.png', description: 'Gaming'),
        TypeVariant(imageAssetPath: 'assets/images/keyboard_compact.png', description: 'Compact'),
      ],
      components: [
        HardwareComponent(name: 'Keys', imageAssetPath: 'assets/images/keyboard_keys.png', shortDetails: 'Pressable buttons that register user input.'),
        HardwareComponent(name: 'PCB', imageAssetPath: 'assets/images/keyboard_pcb.png', shortDetails: 'Circuit board that connects keys to the controller.'),
        HardwareComponent(name: 'Case', imageAssetPath: 'assets/images/keyboard_case.png', shortDetails: 'The outer shell protecting components.'),
        HardwareComponent(name: 'Controller', imageAssetPath: 'assets/images/keyboard_controller.png', shortDetails: 'Interprets input from keys and sends signals to the computer.'),
        HardwareComponent(name: 'Cable or Wireless Module', imageAssetPath: 'assets/images/keyboard_wireless_module.png', shortDetails: 'Connectivity components for wired or wireless communication.'),
      ],
      workingFlowAssetPath: 'assets/images/keyboard_flow_chart.png',
      technologiesUsed: [
        'Mechanical and membrane key switches',
        'USB and Bluetooth connectivity',
        'Backlighting and RGB lighting',
        'Onboard memory for macros and profiles',
        'Anti-ghosting and n-key rollover technologies',
      ],
      connectivityAndCompatibility: '''USB, Bluetooth, and proprietary wireless; compatible with Windows, macOS, Linux, and some mobile devices.''',
      trivia: '''1. The QWERTY layout was designed to slow typing to reduce mechanical jams.
2. The first computer keyboard was adapted from a typewriter.
3. Mechanical keyboards feature individual switches under each key.
4. Gaming keyboards often have customizable RGB lighting and programmable keys.
5. Ergonomic keyboards help reduce hand strain over long periods.
6. Some compact keyboards omit the numeric keypad for portability.
7. Wireless keyboards eliminate clutter but require batteries or charging.
8. Keyboards can have millions of keypresses lifespan depending on switch type.
''',
    );

    return Scaffold(
      appBar: AppBar(title: Text(keyboardModel.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HardwareBasicInfoSection(model: keyboardModel),
              Text("Evolution", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(keyboardModel.evolution, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 14),
              const KeyboardEvolutionTable(),
              const SizedBox(height: 24),
              HardwareComponentsSection(components: keyboardModel.components),
              const SizedBox(height: 24),
              HardwareWorkingSection(
                workingFlowAssetPath: keyboardModel.workingFlowAssetPath,
                technologiesUsed: keyboardModel.technologiesUsed,
                connectivityAndCompatibility: keyboardModel.connectivityAndCompatibility,
                trivia: keyboardModel.trivia,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KeyboardEvolutionTable extends StatelessWidget {
  const KeyboardEvolutionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline.withOpacity(0.5);
    final headerBgColor = theme.colorScheme.surfaceVariant;
    final headerTextColor = Colors.red;  // Red header text for visibility
    final cellTextColor = theme.colorScheme.onSurface;

    return Table(
      border: TableBorder.all(color: borderColor, width: 1),
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: headerBgColor),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Year', style: TextStyle(fontWeight: FontWeight.bold, color: headerTextColor)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold, color: headerTextColor)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold, color: headerTextColor)),
            ),
          ],
        ),
        _buildTableRow('1868', 'QWERTY Keyboard', 'First widely adopted keyboard layout for typewriters.', cellTextColor),
        _buildTableRow('1970s', 'Electric Keyboard', 'Introduction of electric keyboards with key switches.', cellTextColor),
        _buildTableRow('1980s', 'Computer Keyboard', 'Adapted for computers with additional function keys.', cellTextColor),
        _buildTableRow('1990s', 'Ergonomic Keyboard', 'Design improvements to reduce user strain.', cellTextColor),
        _buildTableRow('2000s', 'Wireless Keyboard', 'Bluetooth and RF wireless connectivity introduced.', cellTextColor),
        _buildTableRow('2010s', 'Mechanical Gaming Keyboard', 'Customizable switches and RGB backlighting popularized.', cellTextColor),
      ],
    );
  }

  TableRow _buildTableRow(String year, String type, String description, Color textColor) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(10.0), child: Text(year, style: TextStyle(color: textColor))),
        Padding(padding: const EdgeInsets.all(10.0), child: Text(type, style: TextStyle(color: textColor))),
        Padding(padding: const EdgeInsets.all(10.0), child: Text(description, style: TextStyle(color: textColor))),
      ],
    );
  }
}
