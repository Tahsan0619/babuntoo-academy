import 'package:flutter/material.dart';
import '../models/hardware_component_model.dart';

class HardwareComponentsSection extends StatelessWidget {
  final List<HardwareComponent> components;

  const HardwareComponentsSection({Key? key, required this.components}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (components.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text('No components available.', style: Theme.of(context).textTheme.bodyMedium),
      );
    }

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Main Components & Parts', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 26,
              runSpacing: 26,
              children: components.map((c) => _PartIconWithLabel(component: c)).toList(),
            ),
            const SizedBox(height: 24),
            ...components.map((c) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ComponentCircle(component: c, size: 40, mini: true),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.name, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(c.shortDetails, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _PartIconWithLabel extends StatelessWidget {
  final HardwareComponent component;
  const _PartIconWithLabel({Key? key, required this.component}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shadowColor = Colors.black.withOpacity(0.1);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          elevation: 3,
          shape: const CircleBorder(),
          shadowColor: shadowColor,
          child: _ComponentCircle(component: component, size: 70),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 90,
          child: Text(
            component.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ComponentCircle extends StatelessWidget {
  final HardwareComponent component;
  final double size;
  final bool mini;

  const _ComponentCircle({Key? key, required this.component, required this.size, this.mini = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).colorScheme.outlineVariant;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(color: borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: component.imageAssetPath.isNotEmpty
          ? Image.asset(
        component.imageAssetPath,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      )
          : _placeholder(),
    );
  }

  Widget _placeholder() => Container(
    color: Colors.grey[400],
    child: const Icon(Icons.memory, color: Colors.white70),
  );
}
