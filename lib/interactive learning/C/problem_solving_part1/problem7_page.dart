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

class Problem7LargestAnimationPage extends StatefulWidget {
  @override
  State<Problem7LargestAnimationPage> createState() => _Problem7LargestAnimationPageState();
}

class _Problem7LargestAnimationPageState extends State<Problem7LargestAnimationPage> {
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
      case DoWhileStep.intro: step = DoWhileStep.syntax; break;
      case DoWhileStep.syntax: step = DoWhileStep.initVar; break;
      case DoWhileStep.initVar: step = DoWhileStep.codeExample; break;
      case DoWhileStep.codeExample: step = DoWhileStep.firstExec; break;
      case DoWhileStep.firstExec:
        repeatI = 2;
        step = DoWhileStep.repeatCycle; break;
      case DoWhileStep.repeatCycle:
        if (repeatI <= 5) {
          setState(() {
            terminal.add(repeatI.toString());
            memory["i"] = repeatI + 1;
            highlightCond = true;
            condTrue = repeatI + 1 <= 5;
          });
          repeatI++;
          return;
        } else {
          setState(() { step = DoWhileStep.loopEnd; });
        }
        break;
      case DoWhileStep.loopEnd: step = DoWhileStep.flowchart; break;
      case DoWhileStep.flowchart: step = DoWhileStep.condFalseFirst; break;
      case DoWhileStep.condFalseFirst: step = DoWhileStep.compareWhile; break;
      case DoWhileStep.compareWhile: step = DoWhileStep.errorDemo; break;
      case DoWhileStep.errorDemo: step = DoWhileStep.useCase; break;
      case DoWhileStep.useCase: step = DoWhileStep.recapQuiz; break;
      case DoWhileStep.recapQuiz: return;
    }
    _prepareStep();
  }

  void _onPrevious() {
    setState(() {
      infoMsg = null;
      annotation = null;
      errorMsg = null;
    });
    switch (step) {
      case DoWhileStep.syntax: step = DoWhileStep.intro; break;
      case DoWhileStep.initVar: step = DoWhileStep.syntax; break;
      case DoWhileStep.codeExample: step = DoWhileStep.initVar; break;
      case DoWhileStep.firstExec: step = DoWhileStep.codeExample; break;
      case DoWhileStep.repeatCycle: step = DoWhileStep.firstExec; break;
      case DoWhileStep.loopEnd: step = DoWhileStep.repeatCycle; break;
      case DoWhileStep.flowchart: step = DoWhileStep.loopEnd; break;
      case DoWhileStep.condFalseFirst: step = DoWhileStep.flowchart; break;
      case DoWhileStep.compareWhile: step = DoWhileStep.condFalseFirst; break;
      case DoWhileStep.errorDemo: step = DoWhileStep.compareWhile; break;
      case DoWhileStep.useCase: step = DoWhileStep.errorDemo; break;
      case DoWhileStep.recapQuiz: step = DoWhileStep.useCase; break;
      case DoWhileStep.intro: return;
    }
    _prepareStep();
  }

  void _prepareStep() {
    setState(() {
      stepReady = false;
      switch (step) {
        case DoWhileStep.intro:
          code.clear();
          memory.clear();
          terminal.clear();
          infoMsg = "Need to always execute some code at least once? Meet the do-while loop!";
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
          highlightCond = false;
          if (terminal.isEmpty) { repeatI = 2; }
          condTrue = repeatI + 1 <= 5;
          break;
        case DoWhileStep.loopEnd:
          annotation = "After printing 5, i = 6. Condition fails.";
          highlightCond = true;
          condTrue = false;
          break;
        case DoWhileStep.flowchart: flowchartOn = true; break;
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
        case DoWhileStep.recapQuiz: break;
      }
      stepReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final isDark = brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 500.0;
    final textColor = isDark ? Color(0xFFB2FF59) : Colors.black87;
    final annotationColor = isDark ? Color(0xFFA5D6A7) : Colors.orange[900]!;
    final errorColor = isDark ? Colors.redAccent.shade100 : Colors.red[800]!;
    final annotationBg = isDark ? Color(0xFF263238) : Colors.amber[100]!;
    final popupBg = isDark ? Color(0xFF222D22) : Colors.blue[100]!;
    final codeBg = isDark ? Color(0xFF181B1A) : Colors.grey[50]!;
    final highlightBg = isDark ? Color(0xFF33691E) : Colors.yellow[100]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('do-while Loop in C',
            style: TextStyle(color: textColor)),
        centerTitle: true,
        backgroundColor: isDark ? Color(0xFF212121) : null,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 8.0 : 20.0, vertical: 10.0),
                children: [
                  if (infoMsg != null) _popup(infoMsg!, popupBg, textColor),
                  _codeEditor(isMobile, isDark, textColor, annotationColor, highlightBg, errorColor),
                  _memoryGrid(textColor),
                  if (terminal.isNotEmpty)
                    _terminal(isMobile, terminal, isDark),
                  if (annotation != null) _popup(annotation!, annotationBg, annotationColor),
                  if (flowchartOn) _flowchart(isDark, textColor),
                  if (errorMsg != null) _errorBox(errorMsg!, isDark),
                  if (useCase) _useCaseDemo(isDark, textColor),
                  if (step == DoWhileStep.recapQuiz) _recapQuizBox(isDark, textColor),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
            _actionRow(isMobile, isDark, textColor)
          ],
        ),
      ),
    );
  }

  Widget _popup(String text, Color bg, Color fg) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(11.0),
    ),
    child: Text(
      text,
      softWrap: true,
      overflow: TextOverflow.visible,
      style: TextStyle(fontSize: 15.0, color: fg),
    ),
  );

  Widget _codeEditor(bool isMobile, bool isDark, Color textColor, Color annotationColor, Color highlightBg, Color errorColor) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Color(0xFF232323) : Colors.grey[50],
        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.black12, width: 1.2),
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
              (errorMsg != null)) highlight = true;
          return Container(
            decoration: highlight ? BoxDecoration(color: highlightBg.withOpacity(0.25), borderRadius: BorderRadius.circular(6.0)) : null,
            child: RichText(
              text: TextSpan(
                text: l,
                style: TextStyle(
                  fontFamily: "monospace",
                  color: highlight
                      ? (errorMsg != null
                      ? errorColor
                      : l.contains("while") && highlightCond
                      ? (condTrue ? Colors.lightGreenAccent : errorColor)
                      : annotationColor)
                      : textColor,
                  fontSize: 16.0,
                  fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
                  background: highlightCond && l.contains("while")
                      ? (Paint()..color = condTrue ? Colors.green.withOpacity(0.22) : errorColor.withOpacity(0.12))
                      : null,
                ),
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _memoryGrid(Color fg) {
    if (memory.isEmpty) return SizedBox.shrink();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text('Memory:', style: TextStyle(fontWeight: FontWeight.bold, color: fg)),
          SizedBox(width: 10.0),
          ...memory.entries.map((e) => _memoryCell(e.key, e.value, fg)),
        ],
      ),
    );
  }

  Widget _memoryCell(String label, dynamic value, Color fg) => Container(
    margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 7.0),
    padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 12.0),
    decoration: BoxDecoration(
      color: Colors.transparent,
      border: Border.all(color: fg.withOpacity(0.3), width: 2.0),
      borderRadius: BorderRadius.circular(9.0),
    ),
    child: Column(
      children: [
        Text('$label', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: fg)),
        Text(value.toString(), style: TextStyle(fontSize: 15.0, color: fg)),
      ],
    ),
  );

  Widget _terminal(bool isMobile, List<String> lines, bool isDark) => Padding(
    padding: const EdgeInsets.only(top: 7.0),
    child: Container(
      constraints: BoxConstraints(minHeight: 36.0, maxHeight: 130.0),
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.grey[900],
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(
            lines.join('\n'),
            style: TextStyle(color: isDark ? Colors.lightGreenAccent : Colors.greenAccent, fontSize: 15.0),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    ),
  );

  Widget _flowchart(bool isDark, Color textColor) => Container(
    margin: EdgeInsets.symmetric(vertical: 11.0),
    padding: EdgeInsets.all(15.0),
    decoration: BoxDecoration(
      color: isDark ? Color(0xFF1B2C21) : Colors.yellow[50]!,
      borderRadius: BorderRadius.circular(13.0),
      border: Border.all(color: isDark ? Color(0xFF3D9956) : Colors.amber[100]!, width: 1.1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('do-while Loop Flow Chart', style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
        SizedBox(height: 8.0),
        Center(
          child: Column(
            children: [
              Icon(Icons.circle, color: isDark ? Colors.lightGreenAccent : Colors.teal, size: 23.0),
              _verticalArrow(isDark),
              _rectFlow("Body", isDark, textColor),
              _verticalArrow(isDark),
              _diamond("Condition?", isDark, textColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _sideArrow("True", isDark, false, textColor),
                  _sideArrow("False", isDark, true, textColor),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _rectFlow("Repeat", isDark, textColor),
                  SizedBox(width: 45.0),
                  _rectFlow("Exit", isDark, textColor)
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text("Body runs FIRST, then checks condition. If true, repeats; else exits.",
            style: TextStyle(fontSize: 13.0, color: textColor)
        ),
      ],
    ),
  );

  Widget _diamond(String cond, bool isDark, Color textColor) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    child: CustomPaint(
      size: Size(110.0, 40.0),
      painter: _DiamondPainter(isDark),
      child: Container(
        height: 40.0,
        width: 110.0,
        alignment: Alignment.center,
        child: Text(cond,
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: textColor)),
      ),
    ),
  );

  Widget _rectFlow(String txt, bool isDark, Color textColor) => Container(
    width: 90.0,
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    decoration: BoxDecoration(
      color: isDark ? Color(0xFF232A2C) : Colors.green[50]!,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: isDark ? Colors.greenAccent.withOpacity(0.5) : Colors.green[100]!, width: 1.0),
    ),
    child: Text(txt, textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0, color: textColor)),
  );

  Widget _verticalArrow(bool isDark) => Container(
    height: 16.0,
    child: Icon(Icons.arrow_downward, color: isDark ? Colors.lightGreenAccent : Colors.teal, size: 19.0),
  );

  Widget _sideArrow(String label, bool isDark, bool reverse, Color textColor) => Row(
    children: [
      if (!reverse) Icon(Icons.arrow_right, color: isDark ? Colors.lightGreenAccent : Colors.teal, size: 16.0),
      Text(label, style: TextStyle(fontSize: 12.0, color: textColor)),
      if (reverse) Icon(Icons.arrow_left, color: isDark ? Colors.lightGreenAccent : Colors.teal, size: 16.0),
    ],
  );

  Widget _errorBox(String text, bool isDark) => Container(
    margin: EdgeInsets.all(13.0),
    padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 15.0),
    decoration: BoxDecoration(
      color: isDark ? Color(0xFF3D0000) : Colors.red[50]!,
      border: Border.all(color: isDark ? Colors.redAccent : Colors.red[400]!, width: 1.2),
      borderRadius: BorderRadius.circular(11.0),
    ),
    child: Row(
      children: [
        Icon(Icons.error_outline, color: Colors.red, size: 20.0),
        SizedBox(width: 7.0),
        Expanded(
            child: Text(text,
              style: TextStyle(color: isDark ? Colors.redAccent.shade100 : Colors.red[800]!, fontSize: 14.0),
              softWrap: true,
              overflow: TextOverflow.visible,
            )),
      ],
    ),
  );

  Widget _useCaseDemo(bool isDark, Color textColor) => Container(
    margin: EdgeInsets.symmetric(vertical: 11.0, horizontal: 1.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: isDark ? Color(0xFF233949) : Colors.blue[50]!,
      borderRadius: BorderRadius.circular(11.0),
      border: Border.all(color: isDark ? Colors.blueAccent : Colors.blue[100]!, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Real-World Example: User Input", style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
        SizedBox(height: 5.0),
        ...useCaseTerm.map((e) => Container(
          margin: EdgeInsets.only(bottom: 2.0),
          child: Text(e, style: TextStyle(fontSize: 14.0, color: textColor),
              softWrap: true, overflow: TextOverflow.visible),
        ))
      ],
    ),
  );

  Widget _recapQuizBox(bool isDark, Color textColor) => Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(13.0),
    decoration: BoxDecoration(
      color: isDark ? Color(0xFF102921) : Colors.teal[50]!,
      borderRadius: BorderRadius.circular(13.0),
      border: Border.all(color: isDark ? Color(0xFF149d74) : Colors.teal[100]!, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quiz: What does this print?", style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
        SizedBox(height: 6.0),
        Text(
          "int x = 10;\ndo { printf(\"%d\", x); } while (x < 5);",
          style: TextStyle(fontFamily: "monospace", color: textColor, fontSize: 15),
        ),
        SizedBox(height: 9.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? Color(0xFF197278) : Colors.teal,
              foregroundColor: textColor
          ),
          onPressed: () {
            setState(() {
              quizFeedback = "Output: 10\nBecause do-while always runs body at least once!";
            });
          },
          child: Text("Show Answer"),
        ),
        if (quizFeedback != null)
          Padding(
            padding: const EdgeInsets.only(top: 9.0),
            child: Text(quizFeedback!,
                style: TextStyle(color: isDark ? Colors.lightGreenAccent : Colors.green[800], fontWeight: FontWeight.bold)),
          ),
      ],
    ),
  );

  Widget _actionRow(bool isMobile, bool isDark, Color textColor) {
    final canGoPrevious = step != DoWhileStep.intro;
    final canGoNext = step != DoWhileStep.recapQuiz;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: canGoPrevious ? _onPrevious : null,
              icon: Icon(Icons.arrow_back),
              label: Text('Previous'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? Color(0xFF1E3620) : Colors.white,
                foregroundColor: textColor,
                disabledForegroundColor: textColor.withOpacity(0.4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                minimumSize: Size(isMobile ? 90.0 : 110.0, 44.0),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          if (canGoNext)
            Expanded(
              child: ElevatedButton.icon(
                onPressed: stepReady ? _onNext : null,
                icon: Icon(Icons.arrow_forward),
                label: Text('Next'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? Color(0xFF163428) : Colors.teal,
                  foregroundColor: textColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                  textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                  minimumSize: Size(isMobile ? 110.0 : 140.0, 44.0),
                ),
              ),
            ),
          if (!canGoNext)
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: Icon(Icons.done_all),
                label: Text('Finish'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? Colors.green[800] : Colors.green!,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                  textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                  minimumSize: Size(isMobile ? 100.0 : 140.0, 44.0),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DiamondPainter extends CustomPainter {
  final bool isDark;
  _DiamondPainter(this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark ? Color(0xFF80CBC4) : Colors.amber[100]!
      ..strokeWidth = 1.7
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
