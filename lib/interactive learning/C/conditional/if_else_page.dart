import 'package:flutter/material.dart';

enum IfElseStep {
  intro,
  declareVar,
  scenario,
  ifOnly,
  showCondEval,
  execTrueBlock,
  addElse,
  setFalse,
  showCondEvalFalse,
  execElseBlock,
  flowchart,
  nestedIfElse,
  commonMistake,
  useCase,
  recapQuiz,
}

class IfElseStatementsPage extends StatefulWidget {
  @override
  State<IfElseStatementsPage> createState() => _IfElseStatementsPageState();
}

class _IfElseStatementsPageState extends State<IfElseStatementsPage> {
  IfElseStep step = IfElseStep.intro;
  List<String> code = [];
  Map<String, dynamic> memory = {};
  String? infoMsg;
  String? annotation;
  String? terminal;
  bool highlightIf = false;
  bool highlightCond = false;
  bool condTrue = false;
  bool showingFlowchart = false;
  bool showMistake = false;
  bool showUseCase = false;
  bool showQuiz = false;
  String? quizAnswer;
  String? quizFeedback;
  String? gradeTerminal;
  int? marksForGradeDemo;
  bool stepReady = true;

  final List<IfElseStep> _orderedSteps = IfElseStep.values;

  @override
  void initState() {
    super.initState();
    _prepareStep();
  }

  void _onNext() {
    final idx = _orderedSteps.indexOf(step);
    if (idx < _orderedSteps.length - 1) {
      setState(() => step = _orderedSteps[idx + 1]);
      _prepareStep();
    }
  }

  void _onPrevious() {
    final idx = _orderedSteps.indexOf(step);
    if (idx > 0) {
      setState(() => step = _orderedSteps[idx - 1]);
      _prepareStep();
    }
  }

