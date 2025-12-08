import 'package:flutter/material.dart';

/// Reusable primary button with full-width option. [web:81][web:87]
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool fullWidth;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = FilledButton(
      onPressed: onPressed,
      child: Text(label),
    );

    if (!fullWidth) return button;

    return SizedBox(
      width: double.infinity,
      child: button,
    );
  }
}
