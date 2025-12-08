import 'package:flutter/material.dart';

enum SwitchStep {
  intro,
  declareVar,
  showSwitch,
  addCases,
  addDefault,
  flowChartMatch,
  executeMatchingCase,
  tryNoMatch,
  fallThrough,
  duplicateCaseError,
  nonIntCaseError,
  charSwitch,
  menuUseCase,
  summaryQuiz,
  recap,
}

class SwitchStatementPage extends StatefulWidget {
  @override
  State<SwitchStatementPage> createState() => _SwitchStatementPageState();
}

class _SwitchStatementPageState extends State<SwitchStatementPage> {
  SwitchStep step = SwitchStep.intro;
  List<String> code = [];
  Map<String, dynamic> memory = {};
  String? infoMsg, annotation, terminal;
  bool highlightSwitch = false;
  int? highlightCaseIdx;
  String? highlightCaseLabel;
  bool highlightDefault = false;
  bool showFlowchart = false;
  bool showError = false;
  String? errorMsg;
  bool fallthroughDemo = false;
  bool charSwitchDemo = false;
  String? charSwitchResult;
  bool menuDemo = false;
  String? menuCommand;
  bool showSummary = false;
  bool showQuiz = false;
  String? quizSelection, quizFeedback;
  bool showRecap = false;
  bool stepReady = true;

  final List<SwitchStep> _orderedSteps = SwitchStep.values;

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

  void _onFinish() {
    Navigator.of(context).maybePop();
  }

