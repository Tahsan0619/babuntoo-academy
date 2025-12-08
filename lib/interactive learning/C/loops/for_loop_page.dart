import 'package:flutter/material.dart';

enum ForLoopStep {
  intro,
  syntax,
  initVar,
  codeCume,
  firstIter,
  loopTrace,
  loopEnd,
  flowchart,
  countDown,
  countByTwo,
  sumDemo,
  infiniteError,
  quiz,
}

class ForLoopPage extends StatefulWidget {
  @override
  State<ForLoopPage> createState() => _ForLoopPageState();
}

class _ForLoopPageState extends State<ForLoopPage> {
  ForLoopStep step = ForLoopStep.intro;
  List<String> code = [];
  Map<String, int> memory = {};
  List<String> terminalLines = [];
  String? infoMsg, annotation;
  int iValue = 1;
  int maxValue = 5;
  int currentIteration = 1;
  bool flowchartOn = false;
  bool countDownDemo = false;
  bool countByTwoDemo = false;
  bool sumDemo = false;
  bool errorDemo = false;
  bool quizOn = false;
  String? errorMsg;
  String? quizResult;
  bool highlightUpdate = false;

  // User-driven counter variables:
  int loopTraceIter = 2;
  int countDownIter = 5;
  int countByTwoIter = 0;
  int sumIter = 1;
  int sumMemoryLocal = 0;

  final List<ForLoopStep> _orderedSteps = ForLoopStep.values;

  @override
  void initState() {
    super.initState();
    _prepareStep();
  }

  void _onNext() {
    setState(() {
      infoMsg = null;
      annotation = null;
      errorMsg = null;
    });

    switch (step) {
      case ForLoopStep.intro:
        step = ForLoopStep.syntax;
        break;
      case ForLoopStep.syntax:
        step = ForLoopStep.initVar;
        break;
      case ForLoopStep.initVar:
        step = ForLoopStep.codeCume;
        break;
      case ForLoopStep.codeCume:
        step = ForLoopStep.firstIter;
        break;
      case ForLoopStep.firstIter:
        loopTraceIter = 2;
        step = ForLoopStep.loopTrace;
        break;
      case ForLoopStep.loopTrace:
        if (loopTraceIter <= 5) {
          setState(() {
            memory["i"] = loopTraceIter;
            terminalLines.add(loopTraceIter.toString());
            annotation = "Update: i = $loopTraceIter.\nCondition: $loopTraceIter <= 5 is ${loopTraceIter <= 5}.";
            highlightUpdate = true;
          });
          loopTraceIter++;
          return;
        }
        highlightUpdate = false;
        annotation = null;
        step = ForLoopStep.loopEnd;
        break;
      case ForLoopStep.loopEnd:
        step = ForLoopStep.flowchart;
        break;
      case ForLoopStep.flowchart:
        step = ForLoopStep.countDown;
        break;
      case ForLoopStep.countDown:
        if (countDownIter >= 1) {
          setState(() {
            memory["i"] = countDownIter;
            terminalLines.add(countDownIter.toString());
          });
          countDownIter--;
          return;
        }
        step = ForLoopStep.countByTwo;
        break;
      case ForLoopStep.countByTwo:
        if (countByTwoIter <= 10) {
          setState(() {
            memory["i"] = countByTwoIter;
            terminalLines.add(countByTwoIter.toString());
          });
          countByTwoIter += 2;
          return;
        }
        step = ForLoopStep.sumDemo;
        break;
      case ForLoopStep.sumDemo:
        if (sumIter <= 5) {
          setState(() {
            memory["i"] = sumIter;
            sumMemoryLocal += sumIter;
            memory["sum"] = sumMemoryLocal;
            terminalLines.add("Step $sumIter: sum = $sumMemoryLocal");
          });
          sumIter++;
          return;
        }
        step = ForLoopStep.infiniteError;
        break;
      case ForLoopStep.infiniteError:
        step = ForLoopStep.quiz;
        break;
      case ForLoopStep.quiz:
        return;
    }
    _prepareStep();
  }