  void _prepareStep() {
    setState(() {
      stepReady = false;
      switch (step) {
        case IfElseStep.intro:
          code.clear();
          memory.clear();
          terminal = null;
          infoMsg = "Programs often need to make decisions. Let’s see how ‘if-else’ works in C!";
          showingFlowchart = false;
          showMistake = false;
          showUseCase = false;
          showQuiz = false;
          quizAnswer = null;
          quizFeedback = null;
          annotation = null;
          highlightIf = false;
          highlightCond = false;
          condTrue = false;
          break;
        case IfElseStep.declareVar:
          code = ["int number = 8;"];
          memory = {"number": 8};
          infoMsg = null;
          annotation = null;
          break;
        case IfElseStep.scenario:
          infoMsg = "Let’s check if a number is even or odd.";
          annotation = null;
          break;
        case IfElseStep.ifOnly:
          code = ["int number = 8;", "if (number % 2 == 0) {", '    printf("Even\\n");', '}'];
          highlightIf = true;
          highlightCond = false;
          condTrue = false;
          annotation = null;
          infoMsg = null;
          terminal = null;
          break;
        case IfElseStep.showCondEval:
          highlightCond = true;
          annotation = "number % 2 = 8 % 2 = 0, then 0 == 0 (true)";
          condTrue = true;
          break;
        case IfElseStep.execTrueBlock:
          highlightIf = false;
          highlightCond = false;
          annotation = "Since the condition is true, only the first block runs.";
          terminal = "Even";
          break;
        case IfElseStep.addElse:
          code.add('else {');
          code.add('    printf("Odd\\n");');
          code.add('}');
          infoMsg = "‘else’ runs if the ‘if’ condition is false.";
          break;
        case IfElseStep.setFalse:
          memory["number"] = 7;
          code.removeWhere((l) => l.startsWith("number ="));
          code.insert(1, "number = 7;");
          condTrue = false;
          break;
        case IfElseStep.showCondEvalFalse:
          highlightIf = true;
          highlightCond = true;
          annotation = "7 % 2 = 1, so 1 == 0 (false)";
          break;
        case IfElseStep.execElseBlock:
          highlightIf = false;
          highlightCond = false;
          terminal = "Odd";
          annotation = "Condition false: ‘else’ block runs.";
          break;
        case IfElseStep.flowchart:
          showingFlowchart = true;
          highlightIf = false;
          highlightCond = false;
          annotation = null;
          break;
        case IfElseStep.nestedIfElse:
          code = [
            "if (number == 0) {",
            '    printf("Zero");',
            "} else if (number % 2 == 0) {",
            '    printf("Even");',
            "} else {",
            '    printf("Odd");',
            "}"
          ];
          memory["number"] = 0;
          terminal = "Zero";
          annotation = "Highlighting flow through nested checks.";
          showingFlowchart = false;
          break;
        case IfElseStep.commonMistake:
          code = ["if (number = 5) { ... }"];
          showMistake = true;
          break;
        case IfElseStep.useCase:
          code = [
            "if (marks >= 80) {",
            '    printf("A grade");',
            "} else if (marks >= 60) {",
            '    printf("B grade");',
            "} else {",
            '    printf("C grade");',
            "}"
          ];
          showUseCase = true;
          marksForGradeDemo = 85;
          gradeTerminal = "A grade";
          showMistake = false;
          break;
        case IfElseStep.recapQuiz:
          showQuiz = true;
          showUseCase = false;
          break;
      }
      stepReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isMobile = media.size.width < 550;
    final mainColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final isLastStep = step == IfElseStep.recapQuiz;

    return Scaffold(
      appBar: AppBar(
        title: Text("if-else Statements in C", style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).appBarTheme.foregroundColor,
        )),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: isMobile ? 7.0 : 16.0, horizontal: isMobile ? 7.0 : 24.0),
                children: [
                  if (infoMsg != null)
                    popup(context, infoMsg!, Theme.of(context).colorScheme.primary.withOpacity(0.13)),
                  _codeEditor(context, isMobile),
                  SizedBox(height: 10.0),
                  _memoryGrid(context, isMobile),
                  if (terminal != null) _terminal(context, isMobile, terminal!),
                  if (annotation != null)
                    popup(context, annotation!, Theme.of(context).colorScheme.secondary.withOpacity(0.13)),
                  if (showingFlowchart) _flowchart(context),
                  if (showMistake)
                    _errorBox(context, "Warning: Did you mean '==' (comparison), not '=' (assignment)?"),
                  if (showUseCase) _gradeDemo(context),
                  if (showQuiz) _recapQuizBox(context),
                  SizedBox(height: 18.0),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: isMobile ? 8.0 : 15.0, horizontal: isMobile ? 7.0 : 20.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final btnSpacing = isMobile ? 10.0 : 16.0;
                  return Wrap(
                    spacing: btnSpacing,
                    runSpacing: btnSpacing,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (_orderedSteps.indexOf(step) > 0)
                        ElevatedButton.icon(
                          onPressed: stepReady ? _onPrevious : null,
                          icon: Icon(Icons.arrow_back),
                          label: Text('Previous Step', style: TextStyle(color: mainColor)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(isMobile ? 100 : 115.0, 44.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                            textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                          ),
                        ),
                      if (!isLastStep)
                        ElevatedButton.icon(
                          onPressed: stepReady && _orderedSteps.indexOf(step) < _orderedSteps.length - 1 ? _onNext : null,
                          icon: Icon(Icons.arrow_forward),
                          label: Text('Next Step', style: TextStyle(color: mainColor)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(isMobile ? 100 : 115.0, 44.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                            textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                          ),
                        ),
                      if (isLastStep)
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).maybePop();
                          },
                          icon: Icon(Icons.check_circle_outline),
                          label: Text('Finish', style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(isMobile ? 100 : 115.0, 44.0),
                            backgroundColor: Colors.tealAccent[700],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                            textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                          ),
                        ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget popup(BuildContext context, String text, Color color) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(11.0),
    ),
    child: Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black87,
        fontSize: 15.0,
      ),
      textAlign: TextAlign.start,
    ),
  );

