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

class _DropDownChallengeSelector extends StatefulWidget {
  final List<dynamic> cProblems;
  final List<dynamic> pyProblems;
  final ChallengeController controller;

  const _DropDownChallengeSelector({
    required this.cProblems,
    required this.pyProblems,
    required this.controller,
  });

  @override
  State<_DropDownChallengeSelector> createState() => _DropDownChallengeSelectorState();
}

class _DropDownChallengeSelectorState extends State<_DropDownChallengeSelector> {
  int? selectedCIndex;
  int? selectedPyIndex;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final fontSize = (w < 360 ? 13.5 : w < 500 ? 15 : 17).toDouble();
    final padding = EdgeInsets.all((w < 400 ? 10.0 : 24.0).toDouble());
    final baseText = AppTextStyles.body(context).copyWith(fontSize: fontSize);

    return Padding(
      padding: padding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Choose a C Challenge",
                style: baseText.copyWith(fontWeight: FontWeight.bold)),
            DropdownButton<int>(
              hint: Text("Choose a Problem", style: baseText),
              value: selectedCIndex,
              isExpanded: true,
              items: List.generate(
                widget.cProblems.length,
                    (i) => DropdownMenuItem(
                  value: i,
                  child: Text(widget.cProblems[i].title, style: baseText),
                ),
              ),
              onChanged: (i) {
                setState(() {
                  selectedCIndex = i;
                  selectedPyIndex = null;
                });
                if (i != null) {
                  final idx = problems.indexOf(widget.cProblems[i]);
                  widget.controller.pickProblem(idx);
                }
              },
            ),
            SizedBox(height: (w < 400 ? 18.0 : 32.0)),
            Text("Choose a Python Challenge",
                style: baseText.copyWith(fontWeight: FontWeight.bold)),
            DropdownButton<int>(
              hint: Text("Choose a Problem", style: baseText),
              value: selectedPyIndex,
              isExpanded: true,
              items: List.generate(
                widget.pyProblems.length,
                    (i) => DropdownMenuItem(
                  value: i,
                  child: Text(widget.pyProblems[i].title, style: baseText),
                ),
              ),
              onChanged: (i) {
                setState(() {
                  selectedPyIndex = i;
                  selectedCIndex = null;
                });
                if (i != null) {
                  final idx = problems.indexOf(widget.pyProblems[i]);
                  widget.controller.pickProblem(idx);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveChallengeView extends StatelessWidget {
  const ResponsiveChallengeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ChallengeController>();
    final question = controller.currentQuestion;
    final w = MediaQuery.of(context).size.width;
    final isSmall = w < 480;
    final mainFont = (w < 360 ? 13.5 : w < 500 ? 15 : 17).toDouble();
    final optionFont = (w < 360 ? 12.5 : w < 480 ? 14 : 16).toDouble();
    final stepperRadius = (w < 330 ? 9.0 : w < 480 ? 11.0 : 13.0).toDouble();
    final stepperFont = (w < 330 ? 10.5 : w < 480 ? 12.0 : 13.0).toDouble();
    final pad = (w < 400 ? 10.0 : 24.0).toDouble();

    final mainTextStyle = AppTextStyles.body(context).copyWith(fontSize: mainFont);
    final headlineStyle = AppTextStyles.headline(context).copyWith(fontSize: w < 400 ? 17.0 : 20.0);
    final subtitleStyle = AppTextStyles.subtitle(context).copyWith(fontSize: w < 400 ? 12.0 : 15.0);

    return Padding(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.currentProblem.title,
            style: headlineStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: isSmall ? 12.0 : 18.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(controller.totalSteps, (index) {
                bool isActive = index == controller.questionIndex;
                bool isDone = controller.stepsCorrect[index];
                final bgc = isDone
                    ? Colors.green
                    : isActive
                    ? Colors.blue
                    : (Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade600 : Colors.grey.shade300);
                final txtc = isActive || isDone ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: CircleAvatar(
                    radius: stepperRadius,
                    backgroundColor: bgc,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: txtc,
                        fontWeight: FontWeight.bold,
                        fontSize: stepperFont,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: isSmall ? 20.0 : 30.0),
          Text(
            'Step ${controller.questionIndex + 1}/${controller.totalSteps}',
            style: subtitleStyle.copyWith(fontWeight: FontWeight.w600, color: Colors.blueGrey),
          ),
          SizedBox(height: isSmall ? 8.0 : 14.0),
          Text(
            question.prompt,
            style: mainTextStyle.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: isSmall ? 12.0 : 22.0),
          ...List.generate(question.options.length, (i) {
            return Container(
              margin: EdgeInsets.only(bottom: isSmall ? 4.0 : 8.0),
              child: Material(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(isSmall ? 6.0 : 8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(isSmall ? 6.0 : 8.0),
                  onTap: controller.feedback.isEmpty ? () => controller.checkAnswer(i) : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: isSmall ? 8.0 : 12.0, horizontal: isSmall ? 7.0 : 10.0),
                    child: Row(
                      children: [
                        Radio(
                          value: i,
                          groupValue: controller.feedback.isEmpty ? null : question.correctIndex,
                          onChanged: null,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        Flexible(
                          child: Text(
                            question.options[i],
                            style: mainTextStyle.copyWith(fontSize: optionFont),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: isSmall ? 8.0 : 12.0),
          if (controller.feedback.isNotEmpty)
            Text(
              controller.feedback,
              style: mainTextStyle.copyWith(
                  fontSize: mainFont,
                  color: controller.feedback.contains('Correct') ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold),
            ),
          if (controller.showExplanation)
            Container(
              margin: EdgeInsets.only(top: isSmall ? 5.0 : 8.0),
              padding: EdgeInsets.all(isSmall ? 8.0 : 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade900
                    : Colors.yellow.shade50,
                borderRadius: BorderRadius.circular(isSmall ? 5.0 : 8.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Colors.orange, size: isSmall ? 17.0 : 28.0),
                  SizedBox(width: isSmall ? 5.0 : 8.0),
                  Flexible(
                    child: Text(
                      question.explanation,
                      style: mainTextStyle.copyWith(
                        fontSize: isSmall ? 11.0 : 15.0,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.mainText(context)
                            : Colors.black, // good contrast for both themes
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const Spacer(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  icon: Icon(Icons.close, size: isSmall ? 18.0 : 22.0),
                  label: Text('Back to Challenges', style: subtitleStyle),
                  onPressed: () {
                    controller.reset();
                  },
                ),
                if (controller.questionIndex > 0)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isSmall ? 2.0 : 8.0),
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.arrow_back, size: isSmall ? 18.0 : 22.0),
                      label: Text('Previous', style: subtitleStyle),
                      onPressed: controller.previousQuestion,
                    ),
                  ),
                if ((controller.feedback.isNotEmpty || controller.showExplanation) &&
                    controller.questionIndex < controller.totalSteps - 1)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isSmall ? 2.0 : 8.0),
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.arrow_forward, size: isSmall ? 18.0 : 22.0),
                      label: Text('Next', style: subtitleStyle),
                      onPressed: controller.nextQuestion,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