  void _onPrevious() {
    final idx = _orderedSteps.indexOf(step);
    if (step == ForLoopStep.loopTrace && loopTraceIter > 2) {
      setState(() {
        if (loopTraceIter > 2 && terminalLines.isNotEmpty) {
          terminalLines.removeLast();
          loopTraceIter--;
        }
        if (loopTraceIter == 2) {
          highlightUpdate = false;
          annotation = null;
        }
      });
      return;
    }
    if (step == ForLoopStep.countDown && countDownIter < 5) {
      setState(() {
        countDownIter++;
        if (terminalLines.isNotEmpty) terminalLines.removeLast();
      });
      return;
    }
    if (step == ForLoopStep.countByTwo && countByTwoIter > 0) {
      setState(() {
        countByTwoIter -= 2;
        if (terminalLines.isNotEmpty) terminalLines.removeLast();
      });
      return;
    }
    if (step == ForLoopStep.sumDemo && sumIter > 1) {
      setState(() {
        sumIter--;
        if (terminalLines.isNotEmpty) terminalLines.removeLast();
        sumMemoryLocal -= sumIter;
        memory["sum"] = sumMemoryLocal;
        memory["i"] = sumIter > 1 ? sumIter - 1 : 1;
      });
      return;
    }
    if (idx > 0) {
      setState(() {
        step = _orderedSteps[idx - 1];
        _prepareStep();
      });
    }
  }

  void _onFinish() => Navigator.of(context).maybePop();

