import 'package:flutter/material.dart';
import '../models/hardware_model.dart';
import '../models/hardware_component_model.dart';
import '../widgets/hardware_basic_info_section.dart';
import '../widgets/hardware_components_section.dart';
import '../widgets/hardware_working_section.dart';

class GpuDetailPage extends StatelessWidget {
  static const routeName = '/gpu-detail';

  const GpuDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gpuModel = HardwareModel(
      id: 'gpu1',
      name: 'GPU (Graphics Processing Unit)',
      logoAssetPath: 'assets/images/hardware/gpu/gpu_logo.png',
      basicInfo:
      '''GPU is a specialized processor focused on rendering images, video, and animations, accelerating graphics and parallel processing tasks.''',
      inventorName: 'Nvidia',
      inventorPhotoAssetPath: 'assets/images/hardware/gpu/nvidia_logo.png',
      yearInvented: 1999,
      origin:
      '''GPUs evolved from fixed-function pipelines to programmable processors capable of general purpose and AI computations.''',
      evolution:
      '''Starting with Nvidia’s GeForce 256 in 1999, GPUs rapidly advanced to multi-core massively parallel processors supporting real-time ray tracing and AI. Major developments summarized below:
''',
      typeVariants: [
        TypeVariant(
            imageAssetPath: 'assets/images/hardware/gpu/integrated_gpu.png',
            description: 'Integrated GPU'),
        TypeVariant(
            imageAssetPath: 'assets/images/hardware/gpu/discrete_gpu.png',
            description: 'Discrete GPU'),
        TypeVariant(
            imageAssetPath: 'assets/images/hardware/gpu/workstation_gpu.png',
            description: 'Workstation GPU'),
        TypeVariant(
            imageAssetPath: 'assets/images/hardware/gpu/gaming_gpu.png',
            description: 'Gaming GPU'),
      ],
      components: [
        HardwareComponent(
            name: 'Core Processors',
            imageAssetPath: 'assets/images/hardware/gpu/gpu_cores.png',
            shortDetails: 'Thousands of cores for parallel processing.'),
        HardwareComponent(
            name: 'VRAM',
            imageAssetPath: 'assets/images/hardware/gpu/vram.png',
            shortDetails: 'Memory dedicated to graphics data.'),
        HardwareComponent(
            name: 'Cooling System',
            imageAssetPath: 'assets/images/hardware/gpu/cooling_fan.png',
            shortDetails: 'Maintains optimal temperature during operation.'),
        HardwareComponent(
            name: 'Power Connectors',
            imageAssetPath: 'assets/images/hardware/gpu/gpu_power.png',
            shortDetails: 'Provides power from the PSU.'),
        HardwareComponent(
            name: 'Video Outputs',
            imageAssetPath: 'assets/images/hardware/gpu/video_output.png',
            shortDetails: 'Connects to monitors (HDMI, DisplayPort).'),
      ],
      workingFlowAssetPath: 'assets/images/hardware/gpu/gpu_flow.png',
      technologiesUsed: [
        'CUDA and OpenCL parallel computing',
        'GDDR5/GDDR6 memory',
        'Ray tracing and AI cores',
        'Multi-display support',
      ],
      connectivityAndCompatibility:
      'Connected via PCIe slots; requires compatible power connectors and sufficient PSU wattage.',
      trivia:
      '''1. GPUs have thousands of cores to handle parallel tasks.
2. First GPU was Nvidia GeForce 256.
3. GPUs are vital for gaming and AI workloads.
4. Ray tracing enables realistic lighting effects.
5. VRAM speed affects rendering performance.
6. SLI and Crossfire allow multi-GPU setups.''',
    );

    return Scaffold(
      appBar: AppBar(title: Text(gpuModel.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HardwareBasicInfoSection(model: gpuModel),
              Text("Evolution",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(gpuModel.evolution,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 14),
              const GpuEvolutionTable(),
              const SizedBox(height: 24),
              HardwareComponentsSection(components: gpuModel.components),
              const SizedBox(height: 24),
              HardwareWorkingSection(
                workingFlowAssetPath: gpuModel.workingFlowAssetPath,
                technologiesUsed: gpuModel.technologiesUsed,
                connectivityAndCompatibility: gpuModel.connectivityAndCompatibility,
                trivia: gpuModel.trivia,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GpuEvolutionTable extends StatelessWidget {
  const GpuEvolutionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline.withOpacity(0.5);
    final headerBgColor = theme.colorScheme.surfaceVariant;
    final headerTextColor = Colors.orange;
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
        _buildTableRow('1999', 'GeForce 256',
            'First GPU with hardware transform and lighting.', cellTextColor),
        _buildTableRow('2006', 'Shader Model 4.0',
            'Programmable pipeline introduction.', cellTextColor),
        _buildTableRow('2018', 'Ray tracing GPUs',
            'Real-time ray tracing and AI acceleration.', cellTextColor),
        _buildTableRow('2020s', 'Multi-core & AI focused',
            'Massively parallel GPU cores and tensor processing.', cellTextColor),
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
