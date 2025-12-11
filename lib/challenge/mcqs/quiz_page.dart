import 'package:flutter/material.dart';
import 'models.dart';

enum ScoringMode {
  standard, // +1 for correct
  timedBonus, // +1 + time-based bonus for quick correct answers
}

class McqQuizPage extends StatefulWidget {
  final String title;
  final List<McqQuestion> questions;
  final ScoringMode scoringMode;
  const McqQuizPage({
    super.key,
    required this.title,
    required this.questions,
    this.scoringMode = ScoringMode.standard,
  });

  @override
  State<McqQuizPage> createState() => _McqQuizPageState();
}

class _McqQuizPageState extends State<McqQuizPage> {
  int index = 0;
  double score = 0;
  bool answered = false;
  int? selected;
  late final Stopwatch _stopwatch;
  late Stopwatch _questionStopwatch;
  int _bonusSecondsRemaining = 10;
  Timer? _bonusTimer;

  void _select(int i) {
    if (answered) return;
    setState(() {
      selected = i;
      answered = true;
      if (i == widget.questions[index].correctIndex) {
        // Base point for any correct answer
        score += 1;
        // Apply timed bonus if enabled
        if (widget.scoringMode == ScoringMode.timedBonus) {
          final ms = _questionStopwatch.elapsedMilliseconds;
          // Bonus decays from 0.5 at 0s towards 0 at 10s+ (clamped)
          final bonus = (500 - ms).clamp(0, 500) / 1000.0; // 0.0 .. 0.5
          score += bonus;
        }
      }
    });
  }

  void _next() {
    if (index < widget.questions.length - 1) {
      setState(() {
        index++;
        answered = false;
        selected = null;
        _questionStopwatch
          ..reset()
          ..start();
        _startBonusCountdown();
      });
    } else {
      _showSummary();
    }
  }

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();
    _questionStopwatch = Stopwatch()..start();
    _startBonusCountdown();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _bonusTimer?.cancel();
    super.dispose();
  }

  void _startBonusCountdown() {
    _bonusTimer?.cancel();
    _bonusSecondsRemaining = 10;
    if (widget.scoringMode != ScoringMode.timedBonus) return;
    _bonusTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      if (answered) {
        t.cancel();
        return;
      }
      setState(() {
        _bonusSecondsRemaining = (_bonusSecondsRemaining - 1).clamp(0, 10);
        if (_bonusSecondsRemaining == 0) t.cancel();
      });
    });
  }

  void _showSummary() {
    _stopwatch.stop();
    final elapsed = _stopwatch.elapsed;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Summary'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Score: ${score.toStringAsFixed(2)} / ${widget.questions.length}'),
              const SizedBox(height: 8),
              Text('Accuracy: ${(score.floor() / widget.questions.length * 100).toStringAsFixed(1)}%'),
              const SizedBox(height: 8),
              Text('Time: ${elapsed.inMinutes}m ${elapsed.inSeconds % 60}s'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                  ..pop()
                  ..pop();
              },
              child: const Text('Done'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  index = 0;
                  score = 0;
                  answered = false;
                  selected = null;
                  _stopwatch
                    ..reset()
                    ..start();
                  _questionStopwatch
                    ..reset()
                    ..start();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final q = widget.questions[index];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.title),
              background: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/3/3c/Code_in_editor.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              bottom: true,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Question ${index + 1}/${widget.questions.length}',
                                style: theme.textTheme.titleMedium),
                            Row(
                              children: [
                                Chip(label: Text('Score: ${score.toStringAsFixed(2)}')),
                                const SizedBox(width: 8),
                                Chip(
                                  label: Text(
                                    widget.scoringMode == ScoringMode.standard
                                        ? 'Mode: Standard'
                                        : 'Mode: Timed Bonus',
                                  ),
                                ),
                                if (widget.scoringMode == ScoringMode.timedBonus)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Chip(
                                      avatar: const Icon(Icons.timer, size: 18),
                                      label: Text('Bonus: ${_bonusSecondsRemaining}s'),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(q.prompt,
                            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        ...List.generate(q.options.length, (i) {
                          final isSelected = selected == i;
                          final isCorrect = i == q.correctIndex;
                          Color? bg;
                          Color? fg;
                          if (answered) {
                            if (isCorrect) {
                              bg = Colors.green.shade100;
                              fg = Colors.green.shade900;
                            } else if (isSelected && !isCorrect) {
                              bg = Colors.red.shade100;
                              fg = Colors.red.shade900;
                            }
                          }
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: bg ?? theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: theme.colorScheme.primary.withOpacity(0.15)),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => _select(i),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.circle_outlined,
                                        size: 20, color: fg ?? theme.colorScheme.primary),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(q.options[i], style: theme.textTheme.bodyLarge),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 12),
                        if (answered)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.info_outline, color: Colors.orange),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(q.explanation, style: theme.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            OutlinedButton.icon(
                              onPressed: Navigator.of(context).pop,
                              icon: const Icon(Icons.logout),
                              label: const Text('Exit'),
                            ),
                            const SizedBox(width: 8),
                            if (answered && index < widget.questions.length - 1)
                              FilledButton.icon(
                                onPressed: _next,
                                icon: const Icon(Icons.arrow_forward),
                                label: const Text('Next'),
                              ),
                            if (answered && index == widget.questions.length - 1)
                              FilledButton.icon(
                                onPressed: _next,
                                icon: const Icon(Icons.check_circle_outline),
                                label: const Text('Finish'),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