  void _prepareStep() {
    setState(() {
      stepReady = false;
      switch (step) {
        case SwitchStep.intro:
          code.clear();
          memory.clear();
          terminal = null;
          infoMsg = "Need to choose between many options? Let’s see how C’s switch statement helps!";
          showFlowchart = false;
          showError = false;
          fallthroughDemo = false;
          charSwitchDemo = false;
          menuDemo = false;
          showRecap = false;
          showQuiz = false;
          showSummary = false;
          quizFeedback = null;
          quizSelection = null;
          annotation = null;
          highlightCaseIdx = null;
          highlightDefault = false;
          highlightSwitch = false;
          highlightCaseLabel = null;
          break;
        case SwitchStep.declareVar:
          code = ["int day = 3;"];
          memory = {"day": 3};
          infoMsg = null;
          annotation = null;
          break;
        case SwitchStep.showSwitch:
          code.add("switch(day) {");
          highlightSwitch = true;
          infoMsg = "We check the value of day.";
          break;
        case SwitchStep.addCases:
          code.addAll([
            "  case 1:",
            '    printf("Monday\\n");',
            "    break;",
            "  case 2:",
            '    printf("Tuesday\\n");',
            "    break;",
            "  case 3:",
            '    printf("Wednesday\\n");',
            "    break;",
          ]);
          highlightCaseIdx = 8; // (now index of 'case 3:')
          break;
        case SwitchStep.addDefault:
          code.addAll([
            "  default:",
            '    printf("Invalid day\\n");',
            "    break;",
            "}"
          ]);
          highlightDefault = true;
          infoMsg = "Default runs if no case matches.";
          break;
        case SwitchStep.flowChartMatch:
          showFlowchart = true;
          highlightCaseLabel = "case 3";
          break;
        case SwitchStep.executeMatchingCase:
          highlightCaseIdx = 8;
          terminal = "Wednesday";
          annotation = "‘break;’ stops further checking.";
          break;
        case SwitchStep.tryNoMatch:
          memory['day'] = 7;
          code[0] = "int day = 7;";
          highlightDefault = true;
          terminal = "Invalid day";
          annotation = "None of the cases match – ‘default’ runs.";
          break;
        case SwitchStep.fallThrough:
          fallthroughDemo = true;
          memory['day'] = 2;
          code[0] = "int day = 2;";
          terminal = "Tuesday\nWednesday";
          infoMsg = "Without break, C executes the next case too – called ‘fall-through’.";
          break;
        case SwitchStep.duplicateCaseError:
          showError = true;
          errorMsg = "Case values must be unique (e.g., case 2: repeated).";
          break;
        case SwitchStep.nonIntCaseError:
          showError = true;
          errorMsg = "Case values must be integer/constants (not strings).";
          break;
        case SwitchStep.charSwitch:
          charSwitchDemo = true;
          code = [
            "char option = 'a';",
            "switch(option) {",
            "  case 'a': printf(\"Add\\n\"); break;",
            "  case 'd': printf(\"Delete\\n\"); break;",
            "  default: printf(\"Invalid option\\n\");",
            "}"
          ];
          memory = {"option": "a"};
          charSwitchResult = "Add";
          break;
        case SwitchStep.menuUseCase:
          menuDemo = true;
          code = [
            "int cmd = 2;",
            "switch(cmd) {",
            "  case 1: printf(\"Add\"); break;",
            "  case 2: printf(\"Delete\"); break;",
            "  default: printf(\"Unknown\");",
            "}"
          ];
          memory = {"cmd": 2};
          menuCommand = "Delete";
          break;
        case SwitchStep.summaryQuiz:
          showSummary = true;
          showQuiz = true;
          break;
        case SwitchStep.recap:
          showRecap = true;
          break;
      }
      stepReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 520.0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor = isDark ? Colors.white : Colors.black87;
    final isLastStep = step == SwitchStep.recap;

    return Scaffold(
      appBar: AppBar(
        title: Text('Switch Statement in C', style: TextStyle(
          color: Theme.of(context).appBarTheme.foregroundColor ?? mainColor,
        )),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: isMobile ? 7.0 : 20.0),
                children: [
                  if (infoMsg != null) popup(context, infoMsg!, isDark ? Colors.blue[900]!.withOpacity(.15) : Colors.blue[100]!),
                  _codeEditor(context, isMobile),
                  SizedBox(height: 10.0),
                  _memoryGrid(context, isMobile),
                  if (terminal != null) _terminal(context, isMobile, terminal!),
                  if (annotation != null) popup(context, annotation!, isDark ? Colors.amber[900]!.withOpacity(.16) : Colors.amber[100]!),
                  if (showFlowchart) _flowchart(context),
                  if (showError) _errorBox(context, errorMsg ?? ""),
                  if (fallthroughDemo) _fallThroughDemo(context),
                  if (charSwitchDemo) _charSwitchDemo(context),
                  if (menuDemo) _menuUseCaseDemo(context),
                  if (showSummary) _summaryTable(context),
                  if (showQuiz) _quizBox(context),
                  if (showRecap) _recapAnim(context),
                  SizedBox(height: 16.0),
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
                          onPressed: _onFinish,
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

  // POPUP for info/annotation in both themes
  Widget popup(BuildContext context, String text, Color color) => Container(
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
        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87,
      ),
    ),
  );

  // CODE area with highlight colors for dark mode and white mode
  Widget _codeEditor(BuildContext context, bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[50],
        border: Border.all(color: Colors.black12, width: 1.2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: code
            .asMap()
            .entries
            .map((entry) {
          String l = entry.value;
          int idx = entry.key;
          Color? bg;
          if (idx == highlightCaseIdx) bg = isDark ? Colors.tealAccent.withOpacity(0.12) : Colors.teal[100];
          if (highlightCaseLabel != null && l.contains(highlightCaseLabel!))
            bg = isDark ? Colors.tealAccent.withOpacity(0.17) : Colors.teal[100];
          if (highlightSwitch && l.contains("switch(day)"))
            bg = isDark ? Colors.yellowAccent.withOpacity(0.10) : Colors.yellow[100];
          if (highlightDefault && l.contains("default:"))
            bg = isDark ? Colors.orangeAccent.withOpacity(0.15) : Colors.orange[100];
          if (fallthroughDemo && l.contains("case 2:"))
            bg = isDark ? Colors.amber.withOpacity(0.11) : Colors.amber[100];

          Color textColor = (isDark
              ? (l.contains("case") ? Colors.tealAccent
              : l.contains("default") ? Colors.orangeAccent.shade100
              : Colors.white)
              : (l.contains("case") ? Colors.teal[800]!
              : l.contains("default") ? Colors.orange[900]!
              : Colors.black87)
          );

          return Container(
            decoration: bg != null
                ? BoxDecoration(color: bg, borderRadius: BorderRadius.circular(7.0))
                : null,
            child: RichText(
              text: TextSpan(
                text: l,
                style: TextStyle(
                  fontFamily: "monospace",
                  color: textColor,
                  fontSize: 16.0,
                  fontWeight: l.trim().startsWith("case") ||
                      l.trim().startsWith("default")
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
          );
        })
            .toList(),
      ),
    );
  }

  Widget _memoryGrid(BuildContext context, bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (memory.isEmpty) return SizedBox.shrink();
    return Row(
      children: [
        Text('Memory:', style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.tealAccent : Colors.black87,
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
        border: Border.all(color: Colors.blue[100]!, width: 2.0),
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: Column(
        children: [
          Text('$label', style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black)),
          Text(value.toString(), style: TextStyle(
              fontSize: 15.0,
              color: isDark ? Colors.tealAccent : Colors.teal)),
        ],
      ),
    );
  }

  Widget _terminal(BuildContext context, bool isMobile, String content) => Padding(
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
        alignment: Alignment.centerLeft,
        child: Text(
          content,
          style: TextStyle(
              color: Colors.greenAccent,
              fontSize: 15.0,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    ),
  );

  Widget _fallThroughDemo(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Fall-through!", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.orangeAccent : Colors.orange[900])),
          SizedBox(height: 6.0),
          _terminal(context, false, "Tuesday\nWednesday"),
          SizedBox(height: 3.0),
          popup(context, "Without break, C executes the next case too – called ‘fall-through’.", isDark ? Colors.amber[900]!.withOpacity(.18) : Colors.amber[100]!),
        ],
      ),
    );
  }

  Widget _charSwitchDemo(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Switch (char):", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.tealAccent : Colors.teal)),
          memory["option"] == "a"
              ? _terminal(context, false, "Add")
              : memory["option"] == "x"
              ? _terminal(context, false, "Invalid option")
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _menuUseCaseDemo(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Menu Example:", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.blue[200] : Colors.blue[900])),
          (menuCommand != null) ? _terminal(context, false, menuCommand!) : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _flowchart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color defaultFF = isDark ? Colors.tealAccent : Colors.teal;
    Color labelColor = isDark ? Colors.white : Colors.black87;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.yellow.shade900.withOpacity(0.19) : Colors.yellow[50],
        borderRadius: BorderRadius.circular(13.0),
        border: Border.all(color: Colors.amber[100]!, width: 1.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Switch Flow Chart', style: TextStyle(fontWeight: FontWeight.bold, color: labelColor)),
          SizedBox(height: 8.0),
          Center(
            child: Column(
              children: [
                Icon(Icons.circle, color: defaultFF, size: 20.0),
                Container(height: 10.0),
                _diamond("switch(day)\nday = 3", isDark),
                _verticalArrow(isDark: isDark),
                _rectFlowWidget("case 1?", isDark),
                _verticalArrow(run: false, isDark: isDark),
                _rectFlowWidget("case 2?", isDark),
                _verticalArrow(run: false, isDark: isDark),
                _rectFlowWidget("case 3?", isDark),
                _verticalArrow(run: true, isDark: isDark),
                _rectFlowWidget("Wednesday (matched case)", isDark),
                _endTerm(isDark),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Text("Diamond: check value | Block: matched code runs", style: TextStyle(fontSize: 13.0, color: labelColor)),
        ],
      ),
    );
  }

  Widget _diamond(String cond, bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    child: CustomPaint(
      size: Size(110.0, 45.0),
      painter: _DiamondPainter(),
      child: Container(
        height: 45.0,
        width: 110.0,
        alignment: Alignment.center,
        child: Text(cond, textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black)),
      ),
    ),
  );

  Widget _rectFlowWidget(String txt, bool isDark) => Container(
    width: 120.0,
    padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 7.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.teal[900]!.withOpacity(0.34) : Colors.green[50],
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
          color: isDark ? Colors.tealAccent.withOpacity(0.32) : Colors.green[100]!, width: 1.0),
    ),
    child: Text(txt, textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0, color: isDark ? Colors.tealAccent : Colors.black)),
  );

  Widget _verticalArrow({bool run = true, bool isDark = false}) => Container(
    height: run ? 20.0 : 12.0,
    child: Icon(Icons.arrow_downward, color: run ? (isDark ? Colors.tealAccent : Colors.teal) : Colors.grey, size: 19.0),
  );

  Widget _endTerm(bool isDark) => Icon(Icons.stop_circle_outlined, color: isDark ? Colors.tealAccent : Colors.teal, size: 23.0);

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
            child: Text(text,
                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.red[200] : Colors.red[800], fontSize: 14.0))),
      ],
    ),
  );

  Widget _summaryTable(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    List<Map<String, String>> data = [
      {
        "Feature": "Syntax",
        "Example": "switch(expr)",
        "Note": "expr=int/char"
      },
      {
        "Feature": "Case Value",
        "Example": "case 1:",
        "Note": "Unique, integer/char"
      },
      {
        "Feature": "Default",
        "Example": "default:",
        "Note": "Optional, runs if none match"
      },
      {
        "Feature": "Break",
        "Example": "break;",
        "Note": "Stops further checking"
      },
    ];
    List<String> headers = data.first.keys.toList();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 11.0),
      padding: EdgeInsets.all(11.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.yellow[900]!.withOpacity(0.14) : Colors.yellow[50],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.amber[100]!, width: 1.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Switch Statement Table", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
          Divider(),
          DataTable(
            columns: headers
                .map((h) => DataColumn(
                label: Text(h, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: isDark ? Colors.white : Colors.black))))
                .toList(),
            rows: data
                .map((row) => DataRow(
              cells: headers
                  .map((col) => DataCell(
                  Text(row[col]!, style: TextStyle(fontSize: 13.0, color: isDark ? Colors.tealAccent : Colors.black))))
                  .toList(),
            ))
                .toList(),
            headingRowHeight: 32.0,
            dataRowHeight: 28.0,
            columnSpacing: 14.0,
          ),
        ],
      ),
    );
  }

  Widget _quizBox(BuildContext context) {
    List<String> opts = [
      "Only chosen case runs",
      "All subsequent cases run",
      "Error"
    ];
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final labelColor = isDark ? Colors.white : Colors.black;
    final btnTextColor = isDark ? Colors.tealAccent : Colors.teal[900];

    return Container(
      margin: EdgeInsets.only(top: 14.0, bottom: 10.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.teal[900]!.withOpacity(0.18)
            : Colors.teal[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal[200]!, width: 1.2),
      ),
      child: Column(
        children: [
          if (quizFeedback != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 7.0),
              child: Text(
                quizFeedback!,
                style: TextStyle(
                    color: quizFeedback == "Correct!" ? Colors.green : (isDark ? Colors.red[200] : Colors.red),
                    fontWeight: FontWeight.bold),
              ),
            ),
          Text(
              "What happens if there is no break in a switch case?",
              style: TextStyle(fontWeight: FontWeight.w500, color: labelColor)),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 10.0,
            children: opts.map((o) => ElevatedButton(
              onPressed: () {
                setState(() {
                  quizSelection = o;
                  quizFeedback = (o == "All subsequent cases run")
                      ? "Correct!"
                      : "Try again! Without break, all subsequent cases run (fall-through).";
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(130.0, 36.0),
                backgroundColor: quizSelection == o ? (isDark ? Colors.teal[600] : Colors.teal[300]) : (isDark ? Colors.teal[800] : Colors.teal[100]),
                foregroundColor: btnTextColor,
              ),
              child: Text(o),
            )).toList(),
          )
        ],
      ),
    );
  }

  Widget _recapAnim(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(vertical: 13.0),
    padding: EdgeInsets.all(11.0),
    decoration: BoxDecoration(
      color: Colors.teal[900]!.withOpacity(.09),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Switch Recap", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
        SizedBox(height: 6.0),
        Text(
          "Switch is great for handling multi-way choices efficiently!\nAll code execution paths for different values are supported above.",
          style: TextStyle(fontSize: 13.0, color: Theme.of(context).brightness == Brightness.dark ? Colors.tealAccent : Colors.black),
        ),
      ],
    ),
  );
}

// Custom diamond for flowchart (for logic diamond)
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
