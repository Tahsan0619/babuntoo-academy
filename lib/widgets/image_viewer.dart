import 'package:flutter/material.dart';

// Update the fallback asset path as needed
class ImageViewer extends StatelessWidget {
  final String imagePath;
  final String? caption;
  final double borderRadius;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Alignment alignment;

  static const fallbackAsset = 'assets/images/placeholder.png';

  const ImageViewer({
    Key? key,
    required this.imagePath,
    this.caption,
    this.borderRadius = 12,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final imgWidget = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        imagePath.isNotEmpty ? imagePath : fallbackAsset,
        height: height,
        width: width,
        fit: fit,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) => Container(
          height: height ?? 48,
          width: width ?? 48,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey,
            size: (height ?? width ?? 32) * 0.6,
          ),
        ),
      ),
    );

    if (caption == null || caption!.isEmpty) return imgWidget;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        imgWidget,
        const SizedBox(height: 8),
        Text(
          caption!,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isDark ? Colors.brown : Colors.black,
          ),
        ),
      ],
    );
  }
}
