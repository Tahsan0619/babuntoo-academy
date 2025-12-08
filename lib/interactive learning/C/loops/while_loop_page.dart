import 'package:flutter/material.dart';

enum WhileStep {
  intro,
  syntax,
  initVar,
  codeBuild,
  firstCheck,
  doBody,
  iterate,
  loopEnd,
  flowchart,
  userControlled,
  inputLoop,
  errorDemo,
  compare,
  quiz,
}

class WhileLoopPage extends StatefulWidget {
  @override
  State<WhileLoopPage> createState() => _WhileLoopPageState();
}

class _WhileLoopPageState extends State<WhileLoopPage> {
  WhileStep step = WhileStep.intro;
  List<String> code = [];
  Map<String, int> memory = {};
  List<String> terminal = [];
  String? infoMsg, annotation, errorMsg;
  bool highlightCond = false;
  bool condTrue = false;
  bool flowchart = false;
  bool userCtrlLoop = false;
  int userInput = 8;
  bool inputLoopDemo = false;
  int inputLoopNum = -3;
  List<int> inputTrace = [-3, 0, 5];
  int inputStage = 0;
  bool infLoop = false;
  bool compareWithFor = false;
  bool quizOn = false;
  String? quizFeedback;

  int manualI = 2;
  int userCtrlK = 1;
  int inputLoopI = 0;

