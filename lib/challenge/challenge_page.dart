import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'challenge_controller.dart';
import 'challenge_data.dart';
import '../utils/constants.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChallengeController(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Challenges', style: AppTextStyles.appBar(context)),
          backgroundColor: AppColors.background(context),
          elevation: 0,
        ),
        body: const ChallengeSwitcher(),
        backgroundColor: AppColors.background(context),
      ),
    );
  }
}

class ChallengeSwitcher extends StatelessWidget {
  const ChallengeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChallengeController>(
      builder: (context, controller, _) {
        if (!controller.hasStarted) {
          final cProblems = problems.where((p) => p.language == 'C').toList();
          final pyProblems = problems.where((p) => p.language == 'Python').toList();
          return _DropDownChallengeSelector(
            cProblems: cProblems,
            pyProblems: pyProblems,
            controller: controller,
          );
        } else {
          return const ResponsiveChallengeView();
        }
      },
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
