import 'package:flutter/material.dart';

enum RelStep {
  intro,
  declareVars,
  equalTo,
  notEqualTo,
  greaterThan,
  lessThan,
  greaterEqual,
  lessEqual,
  charComp,
  operatorsTable,
  decisionMaking,
  recapQuiz,
}

class ProblemSixEvenOddPage extends StatefulWidget {
  @override
  State<ProblemSixEvenOddPage> createState() => _ProblemSixEvenOddPageState();
}

class _ProblemSixEvenOddPageState extends State<ProblemSixEvenOddPage> {
  RelStep step = RelStep.intro;
  List<String> code = [];
  Map<String, dynamic> memory = {};
  String? infoMsg;
  String? errorMsg;
  String? annotation;
  String? terminalOutput;
  String? opHighlight;
  bool showIcons = false;
  bool showTable = false;
  bool showDM = false;
  bool showQuiz = false;
  String? quizSelected;
  String? quizFeedback;
  List<String> quizOptions = ["0", "1", "5", "Error"];

  final List<RelStep> _orderedSteps = RelStep.values;

  @override
  void initState() {
    super.initState();
    code = [];
    _prepareStep();
  }

  void _onNext() {
    setState(() {
      infoMsg = null;
      annotation = null;
      terminalOutput = null;
      errorMsg = null;
      opHighlight = null;
    });
    switch (step) {
      case RelStep.intro: step = RelStep.declareVars; break;
      case RelStep.declareVars: step = RelStep.equalTo; break;
      case RelStep.equalTo: step = RelStep.notEqualTo; break;
      case RelStep.notEqualTo: step = RelStep.greaterThan; break;
      case RelStep.greaterThan: step = RelStep.lessThan; break;
      case RelStep.lessThan: step = RelStep.greaterEqual; break;
      case RelStep.greaterEqual: step = RelStep.lessEqual; break;
      case RelStep.lessEqual: step = RelStep.charComp; break;
      case RelStep.charComp: step = RelStep.operatorsTable; break;
      case RelStep.operatorsTable: step = RelStep.decisionMaking; break;
      case RelStep.decisionMaking: step = RelStep.recapQuiz; break;
      case RelStep.recapQuiz: return;
    }
    _prepareStep();
  }