  Widget _codeEditor(BuildContext context, bool isMobile) => Container(
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.grey[50],
      border: Border.all(color: Colors.black12, width: 1.2),
      borderRadius: BorderRadius.circular(12.0),
    ),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: code
          .map((l) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: RichText(
          text: TextSpan(
            text: l,
            style: TextStyle(
              fontFamily: "monospace",
              color: _highlightLine(context, l),
              fontSize: isMobile ? 14.0 : 16.0,
              fontWeight: (l.contains('if') && highlightIf) || (l.contains('% 2 ==') && highlightCond)
                  ? FontWeight.w700
                  : FontWeight.normal,
              background: (l.contains('% 2 ==') && highlightCond)
                  ? (Paint()
                ..color = condTrue
                    ? Colors.green.withOpacity(0.22)
                    : Colors.red.withOpacity(0.22))
                  : null,
            ),
          ),
          textAlign: TextAlign.start,
        ),
      ))
          .toList(),
    ),
  );

  Color _highlightLine(BuildContext context, String line) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (line.contains('if') && highlightIf)
      return Theme.of(context).colorScheme.primary;
    if (line.contains('% 2 ==') && highlightCond && condTrue)
      return Colors.green[400]!;
    if (line.contains('% 2 ==') && highlightCond && !condTrue)
      return Colors.red[400]!;
    return isDark ? Colors.white : Colors.black87;
  }

  Widget _memoryGrid(BuildContext context, bool isMobile) {
    if (memory.isEmpty) return SizedBox.shrink();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Memory:', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.tealAccent : null)),
        SizedBox(width: 10.0),
        ...memory.entries
            .map((e) => _memoryCell(context, e.key, e.value))
            .toList(),
      ],
    );
  }

  Widget _memoryCell(BuildContext context, String label, dynamic value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 7.0),
      padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        border: Border.all(color: Colors.blue[100]!, width: 2.0),
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: Column(
        children: [
          Text('$label', style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : null)),
          Text(value.toString(), style: TextStyle(
              fontSize: 15.0,
              color: isDark ? Colors.tealAccent : Colors.teal)),
        ],
      ),
    );
  }

  Widget _terminal(BuildContext context, bool isMobile, String content) =>
      Padding(
        padding: const EdgeInsets.only(top: 7.0, left: 0.0, right: 0.0),
        child: Container(
          constraints: BoxConstraints(minHeight: 36.0, maxHeight: 55.0),
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(content, style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 15.0,
                fontWeight: FontWeight.bold)),
          ),
        ),
      );

  Widget _flowchart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.yellow.shade900.withOpacity(0.21)
            : Colors.yellow[50],
        borderRadius: BorderRadius.circular(13.0),
        border: Border.all(color: Colors.amber[100]!, width: 1.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Control Flow (If-Else)', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87)),
          SizedBox(height: 8.0),
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Icon(Icons.circle,
                      color: isDark ? Colors.tealAccent : Colors.teal, size: 20.0),
                  _arrowDown(isDark),
                  _diamond("number % 2 == 0", isDark),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _sideArrow("Yes", reverse: false, isDark: isDark),
                      _sideArrow("No", reverse: true, isDark: isDark),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _flowRect("printf('Even')", isDark),
                      SizedBox(width: 50.0),
                      _flowRect("printf('Odd')", isDark)
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text("Diamond: condition | Left: If true | Right: If false",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13.0,
                  color: isDark ? Colors.white70 : Colors.black87)),
        ],
      ),
    );
  }

  Widget _diamond(String cond, bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    child: CustomPaint(
      size: Size(90.0, 40.0),
      painter: _DiamondPainter(),
      child: Container(
        height: 40.0,
        width: 90.0,
        alignment: Alignment.center,
        child: Text(cond,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black,
            )),
      ),
    ),
  );

  Widget _flowRect(String txt, bool isDark) => Container(
    width: 90.0,
    padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 7.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.teal[900]?.withOpacity(0.33) : Colors.green[50],
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
          color: isDark ? Colors.tealAccent.withOpacity(0.35) : Colors.green[100]!, width: 1.0),
    ),
    child: Text(txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11.5,
          color: isDark ? Colors.tealAccent : Colors.black,
        )),
  );

  Widget _arrowDown(bool isDark) => Container(
    height: 15.0,
    child: Icon(Icons.arrow_downward, color: isDark ? Colors.tealAccent : Colors.teal, size: 19.0),
  );

  Widget _sideArrow(String label, {bool reverse = false, bool isDark = false}) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (!reverse)
        Icon(Icons.arrow_right, color: isDark ? Colors.tealAccent : Colors.teal, size: 17.0),
      Text(label, style: TextStyle(
        fontSize: 12.0,
        color: isDark ? Colors.tealAccent : Colors.teal[800],
        fontWeight: FontWeight.w600,
      )),
      if (reverse)
        Icon(Icons.arrow_left, color: isDark ? Colors.tealAccent : Colors.teal, size: 17.0),
    ],
  );

  Widget _errorBox(BuildContext context, String text) => Container(
    margin: EdgeInsets.all(13.0),
    padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 15.0),
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.red[900]!.withOpacity(0.13)
          : Colors.red[50],
      border: Border.all(color: Colors.red[400]!, width: 1.2),
      borderRadius: BorderRadius.circular(11.0),
    ),
    child: Row(
      children: [
        Icon(Icons.error_outline, color: Colors.red, size: 20.0),
        SizedBox(width: 7.0),
        Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.red[200] : Colors.red[800],
                fontSize: 14.0))),
      ],
    ),
  );

  Widget _gradeDemo(BuildContext context) {
    int marks = marksForGradeDemo ?? 85;
    String grade = gradeTerminal ?? "A grade";
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.all(11.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.blue[900]?.withOpacity(0.13) : Colors.blue[50],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.blue[100]!, width: 1.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Grading System Example:",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black)),
          SizedBox(height: 3.0),
          Text("Given marks = $marks",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14.0, color: isDark ? Colors.white70 : Colors.black)),
          SizedBox(height: 7.0),
          _terminal(context, false, grade)
        ],
      ),
    );
  }

  Widget _recapQuizBox(BuildContext context) {
    List<String> options = ["Even", "Odd"];
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.tealAccent : Colors.teal[900];
    return Container(
      margin: EdgeInsets.only(top: 14.0, bottom: 10.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.teal[900]!.withOpacity(0.15)
            : Colors.teal[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal[200]!, width: 1.2),
      ),
      child: Column(
        children: [
          if (quizFeedback != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                quizFeedback!,
                style: TextStyle(
                  color: quizFeedback == "Correct!"
                      ? Colors.green
                      : (isDark ? Colors.red[200] : Colors.red),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Text(
            "If number = 10, what prints?",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 10.0,
            children: options
                .map(
                  (o) => ElevatedButton(
                onPressed: () {
                  setState(() {
                    quizAnswer = o;
                    quizFeedback = (o == "Even")
                        ? "Correct!"
                        : "Try again! 10 % 2 == 0 is true, so it prints Even.";
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(67.0, 36.0),
                  backgroundColor: quizAnswer == o
                      ? (isDark ? Colors.teal[600] : Colors.teal[400])
                      : (isDark ? Colors.teal[800] : Colors.teal[100]),
                  foregroundColor: textColor,
                ),
                child: Text(o, style: TextStyle(color: textColor, fontSize: 15.0)),
              ),
            )
                .toList(),
          )
        ],
      ),
    );
  }
}

class _DiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amber[100]!
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    Path path = Path();
    path.moveTo(size.width / 2, 0.0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0.0, size.height / 2);
    path.close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant _DiamondPainter oldDelegate) => false;
}
