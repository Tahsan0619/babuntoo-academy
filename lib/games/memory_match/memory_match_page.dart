import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memory_match_controller.dart';

class MemoryMatchPage extends StatelessWidget {
  const MemoryMatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MemoryMatchController(),
      child: const _MemoryMatchGameView(),
    );
  }
}

class _MemoryMatchGameView extends StatelessWidget {
  const _MemoryMatchGameView();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MemoryMatchController>();
    final state = controller.state;
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match'),
        elevation: 0,
      ),
      body: state.isGameOver
          ? _GameOverView(
              moves: state.moves,
              totalPairs: state.totalPairs,
              screenSize: screenSize,
            )
          : Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenSize.width * 0.95,
                    maxHeight: screenSize.height * 1.2,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width > 600 ? 24 : 12,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        // Stats
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Pairs: ${state.matchedPairs}/${state.totalPairs}',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Moves: ${state.moves}',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Progress
                        LinearProgressIndicator(
                          value: state.matchedPairs / state.totalPairs,
                          minHeight: 6,
                        ),
                        const SizedBox(height: 20),
                        // Cards Grid with adaptive layout
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: screenSize.width > 600 ? 4 : 4,
                              mainAxisSpacing: screenSize.width > 600 ? 12 : 8,
                              crossAxisSpacing: screenSize.width > 600 ? 12 : 8,
                              childAspectRatio: 1,
                            ),
                            itemCount: state.cards.length,
                            itemBuilder: (ctx, idx) {
                              final card = state.cards[idx];
                              return _CardTile(
                                card: card,
                                onTap: () => controller.flipCard(idx),
                                isClickable: !state.isChecking &&
                                    !card.isMatched &&
                                    !card.isFlipped,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class _CardTile extends StatelessWidget {
  final MemoryCard card;
  final VoidCallback onTap;
  final bool isClickable;

  const _CardTile({
    required this.card,
    required this.onTap,
    required this.isClickable,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final cardSize = (screenSize.width > 600 ? 60.0 : 48.0);

    return GestureDetector(
      onTap: isClickable ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: card.isMatched
              ? Colors.green[400]
              : card.isFlipped
                  ? Colors.blue[400]
                  : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: card.isFlipped || card.isMatched
              ? Text(
                  card.value,
                  style: TextStyle(fontSize: cardSize * 0.6),
                )
              : Text(
                  '?',
                  style: TextStyle(
                    fontSize: cardSize * 0.6,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
        ),
      ),
    );
  }
}

class _GameOverView extends StatelessWidget {
  final int moves;
  final int totalPairs;
  final Size screenSize;

  const _GameOverView({
    required this.moves,
    required this.totalPairs,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    final efficiency =
        ((totalPairs * 2) / moves * 100).toStringAsFixed(1);
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenSize.width * 0.9,
            maxHeight: screenSize.height,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width > 600 ? 32 : 16,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '🎉',
                  style: TextStyle(
                    fontSize: screenSize.height > 700 ? 80 : 60,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'You Won!',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _StatItem(
                        label: 'Total Moves',
                        value: moves.toString(),
                      ),
                      const SizedBox(height: 16),
                      _StatItem(
                        label: 'Pairs Matched',
                        value: totalPairs.toString(),
                      ),
                      const SizedBox(height: 16),
                      _StatItem(
                        label: 'Efficiency',
                        value: '$efficiency%',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<MemoryMatchController>().newGame();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Play Again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}
