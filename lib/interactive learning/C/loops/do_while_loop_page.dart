import 'package:flutter/material.dart';

enum DoWhileStep {
  intro,
  syntax,
  initVar,
  codeExample,
  firstExec,
  repeatCycle,
  loopEnd,
  flowchart,
  condFalseFirst,
  compareWhile,
  errorDemo,
  useCase,
  recapQuiz,
}

class DoWhilePage extends StatefulWidget {
  @override
  State<DoWhilePage> createState() => _DoWhilePageState();
}

class _DoWhilePageState extends State<DoWhilePage> {
  DoWhileStep step = DoWhileStep.intro;
  List<String> code = [];
  Map<String, int> memory = {};
  List<String> terminal = [];
  String? infoMsg, annotation, errorMsg;
  bool highlightDo = false;
  bool highlightWhile = false;
  bool highlightCond = false;
  bool condTrue = false;
  bool flowchartOn = false;
  bool condFalseDemo = false;
  bool whileCompare = false;
  bool errorView = false;
  bool useCase = false;
  String? quizAnswer;
  String? quizFeedback;
  int inputStage = 0;
  List<int> useCaseInputs = [0, -1, 3];
  int useCaseNum = 0;
  List<String> useCaseTerm = [];
  bool stepReady = true;
  int repeatI = 2;
  final List<DoWhileStep> _orderedSteps = DoWhileStep.values;

  @override
  void initState() {
    super.initState();
    _prepareStep();
  }

  void _onNext() {
    final idx = _orderedSteps.indexOf(step);
    if (step == DoWhileStep.repeatCycle && repeatI <= 5) {
      setState(() {
        terminal.add(repeatI.toString());
        memory["i"] = repeatI + 1;
        highlightCond = true;
        condTrue = repeatI + 1 <= 5;
        repeatI++;
      });
      return;
    }
    if (idx < _orderedSteps.length - 1) {
      setState(() => step = _orderedSteps[idx + 1]);
      _prepareStep();
    }
  }

  void _onPrevious() {
    final idx = _orderedSteps.indexOf(step);
    if (step == DoWhileStep.repeatCycle) {
      setState(() => step = DoWhileStep.firstExec);
      _prepareStep();
      return;
    }
    if (idx > 0) {
      setState(() => step = _orderedSteps[idx - 1]);
      _prepareStep();
    }
  }

  void _onFinish() => Navigator.of(context).maybePop();

