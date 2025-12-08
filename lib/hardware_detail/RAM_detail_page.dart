import 'package:flutter/material.dart';
import '../models/hardware_model.dart';
import '../models/hardware_component_model.dart';
import '../widgets/hardware_basic_info_section.dart';
import '../widgets/hardware_components_section.dart';
import '../widgets/hardware_working_section.dart';

class RamDetailPage extends StatelessWidget {
  static const routeName = '/ram-detail';

  const RamDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ramModel = HardwareModel(
      id: 'ram1',
      name: 'RAM (Random Access Memory)',
      logoAssetPath: 'assets/images/ram_logo.png',
      basicInfo:
      '''RAM is a type of volatile computer memory that temporarily stores data and machine code currently being used, enabling quick access by the processor for fast operation.''',
      inventorName: 'Robert H. Dennard',
      inventorPhotoAssetPath: 'assets/images/dennard.png',
      yearInvented: 1968,
      origin:
      '''RAM technology evolved from early Williams tube and magnetic-core memory to modern high-capacity, high-speed integrated circuits.''',
      evolution:
      '''From the invention of the Williams tube in 1947 to DDR4 and DDR5 standards, RAM has evolved toward higher speeds, capacity, and efficiency. Key milestones are summarized below:
''',
      typeVariants: [
        TypeVariant(
            imageAssetPath: 'assets/images/sdram.png', description: 'SDRAM'),
        TypeVariant(
            imageAssetPath: 'assets/images/ddr4_ram.png', description: 'DDR4'),
        TypeVariant(
            imageAssetPath: 'assets/images/ddr5_ram.png', description: 'DDR5'),
        TypeVariant(
            imageAssetPath: 'assets/images/laptop_ram.png', description: 'SO-DIMM'),
      ],
      components: [
        HardwareComponent(
            name: 'Memory Chips',
            imageAssetPath: 'assets/images/ram_chip.png',
            shortDetails: 'Stores the actual data bits as electrical charges.'),
        HardwareComponent(
            name: 'Circuit Board',
            imageAssetPath: 'assets/images/ram_board.png',
            shortDetails: 'Holds and connects all components.'),
        HardwareComponent(
            name: 'SPD Chip',
            imageAssetPath: 'assets/images/spd_chip.png',
            shortDetails: 'Holds module info like speed and capacity.'),
        HardwareComponent(
            name: 'Contact Pins',
            imageAssetPath: 'assets/images/ram_pins.png',
            shortDetails: 'Connect to the motherboard slot.'),
        HardwareComponent(
            name: 'Heat Spreader',
            imageAssetPath: 'assets/images/heat_spreader.png',
            shortDetails: 'Dissipates heat produced during operation.'),
      ],
      workingFlowAssetPath: 'assets/images/ram_flow.png',
      technologiesUsed: [
        'SDRAM',
        'DDR4/DDR5 technology',
        'Dual-/Quad-Channel Architecture',
        'Heat spreader design',
      ],
      connectivityAndCompatibility:
      'Slots directly into motherboard RAM slots (e.g., DDR4, DDR5 DIMM). Compatibility depends on motherboard chipset and RAM speed ratings.',
      trivia: '''1. RAM is volatile: it loses data when power is off.
2. More RAM improves multitasking and application speed.
3. Modern gaming PCs use DDR4 or DDR5 RAM.
4. ECC RAM is used in servers for error correction.
5. RAM overclocking is popular for advanced users.
6. Laptop RAM uses a different form factor (SO-DIMM).
''',
    );

    return Scaffold(
      appBar: AppBar(title: Text(ramModel.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HardwareBasicInfoSection(model: ramModel),
              Text("Evolution",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(ramModel.evolution,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 14),
              const RamEvolutionTable(),
              const SizedBox(height: 24),
              HardwareComponentsSection(components: ramModel.components),
              const SizedBox(height: 24),
              HardwareWorkingSection(
                workingFlowAssetPath: ramModel.workingFlowAssetPath,
                technologiesUsed: ramModel.technologiesUsed,
                connectivityAndCompatibility:
                ramModel.connectivityAndCompatibility,
                trivia: ramModel.trivia,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RamEvolutionTable extends StatelessWidget {
  const RamEvolutionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline.withOpacity(0.5);
    final headerBgColor = theme.colorScheme.surfaceVariant;
    final headerTextColor = Colors.green;
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
        _buildTableRow('1947', 'Williams Tube',
            'First RAM using charged dots in CRTs.', cellTextColor),
        _buildTableRow('1947', 'Magnetic-Core Memory',
            'Small rings magnetic memory, 1 bit per ring.', cellTextColor),
        _buildTableRow('1968', 'DRAM',
            'Transistor-based; Dennis Dennard’s invention, dynamic memory.', cellTextColor),
        _buildTableRow('1993', 'SDRAM',
            'Synchronous DRAM for enhanced processing speed.', cellTextColor),
        _buildTableRow('2003+', 'DDR, DDR2-5',
            'Double data rate: higher speeds and energy efficiency.', cellTextColor),
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
