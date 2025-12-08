import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'hangman_controller.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hangman"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.newGame,
            tooltip: "Restart",
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                _HangmanDisplay(wrongGuesses: state.wrongGuesses),
                const SizedBox(height: 24),
                Text(
                  state.displayWord,
                  style: TextStyle(
                    fontSize: 36,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Hint: ${state.hint}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _AlphabetGrid(
                  guessedLetters: state.guessedLetters,
                  onGuess: state.isGameOver
                      ? null
                      : (letter) => controller.guessLetter(letter),
                ),
                const SizedBox(height: 16),
                if (state.isGameOver)
                  Column(
                    children: [
                      Text(
                        state.isWon
                            ? "🎉 Congratulations! You won."
                            : "💀 Game Over!\nThe word was: ${state.word}",
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: state.isWon
                              ? Colors.green
                              : Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HangmanDisplay extends StatelessWidget {
  final int wrongGuesses;
  final int maxParts = 6;

  const _HangmanDisplay({required this.wrongGuesses});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 150,
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
    canvas.drawLine(Offset(size.width * 0.18, size.height * 0.9), Offset(size.width * 0.82, size.height * 0.9), paint);
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.1), Offset(size.width * 0.5, size.height * 0.9), paint);
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.1), Offset(size.width * 0.8, size.height * 0.1), paint);
    canvas.drawLine(Offset(size.width * 0.8, size.height * 0.1), Offset(size.width * 0.8, size.height * 0.2), paint);

    // body parts
    if (wrongGuesses > 0) {
      // Head
      canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.27), 18, paint);
    }
    if (wrongGuesses > 1) {
      // Body
      canvas.drawLine(Offset(size.width * 0.8, size.height * 0.29), Offset(size.width * 0.8, size.height * 0.6), paint);
    }
    if (wrongGuesses > 2) {
      // Left Arm
      canvas.drawLine(Offset(size.width * 0.8, size.height * 0.33), Offset(size.width * 0.73, size.height * 0.47), paint);
    }
    if (wrongGuesses > 3) {
      // Right Arm
      canvas.drawLine(Offset(size.width * 0.8, size.height * 0.33), Offset(size.width * 0.87, size.height * 0.47), paint);
    }
    if (wrongGuesses > 4) {
      // Left Leg
      canvas.drawLine(Offset(size.width * 0.8, size.height * 0.6), Offset(size.width * 0.73, size.height * 0.8), paint);
    }
    if (wrongGuesses > 5) {
      // Right Leg
      canvas.drawLine(Offset(size.width * 0.8, size.height * 0.6), Offset(size.width * 0.87, size.height * 0.8), paint);
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

  const _AlphabetGrid({
    required this.guessedLetters,
    this.onGuess,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final theme = Theme.of(context);

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4,
      runSpacing: 4,
      children: letters.split('').map((letter) {
        final guessed = guessedLetters.contains(letter);
        return OutlinedButton(
          onPressed: (guessed || onGuess == null) ? null : () => onGuess!(letter),
          style: OutlinedButton.styleFrom(
            backgroundColor: guessed
                ? theme.disabledColor.withOpacity(0.1)
                : null,
            foregroundColor: guessed
                ? theme.disabledColor
                : theme.colorScheme.primary,
            minimumSize: const Size(36, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: BorderSide(
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: Text(letter),
        );
      }).toList(),
    );
  }
}