  void _prepareStep() {
    setState(() {
      stepReady = false;
      switch (step) {
        case DoWhileStep.intro:
          code.clear();
          memory.clear();
          terminal.clear();
          infoMsg = "Need to always execute some code at least once? Meet the do-while loop!";
          annotation = null;
          errorMsg = null;
          flowchartOn = false;
          useCase = false;
          quizFeedback = null;
          break;
        case DoWhileStep.syntax:
          code = [
            "do {",
            "  // loop body",
            "} while (condition);"
          ];
          annotation = null;
          break;
        case DoWhileStep.initVar:
          code = ["int i = 1;"];
          memory = {"i": 1};
          break;
        case DoWhileStep.codeExample:
          code = [
            "int i = 1;",
            "do {",
            '  printf("%d\\n", i);',
            "  i++;",
            "} while (i <= 5);"
          ];
          memory = {"i": 1};
          highlightDo = true;
          highlightWhile = false;
          highlightCond = false;
          annotation = null;
          break;
        case DoWhileStep.firstExec:
          highlightDo = false;
          highlightWhile = false;
          terminal.clear();
          terminal.add("1");
          annotation = "do-while guarantees at least one execution, even if condition is false initially.";
          memory["i"] = 2;
          break;
        case DoWhileStep.repeatCycle:
          repeatI = 2;
          highlightCond = false;
          condTrue = repeatI + 1 <= 5;
          break;
        case DoWhileStep.loopEnd:
          annotation = "After printing 5, i = 6. Condition fails.";
          highlightCond = true;
          condTrue = false;
          break;
        case DoWhileStep.flowchart:
          flowchartOn = true;
          break;
        case DoWhileStep.condFalseFirst:
          condFalseDemo = true;
          code = [
            "int i = 7;",
            "do {",
            '  printf("%d\\n", i);',
            "  i++;",
            "} while (i <= 5);"
          ];
          memory = {"i": 7};
          terminal.clear();
          terminal.add("7");
          annotation = "do-while runs at least once even if condition is false at start!";
          break;
        case DoWhileStep.compareWhile:
          whileCompare = true;
          code = [
            "while (i <= 5) { ... }  // might never run",
            "do { ... } while (i <= 5);  // runs at least once"
          ];
          annotation = "while: may skip body if false\n do-while: always runs first";
          break;
        case DoWhileStep.errorDemo:
          errorMsg = "Remember to add a semicolon after the while condition!";
          code = [
            "do { ... } while (i <= 5)  // <-- semicolon missing"
          ];
          break;
        case DoWhileStep.useCase:
          useCase = true;
          code = [
            "int num;",
            "do {",
            '  printf("Enter a number greater than 0: ");',
            '  scanf("%d", &num);',
            "} while (num <= 0);"
          ];
          terminal.clear();
          useCaseInputs = [0, -1, 3];
          useCaseNum = 0;
          useCaseTerm = [
            "User enters: 0", "Try again: ",
            "User enters: -1", "Try again: ",
            "User enters: 3"
          ];
          inputStage = useCaseTerm.length;
          break;
        case DoWhileStep.recapQuiz:
          break;
      }
      stepReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 500.0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor = isDark ? const Color(0xFFEDEDED) : Colors.black87;
    final isLastStep = step == DoWhileStep.recapQuiz;

    return Scaffold(
      appBar: AppBar(
        title: Text('do-while Loop in C', style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
        backgroundColor: isDark ? Colors.black : Colors.teal[50],
        iconTheme: IconThemeData(color: isDark ? Colors.tealAccent : Colors.teal[900]),
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: isDark ? Color(0xFF11161D) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 8.0 : 20.0, vertical: 10.0),
                children: [
                  if (infoMsg != null)
                    _popup(context, infoMsg!, isDark ? Colors.teal[700]!.withOpacity(.14) : Colors.blue[100]!),
                  _codeEditor(context, isMobile),
                  _memoryGrid(context),
                  if (terminal.isNotEmpty) _terminal(context, isMobile, terminal),
                  if (annotation != null)
                    _popup(context, annotation!, isDark ? Colors.amberAccent.withOpacity(.09) : Colors.amber[100]!),
                  if (flowchartOn) _flowchart(context),
                  if (errorMsg != null) _errorBox(context, errorMsg!),
                  if (useCase) _useCaseDemo(context),
                  if (isLastStep) _recapQuizBox(context),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
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
                          icon: Icon(Icons.arrow_back, color: isDark ? Colors.tealAccent : Colors.teal),
                          label: Text('Previous Step', style: TextStyle(color: mainColor)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(isMobile ? 100 : 115.0, 44.0),
                            backgroundColor: isDark ? Colors.teal[800] : Colors.teal[100],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                            foregroundColor: mainColor,
                            textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                          ),
                        ),
                      if (!isLastStep)
                        ElevatedButton.icon(
                          onPressed: stepReady ? _onNext : null,
                          icon: Icon(Icons.arrow_forward, color: isDark ? Colors.tealAccent : Colors.teal),
                          label: Text('Next Step', style: TextStyle(color: mainColor)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(isMobile ? 100 : 115.0, 44.0),
                            backgroundColor: isDark ? Colors.teal[900] : Colors.teal[300],
                            foregroundColor: mainColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                            textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                          ),
                        ),
                      if (isLastStep)
                        ElevatedButton.icon(
                          onPressed: _onFinish,
                          icon: Icon(Icons.check_circle_outline, color: isDark ? Colors.greenAccent : Colors.teal),
                          label: Text('Finish', style: TextStyle(color: isDark ? Colors.black : Colors.black)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(isMobile ? 100 : 115.0, 44.0),
                            backgroundColor: isDark ? Colors.greenAccent : Colors.tealAccent[700],
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

  Widget _popup(BuildContext context, String text, Color color) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(11.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 15.0,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.tealAccent
            : Colors.black87,
      ),
    ),
  );

  Widget _codeEditor(BuildContext context, bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[50],
        border: Border.all(color: Colors.black12, width: 1.2),
        borderRadius: BorderRadius.circular(11.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: code.map((l) {
          bool highlight = false;
          if ((highlightDo && l.trim().startsWith("do")) ||
              (highlightWhile && l.contains("while")) ||
              (highlightCond && l.contains("while")) ||
              (whileCompare && (l.startsWith('while (') || l.startsWith('do {'))) ||
              (errorMsg != null && l.contains("while"))
          ){
            highlight = true;
          }
          Color tcolor;
          if (highlightCond && l.contains("while")) {
            tcolor = condTrue
                ? (isDark ? Colors.greenAccent : Colors.green[900]!)
                : (isDark ? Colors.redAccent : Colors.red);
          } else if (highlight) {
            tcolor = isDark ? Colors.yellow : Colors.teal[800]!;
          } else {
            tcolor = isDark ? Colors.tealAccent[100]! : Colors.black87;
          }

          return Container(
            decoration: highlight
                ? BoxDecoration(
                color: isDark ? Colors.yellowAccent.withOpacity(0.08) : Colors.yellow[100],
                borderRadius: BorderRadius.circular(6.0))
                : null,
            child: RichText(
              text: TextSpan(
                text: l,
                style: TextStyle(
                  fontFamily: "monospace",
                  color: tcolor,
                  fontSize: 16.0,
                  fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
                  background: highlightCond && l.contains("while")
                      ? (Paint()
                    ..color = condTrue
                        ? Colors.green.withOpacity(0.22)
                        : Colors.red.withOpacity(0.22))
                      : null,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _memoryGrid(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (memory.isEmpty) return SizedBox.shrink();
    return Row(
      children: [
        Text('Memory:', style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.yellowAccent : Colors.teal[900],
        )),
        SizedBox(width: 10.0),
        ...memory.entries.map((e) => _memoryCell(context, e.key, e.value)),
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
        border: Border.all(color: isDark ? Colors.tealAccent : Colors.blue[100]!, width: 2.0),
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: Column(
        children: [
          Text('$label', style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.tealAccent : Colors.black)),
          Text(value.toString(),
              style: TextStyle(
                  fontSize: 15.0, color: isDark ? Colors.greenAccent : Colors.teal)),
        ],
      ),
    );
  }

  Widget _terminal(BuildContext context, bool isMobile, List<String> lines) => Padding(
    padding: const EdgeInsets.only(top: 7.0, left: 0.0, right: 0.0),
    child: Container(
      constraints: BoxConstraints(minHeight: 36.0, maxHeight: 100.0),
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          lines.join('\n'),
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
    ),
  );

  Widget _flowchart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color arrowColor = isDark ? Colors.tealAccent : Colors.teal;
    Color shapeColor = isDark
        ? (Colors.teal[900] ?? Colors.teal).withOpacity(0.34)
        : (Colors.green[50] ?? Colors.green);
    Color textColor = isDark ? Colors.tealAccent : Colors.black;
    Color diamondColor = isDark
        ? Colors.yellowAccent
        : (Colors.amber[100] ??Colors.amber);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 11.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.black.withOpacity(.19) : Colors.yellow[50],
        borderRadius: BorderRadius.circular(13.0),
        border: Border.all(color: isDark ? Colors.yellowAccent.withOpacity(.33) : Colors.amber[100]!, width: 1.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('do-while Loop Flow Chart', style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
          SizedBox(height: 8.0),
          Center(
            child: Column(
              children: [
                Icon(Icons.circle, color: arrowColor, size: 23.0),
                _verticalArrow(arrowColor),
                _rectFlow("Body", shapeColor, textColor),
                _verticalArrow(arrowColor),
                _diamond("Condition?", diamondColor, textColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _sideArrow("True", arrowColor),
                    _sideArrow("False", arrowColor, reverse: true),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _rectFlow("Repeat", shapeColor, textColor),
                    SizedBox(width: 45.0),
                    _rectFlow("Exit", shapeColor, textColor)
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Text("Body runs FIRST, then checks condition. If true, repeats; else exits.",
              style: TextStyle(fontSize: 13.0, color: textColor)),
        ],
      ),
    );
  }

  Widget _diamond(String cond, Color fg, Color text) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    child: CustomPaint(
      size: Size(110.0, 40.0),
      painter: _DiamondPainter(fg),
      child: Container(
        height: 40.0,
        width: 110.0,
        alignment: Alignment.center,
        child: Text(cond, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: text)),
      ),
    ),
  );

  Widget _rectFlow(String txt, Color bg, Color textColor) => Container(
    width: 90.0,
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: bg.withOpacity(.5), width: 1.0),
    ),
    child: Text(txt, textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0, color: textColor)),
  );

  Widget _verticalArrow(Color color) => Container(
    height: 16.0,
    child: Icon(Icons.arrow_downward, color: color, size: 19.0),
  );

  Widget _sideArrow(String label, Color color, {bool reverse = false}) => Row(
    children: [
      if (!reverse) Icon(Icons.arrow_right, color: color, size: 16.0),
      Text(label, style: TextStyle(fontSize: 12.0, color: color, fontWeight: FontWeight.w700)),
      if (reverse) Icon(Icons.arrow_left, color: color, size: 16.0),
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
        Icon(Icons.error_outline, color: Colors.redAccent, size: 20.0),
        SizedBox(width: 7.0),
        Expanded(
            child: Text(text,
                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.redAccent : Colors.red[800], fontSize: 14.0))),
      ],
    ),
  );

  Widget _useCaseDemo(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 11.0, horizontal: 1.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.teal[700]!.withOpacity(.12) : Colors.blue[50],
        borderRadius: BorderRadius.circular(11.0),
        border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.13) : Colors.blue[100]!, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Real-World Example: User Input", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[800])),
          SizedBox(height: 5.0),
          ...useCaseTerm.map((e) => Container(
            margin: EdgeInsets.only(bottom: 2.0),
            child: Text(e, style: TextStyle(fontSize: 14.0, color: isDark ? Colors.tealAccent : Colors.black)),
          ))
        ],
      ),
    );
  }

  Widget _recapQuizBox(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      padding: EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.teal[900]!.withOpacity(.11) : Colors.teal[50],
        borderRadius: BorderRadius.circular(13.0),
        border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.14) : Colors.teal[100]!, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Quiz: What does this print?", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
          SizedBox(height: 6.0),
          Text(
            "int x = 10;\ndo { printf(\"%d\", x); } while (x < 5);",
            style: TextStyle(fontFamily: "monospace", color: isDark ? Colors.tealAccent : Colors.black),
          ),
          SizedBox(height: 9.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                quizFeedback = "Output: 10\nBecause do-while always runs body at least once!";
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? Colors.yellowAccent.withOpacity(.2) : Colors.teal[200],
                foregroundColor: isDark ? Colors.tealAccent : Colors.teal[900]
            ),
            child: Text("Show Answer", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
          ),
          if (quizFeedback != null)
            Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: Text(quizFeedback!,
                  style: TextStyle(color: isDark ? Colors.greenAccent : Colors.green[800], fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}

class _DiamondPainter extends CustomPainter {
  final Color borderColor;
  _DiamondPainter([this.borderColor = const Color(0xFFFFECB3)]);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
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
  bool shouldRepaint(covariant _DiamondPainter oldDelegate) =>
      borderColor != oldDelegate.borderColor;
}
