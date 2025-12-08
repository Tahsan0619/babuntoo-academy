import 'package:flutter/material.dart';
import '../models/hardware_model.dart';

class HardwareBasicInfoSection extends StatelessWidget {
  final HardwareModel model;

  const HardwareBasicInfoSection({Key? key, required this.model}) : super(key: key);

  Widget sectionTitle(BuildContext context, String title) => Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 12),
    child: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
    ),
  );

  @override
  Widget build(BuildContext context) {
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CircularImageOrPlaceholder(assetPath: model.logoAssetPath, size: 64),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    model.basicInfo,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Inventor: ${model.inventorName}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                      Text('Year: ${model.yearInvented}', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                _CircularImageOrPlaceholder(assetPath: model.inventorPhotoAssetPath, size: 48),
              ],
            ),
            sectionTitle(context, "Origin"),
            Text(model.origin, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5)),
            sectionTitle(context, "Types & Variants"),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: model.typeVariants.length,
                itemBuilder: (context, index) {
                  final variant = model.typeVariants[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        _CircularImageOrPlaceholder(assetPath: variant.imageAssetPath, size: 56),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: 80,
                          child: Text(
                            variant.description,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircularImageOrPlaceholder extends StatelessWidget {
  final String assetPath;
  final double size;

  const _CircularImageOrPlaceholder({Key? key, required this.assetPath, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).colorScheme.outline;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor),
      ),
      child: ClipOval(
        child: assetPath.isNotEmpty
            ? Image.asset(
          assetPath,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder(),
        )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() => Container(
    color: Colors.grey[400],
    child: const Icon(Icons.image_not_supported, size: 28, color: Colors.white70),
  );
}
