import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'typing_challenge_controller.dart';
import 'dart:async';

class TypingChallengePage extends StatelessWidget {
  const TypingChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TypingChallengeController(),
      child: const _TypingChallengeGameView(),
    );
  }
}

class _TypingChallengeGameView extends StatefulWidget {
  const _TypingChallengeGameView();

  @override
  State<_TypingChallengeGameView> createState() =>
      _TypingChallengeGameViewState();
}

class _TypingChallengeGameViewState extends State<_TypingChallengeGameView> {
  late Timer _timer;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final controller = context.read<TypingChallengeController>();
      final newTime = controller.state.timeRemaining - 1;
      controller.updateTimer(newTime);

      if (newTime <= 0) {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TypingChallengeController>();
    final state = controller.state;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Typing Challenge'),
        elevation: 0,
      ),
      body: state.isGameOver
          ? _GameOverView(
              correctWords: state.correctWords,
              totalWords: state.totalWords,
              accuracy: state.accuracy,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Words: ${state.correctWords}/${state.totalWords}',
                                  style: theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Accuracy: ${state.accuracy.toStringAsFixed(1)}%',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: state.accuracy >= 90
                                        ? Colors.green
                                        : state.accuracy >= 70
                                            ? Colors.orange
                                            : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: state.timeRemaining < 30
                                    ? Colors.red
                                    : Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${state.timeRemaining}s',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        // Word to type
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Type this word:',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                state.currentWord,
                                style: theme.textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onPrimaryContainer,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Input field
                        TextField(
                          controller: _textController,
                          onChanged: controller.updateInput,
                          enabled: !state.isGameOver,
                          decoration: InputDecoration(
                            hintText: 'Type and press space...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          autofocus: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class _GameOverView extends StatelessWidget {
  final int correctWords;
  final int totalWords;
  final double accuracy;

  const _GameOverView({
    required this.correctWords,
    required this.totalWords,
    required this.accuracy,
  });

  @override
  Widget build(BuildContext context) {
    final wpm = correctWords * 0.5; // Rough estimate
    final theme = Theme.of(context);

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
                  accuracy >= 85 ? '🏆' : '💪',
                  style: const TextStyle(fontSize: 80),
                ),
                const SizedBox(height: 24),
                Text(
                  'Time\'s up!',
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
                      _StatItem(
                        label: 'Correct Words',
                        value: '$correctWords/$totalWords',
                      ),
                      const SizedBox(height: 12),
                      _StatItem(
                        label: 'Accuracy',
                        value: '${accuracy.toStringAsFixed(1)}%',
                      ),
                      const SizedBox(height: 12),
                      _StatItem(
                        label: 'Estimated WPM',
                        value: wpm.toStringAsFixed(0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<TypingChallengeController>().newGame();
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
