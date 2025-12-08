import 'package:flutter/material.dart';
import '../models/hardware_model.dart';
import '../models/hardware_component_model.dart';
import '../widgets/hardware_basic_info_section.dart';
import '../widgets/hardware_components_section.dart';
import '../widgets/hardware_working_section.dart';

class CpuDetailPage extends StatelessWidget {
  static const routeName = '/cpu-detail';

  const CpuDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cpuModel = HardwareModel(
      id: 'cpu1',
      name: 'CPU (Central Processing Unit)',
      logoAssetPath: 'assets/images/hardware/cpu/cpu_logo.png',
      basicInfo:
      '''The CPU is the primary component of a computer that performs most of the processing inside a system by executing instructions from programs.''',
      inventorName: 'Intel (Intel 4004, 1971)',
      inventorPhotoAssetPath: 'assets/images/hardware/cpu/intel_logo.png',
      yearInvented: 1971,
      origin:
      '''CPUs started as simple chips executing basic instructions and have evolved to multi-core, multi-thread processors with advanced architectures.''',
      evolution:
      '''From Intel’s 4004 microprocessor in 1971 to today’s multi-core processors with billions of transistors, CPUs have grown in complexity and capability. Key milestones summarized below:
''',
      typeVariants: [
        TypeVariant(
            imageAssetPath: 'assets/images/hardware/cpu/single_core_cpu.png',
            description: 'Single-Core'),
        TypeVariant(
            imageAssetPath: 'assets/images/hardware/cpu/multi_core_cpu.png',
            description: 'Multi-Core'),
        TypeVariant(
            imageAssetPath: 'assets/images/hardware/cpu/mobile_cpu.png',
            description: 'Mobile CPU'),
        TypeVariant(
            imageAssetPath: 'assets/images/hardware/cpu/server_cpu.png',
            description: 'Server CPU'),
      ],
      components: [
        HardwareComponent(
            name: 'ALU (Arithmetic Logic Unit)',
            imageAssetPath: 'assets/images/hardware/cpu/alu.png',
            shortDetails: 'Performs arithmetic and logic operations.'),
        HardwareComponent(
            name: 'Control Unit',
            imageAssetPath: 'assets/images/hardware/cpu/control_unit.png',
            shortDetails: 'Directs CPU operations and instruction flow.'),
        HardwareComponent(
            name: 'Cache',
            imageAssetPath: 'assets/images/hardware/cpu/cache.png',
            shortDetails: 'Small, fast memory for frequently used data.'),
        HardwareComponent(
            name: 'Registers',
            imageAssetPath: 'assets/images/hardware/cpu/registers.png',
            shortDetails: 'Small storage locations for temporary data.'),
        HardwareComponent(
            name: 'Bus Interface',
            imageAssetPath: 'assets/images/hardware/cpu/bus_interface.png',
            shortDetails: 'Communication pathway to other components.'),
      ],
      workingFlowAssetPath: 'assets/images/hardware/cpu/cpu_flow.png',
      technologiesUsed: [
        'Multi-core architecture',
        'Hyper-threading/Simultaneous Multithreading',
        'Advanced instruction sets (SSE, AVX)',
        'Integrated GPU (some CPUs)',
      ],
      connectivityAndCompatibility:
      'Compatible with specific CPU sockets and supported by motherboard chipsets. Performance depends on architecture and clock speed.',
      trivia:
      '''1. The first microprocessor was Intel 4004.
2. Modern CPUs may contain over 10 billion transistors.
3. Clock speed is often measured in GHz.
4. Thermal design power (TDP) indicates heat output.
5. CPUs execute billions of instructions per second.
6. Overclocking improves performance but increases heat.''',
    );

    return Scaffold(
      appBar: AppBar(title: Text(cpuModel.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HardwareBasicInfoSection(model: cpuModel),
              Text("Evolution",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(cpuModel.evolution,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 14),
              const CpuEvolutionTable(),
              const SizedBox(height: 24),
              HardwareComponentsSection(components: cpuModel.components),
              const SizedBox(height: 24),
              HardwareWorkingSection(
                workingFlowAssetPath: cpuModel.workingFlowAssetPath,
                technologiesUsed: cpuModel.technologiesUsed,
                connectivityAndCompatibility: cpuModel.connectivityAndCompatibility,
                trivia: cpuModel.trivia,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CpuEvolutionTable extends StatelessWidget {
  const CpuEvolutionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline.withOpacity(0.5);
    final headerBgColor = theme.colorScheme.surfaceVariant;
    final headerTextColor = Colors.blue;
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
        _buildTableRow('1971', 'Intel 4004',
            'First commercial microprocessor, 4-bit CPU.', cellTextColor),
        _buildTableRow('1980s', 'Increasing Cores',
            'Introduction of multi-core processors.', cellTextColor),
        _buildTableRow('2000s', '64-bit CPUs',
            'Support for larger memory addressing and performance.', cellTextColor),
        _buildTableRow('2010s', 'Integration & Efficiency',
            'Integrated graphics and power efficiency improvements.', cellTextColor),
        _buildTableRow('2020s', 'High-Core Count & AI',
            'CPUs with many cores and AI acceleration.', cellTextColor),
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
