import 'package:flutter/material.dart';
import '../models/hardware_model.dart';
import '../models/hardware_component_model.dart';
import '../widgets/hardware_basic_info_section.dart';
import '../widgets/hardware_components_section.dart';
import '../widgets/hardware_working_section.dart';

class MobileRamDetailPage extends StatelessWidget {
  static const routeName = '/mobile-ram-detail';

  const MobileRamDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mobileRamModel = HardwareModel(
      id: 'mobile_ram1',
      name: 'Mobile RAM',
      logoAssetPath: 'assets/images/mobile_ram_logo.png',
      basicInfo:
      '''Mobile RAM is specialized volatile memory used in smartphones and tablets, optimized for power efficiency and compact size while providing fast multitasking capabilities.''',
      inventorName: 'Various manufacturers (e.g., Samsung, SK Hynix)',
      inventorPhotoAssetPath: 'assets/images/mobile_ram_manufacturers.png',
      yearInvented: 2000,
      origin:
      '''Mobile RAM evolved from PC RAM, focusing on low power consumption and integration into smaller devices without sacrificing speed.''',
      evolution:
      '''Mobile RAM progressed from early SDRAM to LPDDR (Low Power DDR) variants to meet demands for improved battery life and performance. Evolution table below:
''',
      typeVariants: [
        TypeVariant(
            imageAssetPath: 'assets/images/lpddr2.png', description: 'LPDDR2'),
        TypeVariant(
            imageAssetPath: 'assets/images/lpddr3.png', description: 'LPDDR3'),
        TypeVariant(
            imageAssetPath: 'assets/images/lpddr4.png', description: 'LPDDR4'),
        TypeVariant(
            imageAssetPath: 'assets/images/lpddr5.png', description: 'LPDDR5'),
      ],
      components: [
        HardwareComponent(
            name: 'Memory Chips',
            imageAssetPath: 'assets/images/mobile_ram_chip.png',
            shortDetails: 'Stores data temporarily for mobile apps.'),
        HardwareComponent(
            name: 'Power Management IC',
            imageAssetPath: 'assets/images/power_management_ic.png',
            shortDetails: 'Optimizes power usage to extend battery life.'),
        HardwareComponent(
            name: 'Controller',
            imageAssetPath: 'assets/images/ram_controller.png',
            shortDetails: 'Manages data flow between CPU and memory.'),
        HardwareComponent(
            name: 'Connection Pins',
            imageAssetPath: 'assets/images/mobile_ram_pins.png',
            shortDetails: 'Interface with mobile processor board.'),
      ],
      workingFlowAssetPath: 'assets/images/mobile_ram_flow.png',
      technologiesUsed: [
        'LPDDR standards for low power and high speed',
        'Advanced fabrication processes',
        'Power-saving operational modes',
      ],
      connectivityAndCompatibility:
      'Integrated into mobile device motherboards; compatibility depends on chipset and device design.',
      trivia:
      '''1. LPDDR RAM offers significant power savings compared to desktop RAM.
2. Mobile RAM is typically soldered and not user-replaceable.
3. Increased RAM improves multitasking and app performance.
4. LPDDR5 offers speeds up to 6400 MT/s.
5. Thermal considerations are critical in mobile RAM design.
6. LPDDR improves battery life while keeping performance high.''',
    );

    return Scaffold(
      appBar: AppBar(title: Text(mobileRamModel.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HardwareBasicInfoSection(model: mobileRamModel),
              Text("Evolution",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(mobileRamModel.evolution,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 14),
              const MobileRamEvolutionTable(),
              const SizedBox(height: 24),
              HardwareComponentsSection(components: mobileRamModel.components),
              const SizedBox(height: 24),
              HardwareWorkingSection(
                workingFlowAssetPath: mobileRamModel.workingFlowAssetPath,
                technologiesUsed: mobileRamModel.technologiesUsed,
                connectivityAndCompatibility:
                mobileRamModel.connectivityAndCompatibility,
                trivia: mobileRamModel.trivia,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileRamEvolutionTable extends StatelessWidget {
  const MobileRamEvolutionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline.withOpacity(0.5);
    final headerBgColor = theme.colorScheme.surfaceVariant;
    final headerTextColor = Colors.teal;
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
                child: Text('Year',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: headerTextColor))),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Type',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: headerTextColor))),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Description',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: headerTextColor))),
          ],
        ),
        _buildTableRow(
            '2007', 'LPDDR1', 'First low power DDR memory for mobiles.', cellTextColor),
        _buildTableRow(
            '2011', 'LPDDR2', 'Improved speed and power efficiency.', cellTextColor),
        _buildTableRow(
            '2013', 'LPDDR3', 'Faster speeds with better power use.', cellTextColor),
        _buildTableRow(
            '2017', 'LPDDR4', 'Higher bandwidth and lower power.', cellTextColor),
        _buildTableRow(
            '2020', 'LPDDR5', 'Cutting-edge mobile RAM with top speeds.', cellTextColor),
      ],
    );
  }

  TableRow _buildTableRow(String year, String type, String description, Color textColor) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(year, style: TextStyle(color: textColor)),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(type, style: TextStyle(color: textColor)),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(description, style: TextStyle(color: textColor)),
      ),
    ]);
  }
}
