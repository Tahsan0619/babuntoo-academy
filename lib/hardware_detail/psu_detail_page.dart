import 'package:flutter/material.dart';
import '../models/hardware_model.dart';
import '../models/hardware_component_model.dart';
import '../widgets/hardware_basic_info_section.dart';
import '../widgets/hardware_components_section.dart';
import '../widgets/hardware_working_section.dart';

class PsuDetailPage extends StatelessWidget {
  static const routeName = '/psu-detail';

  const PsuDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final psuModel = HardwareModel(
      id: 'psu1',
      name: 'PSU (Power Supply Unit)',
      logoAssetPath: 'assets/images/psu_logo.png',
      basicInfo:
      '''The PSU converts AC electrical power from mains to regulated DC power to supply components within a computer.''',
      inventorName: 'Early computer power supply designers',
      inventorPhotoAssetPath: 'assets/images/power_supply.png',
      yearInvented: 1960,
      origin:
      '''Early computers used large, inefficient power supplies. Modern PSUs are compact, efficient, and provide stable power rails for components.''',
      evolution:
      '''Power supplies evolved from linear units to switching power supplies, improving efficiency and reducing heat. Below is a timeline of PSU developments:
''',
      typeVariants: [
        TypeVariant(
            imageAssetPath: 'assets/images/atx_psu.png',
            description: 'ATX PSU'),
        TypeVariant(
            imageAssetPath: 'assets/images/sfx_psu.png',
            description: 'SFX PSU'),
        TypeVariant(
            imageAssetPath: 'assets/images/tfx_psu.png',
            description: 'TFX PSU'),
        TypeVariant(
            imageAssetPath: 'assets/images/modular_psu.png',
            description: 'Modular PSU'),
      ],
      components: [
        HardwareComponent(
            name: 'Transformer',
            imageAssetPath: 'assets/images/transformer.png',
            shortDetails: 'Steps down voltage from mains to lower levels.'),
        HardwareComponent(
            name: 'Rectifier',
            imageAssetPath: 'assets/images/rectifier.png',
            shortDetails: 'Converts AC to DC power.'),
        HardwareComponent(
            name: 'Capacitors',
            imageAssetPath: 'assets/images/capacitors.png',
            shortDetails: 'Smooth out voltage fluctuations.'),
        HardwareComponent(
            name: 'Voltage Regulators',
            imageAssetPath: 'assets/images/voltage_regulator.png',
            shortDetails: 'Maintain stable output voltages.'),
        HardwareComponent(
            name: 'Cooling Fan',
            imageAssetPath: 'assets/images/fan.png',
            shortDetails: 'Cools PSU components to prevent overheating.'),
      ],
      workingFlowAssetPath: 'assets/images/psu_flow.png',
      technologiesUsed: [
        'Switching power supply',
        'Modular cabling',
        '80 Plus efficiency certification',
        'Over-voltage and short-circuit protection',
      ],
      connectivityAndCompatibility:
      'Connects to motherboard, CPU, GPU, drives via cables and connectors. PSU wattage and specs must match system power demands.',
      trivia:
      '''1. The 80 Plus certification rates PSU efficiency.
2. Modular PSUs reduce cable clutter.
3. PSUs protect system components from power surges.
4. Power capacity is measured in watts.
5. Efficient PSUs generate less heat and noise.
6. PSUs can fail and cause system instability if faulty.''',
    );

    return Scaffold(
      appBar: AppBar(title: Text(psuModel.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HardwareBasicInfoSection(model: psuModel),
              Text("Evolution",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(psuModel.evolution,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 14),
              const PsuEvolutionTable(),
              const SizedBox(height: 24),
              HardwareComponentsSection(components: psuModel.components),
              const SizedBox(height: 24),
              HardwareWorkingSection(
                workingFlowAssetPath: psuModel.workingFlowAssetPath,
                technologiesUsed: psuModel.technologiesUsed,
                connectivityAndCompatibility: psuModel.connectivityAndCompatibility,
                trivia: psuModel.trivia,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PsuEvolutionTable extends StatelessWidget {
  const PsuEvolutionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline.withOpacity(0.5);
    final headerBgColor = theme.colorScheme.surfaceVariant;
    final headerTextColor = Colors.purple;
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
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: headerTextColor)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Type',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: headerTextColor)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Description',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: headerTextColor)),
            ),
          ],
        ),
        _buildTableRow('1960s', 'Linear Power Supplies',
            'Early, simple but inefficient power conversion.', cellTextColor),
        _buildTableRow('1980s', 'Switching Power Supplies',
            'Improved efficiency with smaller size.', cellTextColor),
        _buildTableRow('2000s', 'Modular PSUs',
            'Detachable cables for customizable builds.', cellTextColor),
        _buildTableRow('2010s', '80 Plus Certification',
            'Standard for efficiency rating.', cellTextColor),
      ],
    );
  }

  TableRow _buildTableRow(
      String year, String type, String description, Color textColor) {
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
