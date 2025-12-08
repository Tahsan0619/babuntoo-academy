import 'package:flutter/material.dart';
import '../models/hardware_model.dart';
import '../models/hardware_component_model.dart';
import '../widgets/hardware_basic_info_section.dart';
import '../widgets/hardware_components_section.dart';
import '../widgets/hardware_working_section.dart';

class RomDetailPage extends StatelessWidget {
  static const routeName = '/rom-detail';

  const RomDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final romModel = HardwareModel(
      id: 'rom1',
      name: 'ROM (Read-Only Memory)',
      logoAssetPath: 'assets/images/rom_logo.png',
      basicInfo:
      '''ROM is non-volatile memory that permanently stores firmware and critical startup instructions required for a computer or device to operate.''',
      inventorName: 'Robert Dennard (concept, 1960s)',
      inventorPhotoAssetPath: 'assets/images/dennard.png',
      yearInvented: 1960,
      origin:
      '''Early ROMs were hardwired for basic functionality in computers and embedded systems. Later, programmable and erasable types expanded usage.''',
      evolution:
      '''ROM evolved from Mask ROM to programmable and erasable types like PROM, EPROM, EEPROM, and now to fast, high-capacity flash memory devices. Major milestones are summarized below:
''',
      typeVariants: [
        TypeVariant(
            imageAssetPath: 'assets/images/mask_rom.png',
            description: 'Mask ROM'),
        TypeVariant(
            imageAssetPath: 'assets/images/prom.png',
            description: 'PROM'),
        TypeVariant(
            imageAssetPath: 'assets/images/eprom.png',
            description: 'EPROM'),
        TypeVariant(
            imageAssetPath: 'assets/images/eeprom.png',
            description: 'EEPROM/Flash'),
      ],
      components: [
        HardwareComponent(
            name: 'Memory Array',
            imageAssetPath: 'assets/images/rom_array.png',
            shortDetails: 'Grid of cells for storing fixed data.'),
        HardwareComponent(
            name: 'Decoder',
            imageAssetPath: 'assets/images/decoder.png',
            shortDetails: 'Selects address in memory array for data output.'),
        HardwareComponent(
            name: 'OR Gates',
            imageAssetPath: 'assets/images/or_gates.png',
            shortDetails: 'Outputs stored data in binary logic.'),
        HardwareComponent(
            name: 'Address Inputs',
            imageAssetPath: 'assets/images/address_input.png',
            shortDetails: 'Input lines to specify memory locations.'),
        HardwareComponent(
            name: 'Control Logic',
            imageAssetPath: 'assets/images/control_logic.png',
            shortDetails: 'Manages read operations and timing.'),
      ],
      workingFlowAssetPath: 'assets/images/rom_flow.png',
      technologiesUsed: [
        'Mask ROM',
        'PROM/EPROM/EEPROM',
        'Flash memory',
        'Microcontroller firmware storage',
      ],
      connectivityAndCompatibility:
      'Connected to motherboard/embedded systems via specific address and data lines. Not user-upgradable except for some EEPROM/Flash types.',
      trivia: '''1. Data in ROM remains after power off.
2. EPROM can be erased and reprogrammed using UV light.
3. EEPROM/Flash is reprogrammable by electrical signals.
4. BIOS in computers is stored in ROM or flash memory.
5. Flash memory is a modern ROM variant in USB drives and SSDs.
6. Some devices still use mask ROM for security reasons.
''',
    );

    return Scaffold(
      appBar: AppBar(title: Text(romModel.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HardwareBasicInfoSection(model: romModel),
              Text("Evolution",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(romModel.evolution,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 14),
              const RomEvolutionTable(),
              const SizedBox(height: 24),
              HardwareComponentsSection(components: romModel.components),
              const SizedBox(height: 24),
              HardwareWorkingSection(
                workingFlowAssetPath: romModel.workingFlowAssetPath,
                technologiesUsed: romModel.technologiesUsed,
                connectivityAndCompatibility:
                romModel.connectivityAndCompatibility,
                trivia: romModel.trivia,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RomEvolutionTable extends StatelessWidget {
  const RomEvolutionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline.withOpacity(0.5);
    final headerBgColor = theme.colorScheme.surfaceVariant;
    final headerTextColor = Colors.deepPurple;
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
        _buildTableRow('1956', 'Mask ROM',
            'First ROM, data hardwired during manufacturing.', cellTextColor),
        _buildTableRow('1971', 'EPROM',
            'Erasable ROM, reprogrammed using ultraviolet light.', cellTextColor),
        _buildTableRow('1983', 'EEPROM',
            'Electrically erasable and reprogrammable.', cellTextColor),
        _buildTableRow('1984', 'Flash Memory',
            'Block-level erasure and higher speed, modern devices.', cellTextColor),
      ],
    );
  }

  TableRow _buildTableRow(
      String year, String type, String description, Color textColor) {
    return TableRow(
      children: [
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
      ],
    );
  }
}