  final List<WhileStep> _orderedSteps = WhileStep.values;

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
      case WhileStep.intro:
        step = WhileStep.syntax;
        break;
      case WhileStep.syntax:
        step = WhileStep.initVar;
        break;
      case WhileStep.initVar:
        step = WhileStep.codeBuild;
        break;
      case WhileStep.codeBuild:
        step = WhileStep.firstCheck;
        break;
      case WhileStep.firstCheck:
        step = WhileStep.doBody;
        break;
      case WhileStep.doBody:
        manualI = 2;
        step = WhileStep.iterate;
        break;
      case WhileStep.iterate:
        if (manualI <= 5) {
          setState(() {
            highlightCond = true;
            condTrue = memory["i"]! <= 5;
            terminal.add(manualI.toString());
            memory["i"] = manualI + 1;
            annotation = "i = $manualI, i <= 5: true. Print $manualI, update: i=${manualI + 1}.";
          });
          manualI++;
          return;
        }
        annotation = null;
        step = WhileStep.loopEnd;
        break;
      case WhileStep.loopEnd:
        step = WhileStep.flowchart;
        break;
      case WhileStep.flowchart:
        userCtrlK = 1;
        step = WhileStep.userControlled;
        break;
      case WhileStep.userControlled:
        if (userCtrlK <= userInput) {
          setState(() {
            memory["i"] = userCtrlK + 1;
            terminal.add(userCtrlK.toString());
          });
          userCtrlK++;
          return;
        }
        step = WhileStep.inputLoop;
        break;
      case WhileStep.inputLoop:
        if (inputLoopI < inputTrace.length) {
          setState(() {
            int val = inputTrace[inputLoopI];
            terminal.add(val.toString());
            if (val <= 0) {
              terminal.add("Try again:");
            }
          });
          inputLoopI++;
          return;
        }
        step = WhileStep.errorDemo;
        break;
      case WhileStep.errorDemo:
        step = WhileStep.compare;
        break;
      case WhileStep.compare:
        step = WhileStep.quiz;
        break;
      case WhileStep.quiz:
        return;
    }
    _prepareStep();
  }

  void _onPrevious() {
    final idx = _orderedSteps.indexOf(step);

    // Stepwise undo for iterative steps
    if (step == WhileStep.iterate && manualI > 2) {
      setState(() {
        if (terminal.isNotEmpty) terminal.removeLast();
        manualI--;
        memory["i"] = manualI;
        annotation = manualI > 2
            ? "i = ${manualI - 1}, i <= 5: true. Print ${manualI - 1}, update: i=$manualI."
            : null;
      });
      return;
    }
    if (step == WhileStep.userControlled && userCtrlK > 1) {
      setState(() {
        if (terminal.isNotEmpty) terminal.removeLast();
        userCtrlK--;
        memory["i"] = userCtrlK;
      });
      return;
    }
    if (step == WhileStep.inputLoop && inputLoopI > 0) {
      setState(() {
        inputLoopI--;
        if (terminal.isNotEmpty) {
          if (terminal.last == "Try again:") terminal.removeLast();
          if (terminal.isNotEmpty) terminal.removeLast();
        }
      });
      return;
    }
    // Generic backward movement
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
        case WhileStep.intro:
          code.clear();
          memory.clear();
          terminal.clear();
          infoMsg = "What if you want to repeat something, but don’t know exactly how many times? The while loop helps!";
          flowchart = false;
          userCtrlLoop = false;
          inputLoopDemo = false;
          infLoop = false;
          compareWithFor = false;
          quizOn = false;
          quizFeedback = null;
          annotation = null;
          break;
        case WhileStep.syntax:
          code = ["while (condition) {", "  // loop body", "}"];
          annotation = null;
          break;
        case WhileStep.initVar:
          code = ["int i = 1;"];
          memory = {"i": 1};
          break;
        case WhileStep.codeBuild:
          code = [
            "int i = 1;",
            "while (i <= 5) {",
            '  printf("%d\\n", i);',
            "  i++;",
            "}"
          ];
          memory = {"i": 1};
          break;
        case WhileStep.firstCheck:
          highlightCond = true;
          condTrue = memory["i"]! <= 5;
          annotation = "Checking: i <= 5 → 1 <= 5 is true.";
          break;
        case WhileStep.doBody:
          terminal = ["1"];
          annotation = "Print 1, then i++ → i=2.";
          memory["i"] = 2;
          break;
        case WhileStep.iterate:
          annotation = null;
          highlightCond = false;
          break;
        case WhileStep.loopEnd:
          highlightCond = true;
          condTrue = memory["i"]! <= 5;
          annotation = "i = ${memory["i"]}, i <= 5 is false. Loop ends.";
          break;
        case WhileStep.flowchart:
          flowchart = true;
          break;
        case WhileStep.userControlled:
          flowchart = false;
          userCtrlLoop = true;
          code = [
            "int i = 1;",
            "while (i <= userInput) {",
            '  printf("%d\\n", i);',
            "  i++;",
            "}"
          ];
          terminal.clear();
          memory = {"i": 1, "userInput": userInput};
          break;
        case WhileStep.inputLoop:
          userCtrlLoop = false;
          inputLoopDemo = true;
          code = [
            "int num;",
            'printf("Enter a positive number: ");',
            'scanf("%d", &num);',
            "while (num <= 0) {",
            '  printf("Try again: ");',
            '  scanf("%d", &num);',
            "}"
          ];
          terminal.clear();
          inputLoopI = 0;
          break;
        case WhileStep.errorDemo:
          inputLoopDemo = false;
          infLoop = true;
          code = ["while (1) {", '  printf("Hello");', "}"];
          errorMsg = "Without a changing condition, while loops can run forever (infinite loop)!";
          break;
        case WhileStep.compare:
          infLoop = false;
          compareWithFor = true;
          code = [
            "for (i = 0; i < 10; i++) {...}",
            "while (condition) {...}"
          ];
          annotation = "for: Use when repeat count is known.\nwhile: Use when repeat count is unknown!";
          break;
        case WhileStep.quiz:
          compareWithFor = false;
          quizOn = true;
          quizFeedback = null;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 500.0;
    final isLastStep = step == WhileStep.quiz;
    final mainColor = isDark ? Colors.tealAccent : Colors.black87;

    bool showNext = true;
    if (step == WhileStep.iterate && manualI > 5) showNext = true;
    else if (step == WhileStep.userControlled && userCtrlK > userInput) showNext = true;
    else if (step == WhileStep.inputLoop && inputLoopI >= inputTrace.length) showNext = true;
    else if (step == WhileStep.quiz) showNext = false;
    else showNext = true;

    return Scaffold(
      appBar: AppBar(
        title: Text('while Loop in C', style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
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
                    _popup(context, infoMsg!, isDark ? Colors.teal[900]!.withOpacity(.13) : Colors.blue[100]!),
                  _codeEditor(context, isDark),
                  _memoryGrid(context, isDark),
                  if (terminal.isNotEmpty) _terminal(context, isDark),
                  if (annotation != null)
                    _popup(context, annotation!, isDark ? Colors.amberAccent.withOpacity(.09) : Colors.amber[100]!),
                  if (flowchart) _flowchart(context, isDark),
                  if (errorMsg != null) _errorBox(context, errorMsg!, isDark),
                  if (compareWithFor) _compareTable(context, isDark),
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
    child: Text(text,
        style: TextStyle(
          fontSize: 15.0,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.tealAccent
              : Colors.black87,
        )),
  );

  Widget _codeEditor(BuildContext context, bool isDark) => Container(
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
        if (l.contains("while") && highlightCond) highlight = true;
        if (infLoop || errorMsg != null) highlight = true;
        if (compareWithFor && l.contains('for (')) highlight = true;
        Color tcolor;
        if (highlightCond && l.contains("while")) {
          tcolor = condTrue
              ? (isDark ? Colors.greenAccent : Colors.green[900]!)
              : (isDark ? Colors.redAccent : Colors.red);
        } else if (highlight) {
          tcolor = isDark
              ? (infLoop ? Colors.redAccent : Colors.yellowAccent)
              : (infLoop ? Colors.red : Colors.teal[800]!);
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

  Widget _terminal(BuildContext context, bool isDark) => Padding(
    padding: const EdgeInsets.only(top: 7.0, left: 0.0, right: 0.0),
    child: Container(
      constraints: BoxConstraints(minHeight: 36.0, maxHeight: 100.0),
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.black.withOpacity(0.93) : Colors.black,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          terminal.join('\n'),
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
        Text('While Loop Flow Chart', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
        SizedBox(height: 8.0),
        Center(
          child: Column(
            children: [
              Icon(Icons.circle, color: isDark ? Colors.tealAccent : Colors.teal, size: 23.0),
              _verticalArrow(isDark),
              _diamond(context, "Condition?", isDark),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _sideArrow(context, "True", isDark),
                  _sideArrow(context, "False", isDark, reverse: true),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _rectFlowWidget(context, "Body/Update", isDark),
                  SizedBox(width: 45.0),
                  _rectFlowWidget(context, "Exit", isDark)
                ],
              ),
              _verticalArrow(isDark),
              _rectFlowWidget(context, "Back to Condition", isDark),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          "Shows: Start → Condition (true?) → Loop body → Update → Back to Condition. If false, exit.",
          style: TextStyle(fontSize: 13.0, color: isDark ? Colors.tealAccent : Colors.teal[900]),
        ),
      ],
    ),
  );

  Widget _diamond(BuildContext context, String cond, bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    child: CustomPaint(
      size: Size(100.0, 40.0),
      painter: _DiamondPainter(isDark ? Colors.yellowAccent : Colors.amber[100]!),
      child: Container(
        height: 40.0,
        width: 100.0,
        alignment: Alignment.center,
        child: Text(cond,
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
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
    height: 15.0,
    child: Icon(Icons.arrow_downward, color: isDark ? Colors.tealAccent : Colors.teal, size: 19.0),
  );

  Widget _sideArrow(BuildContext context, String label, bool isDark, {bool reverse = false}) => Row(
    children: [
      if (!reverse) Icon(Icons.arrow_right, color: isDark ? Colors.tealAccent : Colors.teal, size: 16.0),
      Text(label, style: TextStyle(fontSize: 12.0, color: isDark ? Colors.tealAccent : Colors.teal[800])),
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
                style: TextStyle(color: isDark ? Colors.redAccent : Colors.red[800], fontSize: 14.0))),
      ],
    ),
  );

  Widget _compareTable(BuildContext context, bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 14.0),
    padding: EdgeInsets.all(13.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.blueGrey[900]!.withOpacity(.20) : Colors.blue[50],
      borderRadius: BorderRadius.circular(13.0),
      border: Border.all(color: isDark ? Colors.blueAccent.withOpacity(.18) : Colors.blue[100]!, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("for vs while (when to use each)", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
        SizedBox(height: 7.0),
        Table(
          columnWidths: {0: FractionColumnWidth(.35)},
          children: [
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  child: Text("for loop", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  child: Text("Use when repeat count is known.", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  child: Text("while loop", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  child: Text("Use when you don't know how many repeats.", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
            ]),
          ],
        )
      ],
    ),
  );

  Widget _quizBox(BuildContext context, bool isDark) => Container(
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
        Text("Quiz: How many times does this print?", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
        SizedBox(height: 6.0),
        Text(
          "int i = 1;\nwhile (i < 4) { printf(\"%d \", i); i++; }",
          style: TextStyle(fontFamily: "monospace", color: isDark ? Colors.tealAccent : Colors.black),
        ),
        SizedBox(height: 9.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? Colors.yellowAccent.withOpacity(.16) : Colors.teal[200],
              foregroundColor: isDark ? Colors.tealAccent : Colors.teal[900]
          ),
          onPressed: () {
            setState(() {
              quizFeedback = "Output: 1 2 3\nBecause i starts at 1, increments up to 4 (not included)";
            });
          },
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
