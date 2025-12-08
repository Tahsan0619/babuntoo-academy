import 'package:flutter/material.dart';
import '../models/hardware_model.dart';
import '../models/hardware_component_model.dart';
import '../widgets/hardware_basic_info_section.dart';
import '../widgets/hardware_components_section.dart';
import '../widgets/hardware_working_section.dart';

class LaptopRamDetailPage extends StatelessWidget {
  static const routeName = '/laptop-ram-detail';

  const LaptopRamDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final laptopRamModel = HardwareModel(
      id: 'laptop_ram1',
      name: 'Laptop RAM',
      logoAssetPath: 'assets/images/laptop_ram_logo.png',
      basicInfo:
      '''Laptop RAM uses smaller form factor modules (SO-DIMM) optimized for portable computers, balancing speed, power consumption, and size constraints.''',
      inventorName: 'Various manufacturers (e.g., Kingston, Corsair)',
      inventorPhotoAssetPath: 'assets/images/laptop_ram_manufacturers.png',
      yearInvented: 1998,
      origin:
      '''It evolved from desktop RAM with physical size reduction and power optimizations tailored for laptops and compact systems.''',
      evolution:
      '''From DIMM to SO-DIMM, laptop RAM evolved through DDR, DDR2, DDR3, DDR4, to DDR5, improving speed and efficiency. See the evolution summary below:
''',
      typeVariants: [
        TypeVariant(
            imageAssetPath: 'assets/images/sodimm_ddr3.png', description: 'DDR3 SO-DIMM'),
        TypeVariant(
            imageAssetPath: 'assets/images/sodimm_ddr4.png', description: 'DDR4 SO-DIMM'),
        TypeVariant(
            imageAssetPath: 'assets/images/sodimm_ddr5.png', description: 'DDR5 SO-DIMM'),
      ],
      components: [
        HardwareComponent(
            name: 'Memory Chips',
            imageAssetPath: 'assets/images/laptop_ram_chip.png',
            shortDetails: 'Stores active data for laptop applications.'),
        HardwareComponent(
            name: 'PCB Board',
            imageAssetPath: 'assets/images/laptop_ram_board.png',
            shortDetails: 'Compact circuit board for laptop memory.'),
        HardwareComponent(
            name: 'Connector Pins',
            imageAssetPath: 'assets/images/laptop_ram_pins.png',
            shortDetails: 'Interface with laptop memory slot.'),
        HardwareComponent(
            name: 'SPD Chip',
            imageAssetPath: 'assets/images/spd_chip.png',
            shortDetails: 'Stores module configuration info.'),
      ],
      workingFlowAssetPath: 'assets/images/laptop_ram_flow.png',
      technologiesUsed: [
        'SO-DIMM form factor',
        'DDR3 to DDR5 standards',
        'Power-saving operational modes',
      ],
      connectivityAndCompatibility:
      'Fits into laptop memory slots (SO-DIMM); compatibility depends on laptop model and chipset.',
      trivia:
      '''1. Laptop RAM is smaller but similar in function to desktop RAM.
2. Not user-upgradable on many ultrabooks.
3. DDR5 SO-DIMM is latest offering improved speed and efficiency.
4. Laptop RAM typically runs at lower voltage.
5. Higher RAM capacity improves multitasking.
6. Removing laptop RAM often requires laptop disassembly.''',
    );

    return Scaffold(
      appBar: AppBar(title: Text(laptopRamModel.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HardwareBasicInfoSection(model: laptopRamModel),
              Text("Evolution",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(laptopRamModel.evolution,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 14),
              const LaptopRamEvolutionTable(),
              const SizedBox(height: 24),
              HardwareComponentsSection(components: laptopRamModel.components),
              const SizedBox(height: 24),
              HardwareWorkingSection(
                workingFlowAssetPath: laptopRamModel.workingFlowAssetPath,
                technologiesUsed: laptopRamModel.technologiesUsed,
                connectivityAndCompatibility:
                laptopRamModel.connectivityAndCompatibility,
                trivia: laptopRamModel.trivia,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LaptopRamEvolutionTable extends StatelessWidget {
  const LaptopRamEvolutionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline.withOpacity(0.5);
    final headerBgColor = theme.colorScheme.surfaceVariant;
    final headerTextColor = Colors.blueGrey;
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
            '1998', 'SO-DIMM DDR', 'Smaller memory module for laptops.', cellTextColor),
        _buildTableRow(
            '2003', 'SO-DIMM DDR2', 'Improved speed and efficiency.', cellTextColor),
        _buildTableRow(
            '2007', 'SO-DIMM DDR3', 'Stable high-speed memory.', cellTextColor),
        _buildTableRow(
            '2014', 'SO-DIMM DDR4', 'Lower power consumption.', cellTextColor),
        _buildTableRow(
            '2022', 'SO-DIMM DDR5', 'Latest generation with superior performance.', cellTextColor),
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
