import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import 'mcqs/models.dart';
import 'mcqs/c_mcqs.dart';
import 'mcqs/python_mcqs.dart';
import 'mcqs/java_mcqs.dart';
import 'mcqs/cpp_mcqs.dart';
import 'mcqs/quiz_page.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({Key? key}) : super(key: key);

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  ScoringMode _defaultMode = ScoringMode.timedBonus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Challenges'),
              background: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/3/3c/Code_in_editor.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _IntroBlurb(theme: theme),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Default scoring mode', style: theme.textTheme.titleSmall),
                      SegmentedButton<ScoringMode>(
                        segments: const [
                          ButtonSegment(value: ScoringMode.standard, label: Text('Standard')),
                          ButtonSegment(value: ScoringMode.timedBonus, label: Text('Timed Bonus')),
                        ],
                        selected: {_defaultMode},
                        onSelectionChanged: (s) => setState(() => _defaultMode = s.first),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _LanguageGrid(defaultMode: _defaultMode),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageGrid extends StatelessWidget {
  final ScoringMode defaultMode;
  const _LanguageGrid({required this.defaultMode});

  @override
  Widget build(BuildContext context) {
    final items = [
      _LangItem('C', Icons.code, 'Sharpen your C basics'),
      _LangItem('Python', Icons.memory, 'Quick Python MCQs'),
      _LangItem('Java', Icons.developer_mode, 'OOP-focused quizzes'),
      _LangItem('C++', Icons.computer, 'Templates & STL tests'),
    ];
    return LayoutBuilder(builder: (context, constraints) {
      final isWide = constraints.maxWidth > 700;
      final crossAxisCount = isWide ? 4 : 2;
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];
          return _LanguageCard(item: item, defaultMode: defaultMode);
        },
      );
    });
  }
}

class _LangItem {
  final String name;
  final IconData icon;
  final String subtitle;
  const _LangItem(this.name, this.icon, this.subtitle);
}

class _LanguageCard extends StatefulWidget {
  final _LangItem item;
  final ScoringMode defaultMode;
  const _LanguageCard({required this.item, required this.defaultMode});

  @override
  State<_LanguageCard> createState() => _LanguageCardState();
}

class _LanguageCardState extends State<_LanguageCard> {
  late ScoringMode _mode = widget.defaultMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _openQuiz(context, widget.item.name, _mode),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.item.icon, size: 36, color: theme.colorScheme.primary),
              const SizedBox(height: 10),
              Text(widget.item.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                widget.item.subtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  SegmentedButton<ScoringMode>(
                    segments: const [
                      ButtonSegment(value: ScoringMode.standard, label: Text('Standard')),
                      ButtonSegment(value: ScoringMode.timedBonus, label: Text('Timed Bonus')),
                    ],
                    selected: {_mode},
                    onSelectionChanged: (s) => setState(() => _mode = s.first),
                  ),
                  FilledButton.icon(
                    onPressed: () => _openQuiz(context, widget.item.name, _mode),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openQuiz(BuildContext context, String name, ScoringMode mode) {
    switch (name) {
      case 'C':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => McqQuizPage(title: 'C MCQs', questions: cMcqs, scoringMode: mode),
          ),
        );
        break;
      case 'Python':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => McqQuizPage(title: 'Python MCQs', questions: pythonMcqs, scoringMode: mode),
          ),
        );
        break;
      case 'Java':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => McqQuizPage(title: 'Java MCQs', questions: javaMcqs, scoringMode: mode),
          ),
        );
        break;
      case 'C++':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => McqQuizPage(title: 'C++ MCQs', questions: cppMcqs, scoringMode: mode),
          ),
        );
        break;
    }
  }
}

class _IntroBlurb extends StatelessWidget {
  final ThemeData theme;
  const _IntroBlurb({required this.theme});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.psychology_alt_outlined, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Pick a language to start timed MCQs. Questions adjust to screen size. No overflow, just learning!',
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
// Legacy challenge views using ChallengeController were removed to simplify the
// MCQ flow and avoid undefined references.
