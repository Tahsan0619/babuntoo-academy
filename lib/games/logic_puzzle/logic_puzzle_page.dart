import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logic_puzzle_controller.dart';

class LogicPuzzlePage extends StatelessWidget {
  const LogicPuzzlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LogicPuzzleController(),
      child: const _LogicPuzzleGameView(),
    );
  }
}

class _LogicPuzzleGameView extends StatelessWidget {
  const _LogicPuzzleGameView();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LogicPuzzleController>();
    final state = controller.state;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logic Puzzle'),
        elevation: 0,
      ),
      body: state.isGameOver
          ? _GameOverView(
              correctAnswers: state.correctAnswers,
              totalPuzzles: state.totalPuzzles,
            )
          : Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Score: ${state.correctAnswers}/${state.totalPuzzles}',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Q${state.currentPuzzleIndex + 1}',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: (state.currentPuzzleIndex + 1) /
                              state.totalPuzzles,
                          minHeight: 6,
                        ),
                        const SizedBox(height: 32),
                        // Puzzle
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            state.currentPuzzle.title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Options
                        if (!controller.showExplanation)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 2,
                            ),
                            itemCount:
                                state.currentPuzzle.options.length,
                            itemBuilder: (ctx, idx) {
                              return _OptionButton(
                                text: state.currentPuzzle.options[idx],
                                onTap: () =>
                                    controller.answerQuestion(idx),
                              );
                            },
                          ),
                        // Explanation
                        if (controller.showExplanation) ...[
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              border: Border.all(color: Colors.blue[300]!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Explanation:',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[900],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.currentPuzzle.explanation,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.blue[900],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (state.isLastPuzzle)
                            ElevatedButton(
                              onPressed: () {
                                controller.nextPuzzle();
                              },
                              child: const Text('See Results'),
                            )
                          else
                            ElevatedButton(
                              onPressed: () {
                                controller.nextPuzzle();
                              },
                              child: const Text('Next Puzzle'),
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class _OptionButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _OptionButton({
    required this.text,
    required this.onTap,
  });

  @override
  State<_OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<_OptionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        decoration: BoxDecoration(
          color: _isPressed
              ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isPressed
              ? []
              : [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _GameOverView extends StatelessWidget {
  final int correctAnswers;
  final int totalPuzzles;

  const _GameOverView({
    required this.correctAnswers,
    required this.totalPuzzles,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (correctAnswers / totalPuzzles * 100).toStringAsFixed(1);
    final theme = Theme.of(context);

    String message;
    String emoji;
    if (correctAnswers == totalPuzzles) {
      message = 'Perfect Score!';
      emoji = '🏆';
    } else if (correctAnswers >= totalPuzzles * 0.75) {
      message = 'Excellent!';
      emoji = '⭐';
    } else if (correctAnswers >= totalPuzzles * 0.5) {
      message = 'Good Job!';
      emoji = '👍';
    } else {
      message = 'Keep Practicing!';
      emoji = '💪';
    }

    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 80),
                ),
                const SizedBox(height: 24),
                Text(
                  message,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Puzzles Solved',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$correctAnswers/$totalPuzzles',
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '$percentage% Correct',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<LogicPuzzleController>().newGame();
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
