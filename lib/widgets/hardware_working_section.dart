import 'package:flutter/material.dart';

class HardwareWorkingSection extends StatelessWidget {
  final String workingFlowAssetPath;
  final List<String> technologiesUsed;
  final String connectivityAndCompatibility;
  final String trivia;

  const HardwareWorkingSection({
    Key? key,
    required this.workingFlowAssetPath,
    required this.technologiesUsed,
    required this.connectivityAndCompatibility,
    required this.trivia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('How It Works', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          _ZoomableFlowChartImage(assetPath: workingFlowAssetPath),
          const SizedBox(height: 24),
          Text('Technologies Used', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ...technologiesUsed.map((tech) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text('• $tech', style: Theme.of(context).textTheme.bodyMedium),
          )),
          const SizedBox(height: 20),
          Text('Connectivity & Compatibility', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(connectivityAndCompatibility, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 20),
          Text('Fun Facts & Trivia', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(trivia, style: Theme.of(context).textTheme.bodyMedium),
        ]),
      ),
    );
  }
}

class _ZoomableFlowChartImage extends StatelessWidget {
  final String assetPath;
  const _ZoomableFlowChartImage({Key? key, required this.assetPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return assetPath.isNotEmpty
        ? InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              insetPadding: const EdgeInsets.all(12),
              backgroundColor: Colors.black,
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 5,
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            assetPath,
            height: 180,
            width: double.infinity,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => _placeholder(),
          ),
        ))
        : _placeholder();
  }

  Widget _placeholder() => Container(
    height: 180,
    color: Colors.grey[200],
    child: Center(
      child: Icon(Icons.device_hub, size: 72, color: Colors.grey[400]),
    ),
  );
}
