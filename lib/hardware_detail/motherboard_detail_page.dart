import 'package:flutter/material.dart';
import '../models/hardware_model.dart';
import '../models/hardware_component_model.dart';
import '../widgets/hardware_basic_info_section.dart';
import '../widgets/hardware_components_section.dart';
import '../widgets/hardware_working_section.dart';

class MotherboardDetailPage extends StatelessWidget {
  static const routeName = '/motherboard-detail';

  const MotherboardDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final motherboardModel = HardwareModel(
      id: 'motherboard1',
      name: 'Motherboard',
      logoAssetPath: 'assets/images/motherboard_logo.png',
      basicInfo:
      '''The motherboard is the main printed circuit board in a computer, connecting all hardware components and enabling communication between CPU, memory, storage, and peripherals.''',
      inventorName: 'IBM',
      inventorPhotoAssetPath: 'assets/images/ibm_logo.png',
      yearInvented: 1981,
      origin:
      '''Motherboards evolved from rudimentary backplanes and bus systems into highly integrated circuit boards with diverse functionalities.''',
      evolution:
      '''Motherboards have gone through multiple transformations including form factor standardizations (ATX, microATX), integration of interfaces like PCIe, USB, M.2, and support for newer memory standards like DDR4 and DDR5.

Below is a table summarizing these major developments:
''',
      typeVariants: [
        TypeVariant(
            imageAssetPath: 'assets/images/atx_motherboard.png',
            description: 'ATX'),
        TypeVariant(
            imageAssetPath: 'assets/images/micro_atx_motherboard.png',
            description: 'Micro-ATX'),
        TypeVariant(
            imageAssetPath: 'assets/images/mini_itx_motherboard.png',
            description: 'Mini-ITX'),
        TypeVariant(
            imageAssetPath: 'assets/images/server_motherboard.png',
            description: 'Server Board'),
      ],
      components: [
        HardwareComponent(
            name: 'CPU Socket',
            imageAssetPath: 'assets/images/motherboard_cpu_socket.png',
            shortDetails: 'Slot for installing the processor.'),
        HardwareComponent(
            name: 'RAM Slots',
            imageAssetPath: 'assets/images/motherboard_ram_slots.png',
            shortDetails: 'Holds the system memory modules.'),
        HardwareComponent(
            name: 'PCIe Slots',
            imageAssetPath: 'assets/images/motherboard_pcie_slots.png',
            shortDetails: 'Expansion slots for GPUs, sound cards, and other add-on cards.'),
        HardwareComponent(
            name: 'Power Connectors',
            imageAssetPath: 'assets/images/motherboard_power.png',
            shortDetails: 'Connects the power supply to the motherboard.'),
        HardwareComponent(
            name: 'Chipset',
            imageAssetPath: 'assets/images/motherboard_chipset.png',
            shortDetails: 'Manages communication between the CPU and other components.'),
      ],
      workingFlowAssetPath: 'assets/images/motherboard_flow_chart.png',
      technologiesUsed: [
        'PCI-Express (PCIe)',
        'DDR4 and DDR5 memory support',
        'SATA and NVMe storage interfaces',
        'Integrated Wi-Fi and Bluetooth',
        'Onboard audio and network connectivity',
      ],
      connectivityAndCompatibility:
      'Compatibility depends on CPU socket type, memory type supported, and available expansion slots.',
      trivia:
      '''1. ATX is the most common motherboard form factor.
2. Server motherboards can support multiple CPUs.
3. VRMs regulate power stability for critical components.
4. Some motherboards feature built-in RGB lighting.
5. Update of BIOS/firmware is crucial for compatibility.
6. Many modern motherboards integrate Wi-Fi and Bluetooth.''',
    );

    return Scaffold(
      appBar: AppBar(title: Text(motherboardModel.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HardwareBasicInfoSection(model: motherboardModel),
              Text("Evolution",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(motherboardModel.evolution,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 14),
              const MotherboardEvolutionTable(),
              const SizedBox(height: 24),
              HardwareComponentsSection(components: motherboardModel.components),
              const SizedBox(height: 24),
              HardwareWorkingSection(
                workingFlowAssetPath: motherboardModel.workingFlowAssetPath,
                technologiesUsed: motherboardModel.technologiesUsed,
                connectivityAndCompatibility:
                motherboardModel.connectivityAndCompatibility,
                trivia: motherboardModel.trivia,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MotherboardEvolutionTable extends StatelessWidget {
  const MotherboardEvolutionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline.withOpacity(0.5);
    final headerBgColor = theme.colorScheme.surfaceVariant;
    final headerTextColor = Colors.red;
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
        _buildTableRow('1980s', 'Backplane',
            'Early PC design with simple connector boards.', cellTextColor),
        _buildTableRow('1990s', 'ATX Form Factor',
            'Standardized motherboard size and mounting points.', cellTextColor),
        _buildTableRow('2000s', 'Micro-ATX and Mini-ITX',
            'Smaller form factors for compact computers.', cellTextColor),
        _buildTableRow('2010s', 'Enhanced Features',
            'PCIe expansion, integrated features, improved VRMs.', cellTextColor),
        _buildTableRow('2020s', 'Latest Generation',
            'Support for DDR5, PCIe 4.0/5.0, Wi-Fi 6E integration.', cellTextColor),
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
