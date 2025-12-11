import 'package:flutter/material.dart';

import '../games/hangman/hangman_page.dart';
import '../games/math_master/math_master_page.dart';
import '../games/memory_match/memory_match_page.dart';
import '../games/typing_challenge/typing_challenge_page.dart';
import '../games/logic_puzzle/logic_puzzle_page.dart';

class GamesMenuPage extends StatelessWidget {
  const GamesMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Educational Games'),
          elevation: 0,
        ),
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

    final games = [
      {
        'title': 'Hangman',
        'icon': Icons.abc,
        'page': const HangmanPage(),
        'description': 'Guess the word'
      },
      {
        'title': 'Math Master',
        'icon': Icons.calculate,
        'page': const MathMasterPage(),
        'description': 'Solve math problems'
      },
      {
        'title': 'Memory Match',
        'icon': Icons.grid_3x3,
        'page': const MemoryMatchPage(),
        'description': 'Find matching pairs'
      },
      {
        'title': 'Typing Challenge',
        'icon': Icons.keyboard,
        'page': const TypingChallengePage(),
        'description': 'Type fast & accurate'
      },
      {
        'title': 'Logic Puzzle',
        'icon': Icons.lightbulb,
        'page': const LogicPuzzlePage(),
        'description': 'Solve puzzles'
      },
    ];

    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: games.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxTileWidth,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (ctx, index) {
        final game = games[index];
        return _GameCard(
          title: game['title'] as String,
          icon: game['icon'] as IconData,
          onTap: () {
            Navigator.of(ctx).push(
              MaterialPageRoute(builder: (_) => game['page'] as Widget),
            );
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