  void _prepareStep() {
    setState(() {
      switch (step) {
        case ForLoopStep.intro:
          code.clear();
          memory.clear();
          terminalLines.clear();
          infoMsg = "Let’s learn how to repeat actions using the for loop in C!";
          flowchartOn = false;
          countDownDemo = false;
          countByTwoDemo = false;
          sumDemo = false;
          errorDemo = false;
          quizOn = false;
          quizResult = null;
          annotation = null;
          break;
        case ForLoopStep.syntax:
          code = ["for (initialization; condition; update) {", "  // loop body", "}"];
          annotation = null;
          break;
        case ForLoopStep.initVar:
          code = ["int i = 1;"];
          memory = {"i": 1};
          break;
        case ForLoopStep.codeCume:
          code = [
            "int i = 1;",
            "for (i = 1; i <= 5; i++) {",
            '  printf("%d\\n", i);',
            "}"
          ];
          memory = {"i": 1};
          break;
        case ForLoopStep.firstIter:
          currentIteration = 1;
          memory["i"] = 1;
          terminalLines.clear();
          annotation = "Initialization: i = 1.\nCondition: i <= 5 is true.";
          break;
        case ForLoopStep.loopTrace:
          annotation = null;
          highlightUpdate = false;
          break;
        case ForLoopStep.loopEnd:
          memory["i"] = 6;
          annotation = "i = 6, i <= 5 is false. Loop stops.";
          break;
        case ForLoopStep.flowchart:
          flowchartOn = true;
          countDownIter = 5;
          break;
        case ForLoopStep.countDown:
          countDownDemo = true;
          code = [
            "for (i = 5; i > 0; i--) {",
            "  // body",
            "}"
          ];
          terminalLines.clear();
          memory["i"] = 5;
          break;
        case ForLoopStep.countByTwo:
          countDownDemo = false;
          countByTwoDemo = true;
          code = [
            "for (i = 0; i <= 10; i = i + 2) {",
            "  // body",
            "}"
          ];
          terminalLines.clear();
          countByTwoIter = 0;
          memory["i"] = 0;
          break;
        case ForLoopStep.sumDemo:
          countByTwoDemo = false;
          sumDemo = true;
          sumMemoryLocal = 0;
          sumIter = 1;
          code = [
            "int sum = 0;",
            "for (i = 1; i <= 5; i++) {",
            "  sum += i;",
            "}"
          ];
          memory = {"i": 1, "sum": 0};
          terminalLines.clear();
          break;
        case ForLoopStep.infiniteError:
          sumDemo = false;
          errorDemo = true;
          code = [
            "for (i = 1; i <= 5;) {",
            "  // ...",
            "}"
          ];
          errorMsg = "Without update, this can create an infinite loop!";
          break;
        case ForLoopStep.quiz:
          errorDemo = false;
          quizOn = true;
          quizResult = null;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 500.0;
    final isLastStep = step == ForLoopStep.quiz;
    final mainColor = isDark ? Colors.tealAccent : Colors.black87;

    // Show Next for demo/quiz
    bool showNext = true;
    if (step == ForLoopStep.loopTrace && loopTraceIter > 5) showNext = true;
    else if (step == ForLoopStep.countDown && countDownIter < 1) showNext = true;
    else if (step == ForLoopStep.countByTwo && countByTwoIter > 10) showNext = true;
    else if (step == ForLoopStep.sumDemo && sumIter > 5) showNext = true;
    else if (step == ForLoopStep.quiz) showNext = false;
    else showNext = true;

    return Scaffold(
      appBar: AppBar(
        title: Text('for Loop in C', style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
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
                  if (infoMsg != null) _popup(context, infoMsg!, isDark ? Colors.teal[900]!.withOpacity(.13) : Colors.blue[100]!),
                  _codeEditor(context, isMobile, isDark),
                  _memoryGrid(context, isDark),
                  if (terminalLines.isNotEmpty) _terminal(context, isMobile, isDark),
                  if (annotation != null) _popup(context, annotation!, isDark ? Colors.amberAccent.withOpacity(.09) : Colors.amber[100]!),
                  if (flowchartOn) _flowchart(context, isDark),
                  if (errorDemo) _errorBox(context, errorMsg!, isDark),
                  if (quizOn) _quizBox(context, isDark),
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
                          onPressed: _onPrevious,
                          icon: Icon(Icons.arrow_back, color: isDark ? Colors.tealAccent : Colors.teal),
                          label: Text('Previous Step', style: TextStyle(color: mainColor)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(isMobile ? 100 : 115.0, 44.0),
                            backgroundColor: isDark ? Colors.teal[800] : Colors.teal[100],
                            foregroundColor: mainColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                            textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                          ),
                        ),
                      if (showNext && !isLastStep)
                        ElevatedButton.icon(
                          onPressed: _onNext,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _popup(BuildContext context, String text, Color color) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 19.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(11.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 15.0,
        color: Theme.of(context).brightness == Brightness.dark ? Colors.tealAccent : Colors.black87,
      ),
    ),
  );

  Widget _codeEditor(BuildContext context, bool isMobile, bool isDark) => Container(
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[900] : Colors.grey[50],
      border: Border.all(color: Colors.black12, width: 1.2),
      borderRadius: BorderRadius.circular(11.0),
    ),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: code.asMap().entries.map((entry) {
        int idx = entry.key;
        String l = entry.value;
        bool highlight = false;
        if (highlightUpdate && l.contains("i++")) highlight = true;
        if (countDownDemo && l.contains("i--")) highlight = true;
        if (countByTwoDemo && l.contains("i = i + 2")) highlight = true;
        if (sumDemo && (l.contains("sum += i;") || l.contains("int sum ="))) highlight = true;
        if (errorDemo) highlight = true;
        Color tcolor;
        if (highlight) {
          tcolor = isDark ? Colors.yellowAccent : Colors.teal[900]!;
        } else {
          tcolor = isDark ? Colors.tealAccent[100]! : Colors.black87;
        }
        return Container(
          decoration: highlight
              ? BoxDecoration(
              color: isDark ? Colors.yellowAccent.withOpacity(0.09) : Colors.yellow[100],
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
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );

  Widget _memoryGrid(BuildContext context, bool isDark) {
    if (memory.isEmpty) return SizedBox.shrink();
    return Row(
      children: [
        Text('Memory:', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
        SizedBox(width: 10.0),
        ...memory.entries.map((e) => _memoryCell(context, e.key, e.value, isDark)),
      ],
    );
  }

  Widget _memoryCell(BuildContext context, String label, dynamic value, bool isDark) => Container(
    margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 7.0),
    padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 12.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[850] : Colors.white,
      border: Border.all(color: isDark ? Colors.tealAccent : Colors.blue[100]!, width: 2.0),
      borderRadius: BorderRadius.circular(9.0),
    ),
    child: Column(
      children: [
        Text('$label', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: isDark ? Colors.tealAccent : Colors.black)),
        Text(value.toString(),
            style: TextStyle(fontSize: 15.0, color: isDark ? Colors.greenAccent : Colors.teal)),
      ],
    ),
  );

  Widget _terminal(BuildContext context, bool isMobile, bool isDark) => Padding(
    padding: const EdgeInsets.only(top: 7.0, left: 0.0, right: 0.0),
    child: Container(
      constraints: BoxConstraints(minHeight: 36.0, maxHeight: 85.0),
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.black.withOpacity(0.93) : Colors.black,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          terminalLines.join('\n'),
          style: TextStyle(color: Colors.greenAccent, fontSize: 15.0),
        ),
      ),
    ),
  );

  Widget _flowchart(BuildContext context, bool isDark) => Container(
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
        Text('For Loop Flow Chart', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
        SizedBox(height: 8.0),
        Center(
          child: Column(
            children: [
              Icon(Icons.circle, color: isDark ? Colors.tealAccent : Colors.teal, size: 20.0),
              _verticalArrow(isDark),
              _rectFlowWidget(context, "Initialization", isDark),
              _verticalArrow(isDark),
              _diamond(context, "Condition?", isDark),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _sideArrow(context, "Yes", isDark),
                  _sideArrow(context, "No", isDark, reverse: true),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _rectFlowWidget(context, "Body", isDark),
                  SizedBox(width: 50.0),
                  _rectFlowWidget(context, "Exit", isDark)
                ],
              ),
              _verticalArrow(isDark),
              _rectFlowWidget(context, "Update", isDark),
              _verticalArrow(isDark),
              _rectFlowWidget(context, "Back to Condition", isDark),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          "Shows for loop cycle: Init → Condition → Body → Update → (repeat or exit)",
          style: TextStyle(fontSize: 13.0, color: isDark ? Colors.tealAccent : Colors.teal[900]),
        ),
      ],
    ),
  );

  Widget _diamond(BuildContext context, String cond, bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    child: CustomPaint(
      size: Size(95.0, 40.0),
      painter: _DiamondPainter(isDark ? Colors.yellowAccent : Colors.amber[100]!),
      child: Container(
        height: 40.0,
        width: 95.0,
        alignment: Alignment.center,
        child: Text(cond, style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
      ),
    ),
  );

  Widget _rectFlowWidget(BuildContext context, String txt, bool isDark) => Container(
    width: 85.0,
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.teal[800]!.withOpacity(0.24) : Colors.green[50],
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.27) : Colors.green[100]!, width: 1.0),
    ),
    child: Text(txt, textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
  );

  Widget _verticalArrow(bool isDark) => Container(
    height: 14.0,
    child: Icon(Icons.arrow_downward, color: isDark ? Colors.tealAccent : Colors.teal, size: 19.0),
  );

  Widget _sideArrow(BuildContext context, String label, bool isDark, {bool reverse = false}) => Row(
    children: [
      if (!reverse) Icon(Icons.arrow_right, color: isDark ? Colors.tealAccent : Colors.teal, size: 16.0),
      Text(label,
          style: TextStyle(fontSize: 12.0, color: isDark ? Colors.tealAccent : Colors.teal[800])),
      if (reverse) Icon(Icons.arrow_left, color: isDark ? Colors.tealAccent : Colors.teal, size: 16.0),
    ],
  );

  Widget _errorBox(BuildContext context, String text, bool isDark) => Container(
    margin: EdgeInsets.all(13.0),
    padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 15.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.red[900]!.withOpacity(0.13) : Colors.red[50],
      border: Border.all(color: Colors.red[400]!, width: 1.2),
      borderRadius: BorderRadius.circular(11.0),
    ),
    child: Row(
      children: [
        Icon(Icons.error_outline, color: isDark ? Colors.redAccent : Colors.red, size: 20.0),
        SizedBox(width: 7.0),
        Expanded(
            child: Text(text,
                style: TextStyle(
                    color: isDark ? Colors.redAccent : Colors.red[800], fontSize: 14.0))),
      ],
    ),
  );

  Widget _quizBox(BuildContext context, bool isDark) {
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
          Text("Quiz: What will this C code print?\n", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
          Text("for (i = 1; i <= 3; i++) { printf(\"%d \", i); }",
              style: TextStyle(fontFamily: "monospace", color: isDark ? Colors.tealAccent : Colors.black)),
          SizedBox(height: 8.0),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? Colors.yellowAccent.withOpacity(.16) : Colors.teal[200],
                    foregroundColor: isDark ? Colors.tealAccent : Colors.teal[900]
                ),
                onPressed: () {
                  setState(() {
                    quizResult = "1 2 3";
                  });
                },
                child: Text("Show Answer", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
              ),
              if (quizResult != null)
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Text("Output: 1 2 3", style: TextStyle(color: isDark ? Colors.greenAccent : Colors.green[800], fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          SizedBox(height: 6.0),
          if (quizResult != null)
            Text("The loop starts at 1, prints, increments, checks (≤3), and prints up to 3.",
                style: TextStyle(fontSize: 13.0, color: isDark ? Colors.tealAccent : Colors.teal[900])),
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
