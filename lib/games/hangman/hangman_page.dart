import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'hangman_controller.dart';
import 'hangman_model.dart';

class HangmanPage extends StatelessWidget {
  const HangmanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HangmanController(),
      child: const _HangmanGameView(),
    );
  }
}

class _HangmanGameView extends StatelessWidget {
  const _HangmanGameView();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HangmanController>(context);
    final state = controller.state;
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    if (controller.showDifficultySelection) {
      return Scaffold(
        appBar: AppBar(title: const Text("Hangman")),
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: screenSize.width * 0.9),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.psychology,
                      size: isSmallScreen ? 48 : 64,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Select Difficulty",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _DifficultyButton(
                      difficulty: HangmanDifficulty.easy,
                      title: "Easy",
                      description: "Simple words, 6 mistakes allowed",
                      color: Colors.green,
                      onSelect: () =>
                          controller.selectDifficulty(HangmanDifficulty.easy),
                    ),
                    const SizedBox(height: 12),
                    _DifficultyButton(
                      difficulty: HangmanDifficulty.medium,
                      title: "Medium",
                      description: "Regular words, 6 mistakes allowed",
                      color: Colors.orange,
                      onSelect: () =>
                          controller.selectDifficulty(HangmanDifficulty.medium),
                    ),
                    const SizedBox(height: 12),
                    _DifficultyButton(
                      difficulty: HangmanDifficulty.hard,
                      title: "Hard",
                      description: "Complex words, 6 mistakes allowed",
                      color: Colors.red,
                      onSelect: () =>
                          controller.selectDifficulty(HangmanDifficulty.hard),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hangman"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.newGame,
            tooltip: "Next Round",
          ),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: controller.resetGame,
            tooltip: "Change Difficulty",
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenSize.width * 0.95,
              maxHeight: screenSize.height,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width > 600 ? 32 : 16,
                vertical: 12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Stats and Difficulty Display
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _StatCard(
                          label: "Difficulty",
                          value: state.difficulty.name.toUpperCase(),
                          color: _getDifficultyColor(state.difficulty),
                        ),
                        _StatCard(
                          label: "Score",
                          value: "${state.score}",
                          color: Colors.blue,
                        ),
                        _StatCard(
                          label: "Won/Lost",
                          value: "${state.totalRoundsWon}/${state.totalRoundsLost}",
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Hangman Display with responsive sizing
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _HangmanDisplay(
                      wrongGuesses: state.wrongGuesses,
                      size: isSmallScreen ? 140 : 180,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Word and Hint
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Text(
                          state.displayWord,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 28 : 36,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Hint: ${state.hint}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Remaining: ${state.remainingGuesses}/${state.maxWrongGuesses}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: state.remainingGuesses <= 2
                                ? Colors.redAccent
                                : theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Alphabet Grid
                  _AlphabetGrid(
                    guessedLetters: state.guessedLetters,
                    onGuess: state.isGameOver
                        ? null
                        : (letter) => controller.guessLetter(letter),
                    screenWidth: screenSize.width,
                  ),
                  const SizedBox(height: 16),
                  // Game Over Screen
                  if (state.isGameOver)
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: state.isWon
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  state.isWon ? Colors.green : Colors.redAccent,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                state.isWon ? "🎉" : "💀",
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 36 : 48,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.isWon
                                    ? "Congratulations! You won."
                                    : "Game Over!\nThe word was: ${state.word}",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: state.isWon
                                      ? Colors.green
                                      : Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (state.isWon) ...[
                                const SizedBox(height: 8),
                                Text(
                                  "Round Score: +${state.calculateRoundScore()}",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: controller.newGame,
                          icon: const Icon(Icons.play_arrow),
                          label: const Text("Play Again"),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: isSmallScreen ? 10 : 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getDifficultyColor(HangmanDifficulty difficulty) {
    switch (difficulty) {
      case HangmanDifficulty.easy:
        return Colors.green;
      case HangmanDifficulty.medium:
        return Colors.orange;
      case HangmanDifficulty.hard:
        return Colors.red;
    }
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class _DifficultyButton extends StatelessWidget {
  final HangmanDifficulty difficulty;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onSelect;

  const _DifficultyButton({
    required this.difficulty,
    required this.title,
    required this.description,
    required this.color,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color.withOpacity(0.7),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HangmanDisplay extends StatelessWidget {
  final int wrongGuesses;
  final double size;

  const _HangmanDisplay({
    required this.wrongGuesses,
    this.size = 180,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size * 0.8,
      child: CustomPaint(
        painter: _HangmanPainter(wrongGuesses: wrongGuesses),
      ),
    );
  }
}

class _HangmanPainter extends CustomPainter {
  final int wrongGuesses;
  _HangmanPainter({required this.wrongGuesses});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[800]!
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // gallows
    canvas.drawLine(Offset(size.width * 0.18, size.height * 0.9),
        Offset(size.width * 0.82, size.height * 0.9), paint);
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.1),
        Offset(size.width * 0.5, size.height * 0.9), paint);
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.1),
        Offset(size.width * 0.8, size.height * 0.1), paint);
    canvas.drawLine(Offset(size.width * 0.8, size.height * 0.1),
        Offset(size.width * 0.8, size.height * 0.2), paint);

    // body parts
    if (wrongGuesses > 0) {
      // Head
      canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.27), 18, paint);
    }
    if (wrongGuesses > 1) {
      // Body
      canvas.drawLine(Offset(size.width * 0.8, size.height * 0.29),
          Offset(size.width * 0.8, size.height * 0.6), paint);
    }
    if (wrongGuesses > 2) {
      // Left Arm
      canvas.drawLine(Offset(size.width * 0.8, size.height * 0.33),
          Offset(size.width * 0.73, size.height * 0.47), paint);
    }
    if (wrongGuesses > 3) {
      // Right Arm
      canvas.drawLine(Offset(size.width * 0.8, size.height * 0.33),
          Offset(size.width * 0.87, size.height * 0.47), paint);
    }
    if (wrongGuesses > 4) {
      // Left Leg
      canvas.drawLine(Offset(size.width * 0.8, size.height * 0.6),
          Offset(size.width * 0.73, size.height * 0.8), paint);
    }
    if (wrongGuesses > 5) {
      // Right Leg
      canvas.drawLine(Offset(size.width * 0.8, size.height * 0.6),
          Offset(size.width * 0.87, size.height * 0.8), paint);
    }
  }

  @override
  bool shouldRepaint(_HangmanPainter oldDelegate) {
    return oldDelegate.wrongGuesses != wrongGuesses;
  }
}

class _AlphabetGrid extends StatelessWidget {
  final Set<String> guessedLetters;
  final void Function(String letter)? onGuess;
  final double screenWidth;

  const _AlphabetGrid({
    required this.guessedLetters,
    this.onGuess,
    this.screenWidth = 400,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final theme = Theme.of(context);
    
    // Adaptive button size based on screen width
    double buttonSize = screenWidth > 600 ? 40 : 36;
    if (screenWidth < 350) buttonSize = 32;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 4,
        runSpacing: 4,
        children: letters.split('').map((letter) {
          final guessed = guessedLetters.contains(letter);
          return SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: OutlinedButton(
              onPressed:
                  (guessed || onGuess == null) ? null : () => onGuess!(letter),
              style: OutlinedButton.styleFrom(
                backgroundColor: guessed
                    ? theme.disabledColor.withOpacity(0.1)
                    : null,
                foregroundColor: guessed
                    ? theme.disabledColor
                    : theme.colorScheme.primary,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                side: BorderSide(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: screenWidth < 350 ? 12 : 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
