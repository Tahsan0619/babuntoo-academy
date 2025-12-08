import 'package:flutter/material.dart';
import 'quiz_data.dart';

/// Simple single-quiz page with progress, feedback, and score.
/// Designed for clarity and extendability. [web:63][web:77]
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _repo = const QuizRepository();
  late final List<QuizQuestion> _questions;
  int _currentIndex = 0;
  int _score = 0;
  bool _answered = false;
  String? _selectedOptionId;

  @override
  void initState() {
    super.initState();
    _questions = _repo.getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final question = _questions[_currentIndex];
    final total = _questions.length;
    final currentNumber = _currentIndex + 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Models Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _QuizHeader(
              current: currentNumber,
              total: total,
              score: _score,
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: currentNumber / total,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.text,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...question.options.map(
                          (option) => _OptionTile(
                        option: option,
                        isSelected: _selectedOptionId == option.id,
                        isCorrect: option.isCorrect,
                        showResult: _answered,
                        onTap: () => _onOptionSelected(option),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_answered)
                      _ExplanationBox(
                        explanation: question.explanation,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  void _onOptionSelected(QuizOption option) {
    if (_answered) return;

    setState(() {
      _selectedOptionId = option.id;
      _answered = true;
      if (option.isCorrect) {
        _score++;
      }
    });
  }

  Widget _buildBottomButton() {
    final isLast = _currentIndex == _questions.length - 1;
    final canContinue = _answered;

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: canContinue ? _onNextPressed : null,
        child: Text(isLast ? 'See result' : 'Next question'),
      ),
    );
  }

  void _onNextPressed() {
    final isLast = _currentIndex == _questions.length - 1;
    if (isLast) {
      _showResultDialog();
      return;
    }

    setState(() {
      _currentIndex++;
      _answered = false;
      _selectedOptionId = null;
    });
  }

  void _showResultDialog() {
    final total = _questions.length;
    final score = _score;

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz finished'),
          content: Text('You scored $score out of $total.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentIndex = 0;
                  _score = 0;
                  _answered = false;
                  _selectedOptionId = null;
                });
              },
              child: const Text('Restart'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class _QuizHeader extends StatelessWidget {
  final int current;
  final int total;
  final int score;

  const _QuizHeader({
    required this.current,
    required this.total,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Question $current of $total',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'Score: $score',
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final QuizOption option;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback onTap;

  const _OptionTile({
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.showResult,
    required this.onTap,
  });

  Color _backgroundColor(BuildContext context) {
    final theme = Theme.of(context);
    if (!showResult) {
      return isSelected
          ? theme.colorScheme.primary.withOpacity(0.12)
          : theme.colorScheme.surface;
    }
    if (isCorrect) {
      return Colors.green.withOpacity(0.15);
    }
    if (isSelected && !isCorrect) {
      return Colors.red.withOpacity(0.15);
    }
    return theme.colorScheme.surface;
  }

  Color _borderColor(BuildContext context) {
    if (!showResult && isSelected) {
      return Theme.of(context).colorScheme.primary;
    }
    if (showResult && isCorrect) {
      return Colors.green;
    }
    if (showResult && isSelected && !isCorrect) {
      return Colors.red;
    }
    return Colors.grey.shade300;
  }

  IconData? _icon() {
    if (!showResult) return null;
    if (isCorrect) return Icons.check_circle;
    if (isSelected && !isCorrect) return Icons.cancel;
    return null;
  }

  Color? _iconColor() {
    if (!showResult) return null;
    if (isCorrect) return Colors.green;
    if (isSelected && !isCorrect) return Colors.red;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _backgroundColor(context),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _borderColor(context)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option.text,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              if (_icon() != null) ...[
                const SizedBox(width: 8),
                Icon(
                  _icon(),
                  color: _iconColor(),
                  size: 20,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ExplanationBox extends StatelessWidget {
  final String explanation;

  const _ExplanationBox({
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        explanation,
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}
