import 'package:flutter/material.dart';

import '../games/hangman/hangman_page.dart';

class GamesMenuPage extends StatelessWidget {
  const GamesMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Games')),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidthAvailable = constraints.maxWidth;

            // Responsive maxWidth container width
            double containerMaxWidth;
            if (maxWidthAvailable >= 1200) {
              containerMaxWidth = 1000;
            } else if (maxWidthAvailable >= 800) {
              containerMaxWidth = 700;
            } else {
              containerMaxWidth = maxWidthAvailable;
            }

            final horizontalPadding = (maxWidthAvailable * 0.05).clamp(16, 48).toDouble();

            return Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: containerMaxWidth),
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
                child: Column(
                  children: [
                    Expanded(
                      child: _GamesGrid(maxWidthAvailable: maxWidthAvailable),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GamesGrid extends StatelessWidget {
  final double maxWidthAvailable;
  const _GamesGrid({required this.maxWidthAvailable, super.key});

  @override
  Widget build(BuildContext context) {
    const double maxTileWidth = 280;

    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: 1, // Increase this as you add more games
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxTileWidth,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (ctx, index) {
        return _GameCard(
          title: 'Hangman', // Add other titles here as needed
          icon: Icons.sentiment_very_satisfied,
          onTap: () {
            Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => const HangmanPage()));
          },
        );
      },
    );
  }
}

class _GameCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _GameCard({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    // Responsive icon and padding
    double iconSize = size.width < 350
        ? 38
        : size.width > 600
        ? 72
        : 56;
    double verticalPad = size.width < 350
        ? 14
        : size.width > 600
        ? 38
        : 28;

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalPad),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: iconSize, color: theme.colorScheme.primary),
              SizedBox(height: iconSize * 0.23),
              // Game name: wraps, never overflows, always shown fully (up to 3 lines)
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