  void _onPrevious() {
    final idx = _orderedSteps.indexOf(step);
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
      showIcons = false;
      showTable = false;
      showDM = false;
      showQuiz = false;
      annotation = null;
      terminalOutput = null;
      opHighlight = null;

      switch (step) {
        case RelStep.intro:
          infoMsg = "Relational operators compare values and return 1 (true) or 0 (false).";
          showIcons = true;
          break;
        case RelStep.declareVars:
          code = ['int a = 9, b = 4;'];
          memory = {'a': 9, 'b': 4};
          break;
        case RelStep.equalTo:
          code.add('printf("a == b: %d\\n", a == b);');
          terminalOutput = "a == b: 0";
          opHighlight = "==";
          annotation = "Returns 1 if equal, otherwise 0.";
          break;
        case RelStep.notEqualTo:
          code.add('printf("a != b: %d\\n", a != b);');
          terminalOutput = "a != b: 1";
          opHighlight = "!=";
          annotation = "Returns 1 if not equal.";
          break;
        case RelStep.greaterThan:
          code.add('printf("a > b: %d\\n", a > b);');
          terminalOutput = "a > b: 1";
          opHighlight = ">";
          annotation = "Returns 1 when the left is greater.";
          break;
        case RelStep.lessThan:
          code.add('printf("a < b: %d\\n", a < b);');
          terminalOutput = "a < b: 0";
          opHighlight = "<";
          annotation = "Returns 1 when the left is smaller.";
          break;
        case RelStep.greaterEqual:
          code.add('printf("a >= b: %d\\n", a >= b);');
          terminalOutput = "a >= b: 1";
          opHighlight = ">=";
          annotation = "True if left is greater or equal to right.";
          break;
        case RelStep.lessEqual:
          code.add('printf("a <= b: %d\\n", a <= b);');
          terminalOutput = "a <= b: 0";
          opHighlight = "<=";
          annotation = "True if left is smaller or equal to right.";
          break;
        case RelStep.charComp:
          code.add("char x = 'A', y = 'a';");
          memory.addAll({'x': 'A', 'y': 'a'});
          code.add('printf("x < y: %d\\n", x < y);');
          terminalOutput = "x < y: 1";
          annotation = "Works with chars, compared by ASCII value.";
          break;
        case RelStep.operatorsTable:
          showTable = true;
          break;
        case RelStep.decisionMaking:
          showDM = true;
          break;
        case RelStep.recapQuiz:
          showQuiz = true;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 500.0;
    final isLastStep = step == RelStep.recapQuiz;
    final mainColor = isDark ? Colors.tealAccent : Colors.black87;
    bool showNext = (step != RelStep.recapQuiz);

    return Scaffold(
      appBar: AppBar(
        title: Text('Relational Operators in C', style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
        backgroundColor: isDark ? Colors.black : Colors.teal[50],
        iconTheme: IconThemeData(color: isDark ? Colors.tealAccent : Colors.teal[900]),
        centerTitle: true,
      ),
      backgroundColor: isDark ? Color(0xFF11161D) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 10.0 : 18.0, horizontal: isMobile ? 10.0 : 28.0),
                children: [
                  if (infoMsg != null) popup(infoMsg!, isDark: isDark, color: isDark ? Colors.teal[800]!.withOpacity(.14) : Colors.blue[100]!),
                  if (showIcons) _iconPanel(isDark),
                  _codeEditor(isDark),
                  SizedBox(height: 10),
                  _memoryGrid(isDark),
                  if (terminalOutput != null) _terminal(isDark),
                  if (annotation != null) popup(annotation!, isDark: isDark, color: isDark ? Colors.amber[900]!.withOpacity(.13) : Colors.amber[300]!),
                  if (showTable)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _opsTable(isDark),
                    ),
                  if (showDM) _decisionDemo(isDark),
                  if (showQuiz) _quizBox(isDark),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
              child: Wrap(
                spacing: isMobile ? 10.0 : 16.0,
                runSpacing: 7.0,
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget popup(String text, {required bool isDark, required Color color}) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(11.0)),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 15.0,
        color: isDark ? Colors.tealAccent : Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  Widget _iconPanel(bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 7.0),
    padding: EdgeInsets.all(9.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.teal[900]!.withOpacity(.18) : Colors.teal[50],
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.13) : Colors.teal[100]!, width: 1.2),
    ),
    child: Wrap(
      alignment: WrapAlignment.center,
      spacing: 14,
      children: [
        ...["==", "!=", ">", "<", ">=", "<="].map((op) =>
            Container(
              padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 7.0),
              decoration: BoxDecoration(
                color: isDark ? Colors.teal[800] : Colors.teal[100],
                borderRadius: BorderRadius.circular(17.0),
              ),
              child: Text(op,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: isDark ? Colors.tealAccent : Colors.teal[900])),
            ))
      ],
    ),
  );

  Widget _codeEditor(bool isDark) => Container(
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[900] : Colors.grey[50],
      border: Border.all(color: Colors.black12, width: 1.2),
      borderRadius: BorderRadius.circular(12.0),
    ),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: code
          .map((l) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: _codeLine(l, isDark),
      ))
          .toList(),
    ),
  );

  Widget _codeLine(String l, bool isDark) {
    final ops = ["==", "!=", ">", "<", ">=", "<="];
    String opUsed = ops.firstWhere((o) => l.contains(o), orElse: () => "");
    bool highlight = (opUsed.isNotEmpty && opHighlight == opUsed);
    Color hl = highlight
        ? (isDark ? Colors.greenAccent.withOpacity(.12)! : Colors.green[100]!)
        : Colors.transparent;

    return Container(
      decoration: BoxDecoration(
        color: hl,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: RichText(
          text: TextSpan(
            text: l,
            style: TextStyle(
              fontFamily: "monospace",
              color: highlight ? (isDark ? Colors.greenAccent : Colors.green[800]) : (isDark ? Colors.tealAccent[100]! : Colors.black87),
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _memoryGrid(bool isDark) {
    if (memory.isEmpty) return SizedBox.shrink();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text('Memory:', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
          SizedBox(width: 10.0),
          ...memory.entries.map((e) => _memoryCell(e.key, e.value, isDark)),
        ],
      ),
    );
  }

  Widget _memoryCell(String label, dynamic value, bool isDark) => Container(
    margin: EdgeInsets.symmetric(horizontal: 7.0, vertical: 8.0),
    padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 13.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[800] : Colors.white,
      border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.15) : Colors.blue[100]!, width: 2.0),
      borderRadius: BorderRadius.circular(9.0),
    ),
    child: Column(
      children: [
        Text('$label', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: isDark ? Colors.tealAccent : Colors.black87)),
        Text(
            value is String && value.length == 1 ? "'$value'\n(${value.codeUnitAt(0)})" : value.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.0, color: isDark ? Colors.greenAccent : Colors.indigo[700])),
      ],
    ),
  );

  Widget _terminal(bool isDark) => Padding(
    padding: const EdgeInsets.only(top: 7.0, left: 0.0, right: 0.0),
    child: Container(
      constraints: BoxConstraints(minHeight: 34.0, maxHeight: 60.0),
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.black.withOpacity(.95) : Colors.black,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            terminalOutput ?? "",
            style: TextStyle(color: Colors.greenAccent, fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );

  Widget _opsTable(bool isDark) {
    List<Map<String, String>> data = [
      {"Operator": "==", "Description": "Equal to", "Example": "a == b"},
      {"Operator": "!=", "Description": "Not equal to", "Example": "a != b"},
      {"Operator": ">", "Description": "Greater than", "Example": "a > b"},
      {"Operator": "<", "Description": "Less than", "Example": "a < b"},
      {"Operator": ">=", "Description": "Greater or equal", "Example": "a >= b"},
      {"Operator": "<=", "Description": "Less or equal", "Example": "a <= b"},
    ];
    List<String> headers = data.first.keys.toList();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 11.0),
      padding: EdgeInsets.all(11.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.yellow[900]!.withOpacity(.16) : Colors.yellow[50],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: isDark ? Colors.yellowAccent.withOpacity(.15) : Colors.amber[100]!, width: 1.2),
      ),
      child: DataTable(
        columns: headers.map((h) => DataColumn(
          label: Text(h, style: TextStyle(color: isDark ? Colors.yellowAccent : Colors.indigo[900])),
        )).toList(),
        rows: data.map((row) => DataRow(
          cells: headers.map((col) => DataCell(
            Container(
              constraints: BoxConstraints(maxWidth: 102),
              child: Text(row[col]!,
                  style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black87),
                  maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          )).toList(),
        )).toList(),
      ),
    );
  }

  Widget _decisionDemo(bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(13.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.teal[900]!.withOpacity(.15) : Colors.teal[50],
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.12) : Colors.teal[100]!, width: 1.2),
    ),
    child: RichText(
      text: TextSpan(
          style: TextStyle(fontSize: 15.0, color: isDark ? Colors.tealAccent : Colors.black),
          children: [
            TextSpan(text: "Relational operators make decision-making possible:\n\n"),
            TextSpan(text: "if (a < b) {\n   printf(\"a is smaller\");\n}", style: TextStyle(fontFamily: "monospace", color: isDark ? Colors.greenAccent : Colors.teal[900])),
          ]
      ),
    ),
  );

  Widget _quizBox(bool isDark) {
    return Container(
      margin: EdgeInsets.only(top: 13.0, bottom: 10.0),
      padding: EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.teal[900]!.withOpacity(.14) : Colors.teal[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.13) : Colors.teal[200]!, width: 1.2),
      ),
      child: Column(
        children: [
          Text('Quiz: What does printf("%d", 5 < 7) print?',
              style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
          SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 7,
            children: quizOptions.map((opt) =>
                SizedBox(
                  width: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: quizSelected == opt
                          ? (opt == "1" ? (isDark ? Colors.greenAccent : Colors.green[400]) : (isDark ? Colors.redAccent : Colors.red[100]))
                          : (isDark ? Colors.teal[800] : Colors.teal[100]),
                      foregroundColor: isDark ? Colors.black : Colors.teal[900],
                    ),
                    onPressed: () {
                      setState(() {
                        quizSelected = opt;
                        quizFeedback = (opt == "1")
                            ? "Correct! 5<7 is true, so it prints 1."
                            : (opt == "Error"
                            ? "In C, 5<7 yields 1 for true—no error!"
                            : "No, remember: true = 1 in C relational expressions.");
                      });
                    },
                    child: FittedBox(child: Text(opt, style: TextStyle(fontWeight: FontWeight.bold))),
                  ),
                )).toList(),
          ),
          if (quizFeedback != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                quizFeedback!,
                style: TextStyle(
                  color: quizFeedback!.contains("Correct") ? (isDark ? Colors.greenAccent : Colors.green) : (isDark ? Colors.yellowAccent : Colors.red),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
