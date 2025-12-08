import 'package:flutter/material.dart';

enum LogicalStep {
  intro,
  declareVars,
  logicOpTable,
  andDemo,
  orDemo,
  notDemo,
  combineDemo,
  truthTable,
  precedence,
  mistake,
  recap,
  quiz,
}

class LogicalOperatorsPage extends StatefulWidget {
  @override
  State<LogicalOperatorsPage> createState() => _LogicalOperatorsPageState();
}

class _LogicalOperatorsPageState extends State<LogicalOperatorsPage> {
  LogicalStep step = LogicalStep.intro;
  List<String> code = [];
  Map<String, dynamic> memory = {};
  String? infoMsg;
  String? errorMsg;
  String? terminalOutput;
  String? annotation;
  bool showLogicTable = false;
  bool showTruthTable = false;
  bool showPrecedence = false;
  bool showMistake = false;
  bool showQuiz = false;
  String? quizAnswer;
  String? quizFeedback;
  List<String> conditionHighlights = [];
  List<String> evalResults = [];

  final List<LogicalStep> _orderedSteps = LogicalStep.values;

  @override
  void initState() {
    super.initState();
    code = [];
    _prepareStep();
  }

  void _onNext() {
    setState(() {
      annotation = null;
      infoMsg = null;
      terminalOutput = null;
      errorMsg = null;
    });
    switch (step) {
      case LogicalStep.intro: step = LogicalStep.declareVars; break;
      case LogicalStep.declareVars: step = LogicalStep.logicOpTable; break;
      case LogicalStep.logicOpTable: step = LogicalStep.andDemo; break;
      case LogicalStep.andDemo: step = LogicalStep.orDemo; break;
      case LogicalStep.orDemo: step = LogicalStep.notDemo; break;
      case LogicalStep.notDemo: step = LogicalStep.combineDemo; break;
      case LogicalStep.combineDemo: step = LogicalStep.truthTable; break;
      case LogicalStep.truthTable: step = LogicalStep.precedence; break;
      case LogicalStep.precedence: step = LogicalStep.mistake; break;
      case LogicalStep.mistake: step = LogicalStep.recap; break;
      case LogicalStep.recap: step = LogicalStep.quiz; break;
      case LogicalStep.quiz: return;
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
      showLogicTable = false;
      showPrecedence = false;
      showTruthTable = false;
      showMistake = false;
      showQuiz = false;
      annotation = null;
      terminalOutput = null;
      conditionHighlights = [];
      evalResults = [];
      switch (step) {
        case LogicalStep.intro:
          code.clear();
          memory.clear();
          terminalOutput = null;
          infoMsg = "Let's understand logical operators in C!";
          break;
        case LogicalStep.declareVars:
          code = ['int a = 5, b = 8;'];
          memory = {'a': 5, 'b': 8};
          annotation = "Variables a = 5, b = 8";
          break;
        case LogicalStep.logicOpTable:
          showLogicTable = true;
          break;
        case LogicalStep.andDemo:
          code.add('if (a > 0 && b > 0) {');
          code.add('  printf("Both positive");');
          code.add('}');
          conditionHighlights = ["a>0", "b>0"];
          evalResults = ["true", "true"];
          annotation = "Both conditions must be true for AND (&&) to succeed.";
          terminalOutput = "Both positive";
          break;
        case LogicalStep.orDemo:
          code.add('if (a < 0 || b > 0) {');
          code.add('  printf("At least one is positive");');
          code.add('}');
          conditionHighlights = ["a<0", "b>0"];
          evalResults = ["false", "true"];
          annotation = "Only one condition needs to be true for OR (||).";
          terminalOutput = "At least one is positive";
          break;
        case LogicalStep.notDemo:
          code.add('if (!(a < 0)) {');
          code.add('  printf("a is not negative");');
          code.add('}');
          annotation = "NOT (!) inverts the condition inside.";
          terminalOutput = "a is not negative";
          break;
        case LogicalStep.combineDemo:
          code.add('if ((a > 0 && b < 0) || (a == 5)) {');
          code.add('  printf("Complex condition met");');
          code.add('}');
          annotation = "Parentheses control the order. Here, (a == 5) is true, so overall OR is true.";
          terminalOutput = "Complex condition met";
          break;
        case LogicalStep.truthTable:
          showTruthTable = true;
          break;
        case LogicalStep.precedence:
          showPrecedence = true;
          break;
        case LogicalStep.mistake:
          showMistake = true;
          break;
        case LogicalStep.recap:
          annotation = "Logical operators: && = AND, || = OR, ! = NOT.\nUse double symbols!";
          break;
        case LogicalStep.quiz:
          showQuiz = true;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 480.0;
    final isLastStep = step == LogicalStep.quiz;
    final mainColor = isDark ? Colors.tealAccent : Colors.black87;
    bool showNext = (step != LogicalStep.quiz);

    return Scaffold(
      appBar: AppBar(
        title: Text('Logical Operators in C', style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
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
                    vertical: isMobile ? 8.0 : 14.0, horizontal: isMobile ? 8.0 : 18.0),
                children: [
                  if (infoMsg != null)
                    _popup(infoMsg!, isDark: isDark, color: isDark ? Colors.blueGrey[900]!.withOpacity(.18) : Colors.blue[100]!),
                  _codeEditor(isDark),
                  SizedBox(height: 10.0),
                  _memoryGrid(isDark),
                  if (showLogicTable)
                    SingleChildScrollView(scrollDirection: Axis.horizontal, child: _logicTable(isDark)),
                  if (terminalOutput != null) _terminal(isDark),
                  if (conditionHighlights.isNotEmpty)
                    _conditionEval(conditionHighlights, evalResults, isDark),
                  if (annotation != null)
                    _popup(annotation!, isDark: isDark, color: isDark ? Colors.amber[900]!.withOpacity(.13) : Colors.amber[200]!),
                  if (showTruthTable) SingleChildScrollView(scrollDirection: Axis.horizontal, child: _truthTable(isDark)),
                  if (showPrecedence) _precedenceOverlay(isDark),
                  if (showMistake) _mistakeTip(isDark),
                  if (showQuiz) _quizBox(isDark),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _popup(String text, {required bool isDark, required Color color}) => Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(11.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 15.0,
        color: isDark ? Colors.tealAccent : Colors.black87,
        fontWeight: FontWeight.w500,
      ),
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
        padding: const EdgeInsets.symmetric(vertical: 2.5),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: RichText(
            text: TextSpan(
              text: l,
              style: TextStyle(
                fontFamily: "monospace",
                color: l.contains('if') || l.contains("&&") || l.contains("||") || l.contains("!")
                    ? (isDark ? Colors.tealAccent : Colors.blue[700])
                    : (isDark ? Colors.tealAccent[100]! : Colors.black87),
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ))
          .toList(),
    ),
  );

  Widget _memoryGrid(bool isDark) {
    if (memory.isEmpty) return SizedBox.shrink();
    return Row(
      children: [
        Text('Memory:', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
        SizedBox(width: 10.0),
        for (final e in memory.entries)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.white,
              border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(0.2) : Colors.blue[100]!, width: 2),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              children: [
                Text('${e.key}',
                    style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: isDark ? Colors.tealAccent : Colors.black)),
                Text('${e.value}',
                    style: TextStyle(fontSize: 15.0, color: isDark ? Colors.greenAccent : Colors.teal)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _logicTable(bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 11.0),
    padding: EdgeInsets.all(11.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.teal[900]!.withOpacity(.12) : Colors.teal[50],
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.14) : Colors.teal[100]!, width: 1.3),
    ),
    child: DataTable(
      columnSpacing: 20,
      columns: [
        DataColumn(label: Text("Operator", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
        DataColumn(label: Text("Symbol", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
        DataColumn(label: Text("Meaning", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text("AND", style: TextStyle(color: isDark ? Colors.tealAccent[100] : Colors.black))),
          DataCell(Text("&&", style: TextStyle(color: isDark ? Colors.tealAccent[100] : Colors.black))),
          DataCell(Text("Both true", style: TextStyle(color: isDark ? Colors.yellowAccent : Colors.black))),
        ]),
        DataRow(cells: [
          DataCell(Text("OR", style: TextStyle(color: isDark ? Colors.tealAccent[100] : Colors.black))),
          DataCell(Text("||", style: TextStyle(color: isDark ? Colors.tealAccent[100] : Colors.black))),
          DataCell(Text("Either true", style: TextStyle(color: isDark ? Colors.yellowAccent : Colors.black))),
        ]),
        DataRow(cells: [
          DataCell(Text("NOT", style: TextStyle(color: isDark ? Colors.tealAccent[100] : Colors.black))),
          DataCell(Text("!", style: TextStyle(color: isDark ? Colors.tealAccent[100] : Colors.black))),
          DataCell(Text("Negate/invert", style: TextStyle(color: isDark ? Colors.yellowAccent : Colors.black))),
        ]),
      ],
    ),
  );

  Widget _terminal(bool isDark) => Padding(
    padding: const EdgeInsets.only(top: 6.0),
    child: Container(
      constraints: BoxConstraints(minHeight: 36.0, maxHeight: 55.0),
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.black.withOpacity(.96) : Colors.black,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          terminalOutput ?? "",
          style: TextStyle(color: Colors.greenAccent, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  Widget _conditionEval(List<String> cond, List<String> evals, bool isDark) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < cond.length; i++)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 5.0),
              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0),
                color: evals[i] == "true"
                    ? (isDark ? Colors.green[800]!.withOpacity(.17) : Colors.green[100])
                    : (isDark ? Colors.red[900]!.withOpacity(.14) : Colors.red[100]),
                border: Border.all(
                    color: evals[i] == "true"
                        ? (isDark ? Colors.greenAccent : Colors.green)
                        : (isDark ? Colors.redAccent : Colors.red),
                    width: 1.2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(cond[i],
                      style: TextStyle(
                          color: evals[i] == "true"
                              ? (isDark ? Colors.greenAccent : Colors.green[900])
                              : (isDark ? Colors.redAccent : Colors.red[900]),
                          fontWeight: FontWeight.w600)),
                  SizedBox(width: 8.0),
                  Icon(
                    evals[i] == "true" ? Icons.check_circle : Icons.cancel,
                    color: evals[i] == "true"
                        ? (isDark ? Colors.greenAccent : Colors.green)
                        : (isDark ? Colors.redAccent : Colors.redAccent),
                    size: 17.0,
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _truthTable(bool isDark) {
    List<List<dynamic>> rows = [
      [0, 0, 0, 0, 1],
      [0, 1, 0, 1, 1],
      [1, 0, 0, 1, 0],
      [1, 1, 1, 1, 0],
    ];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9.0),
      padding: EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.blueGrey[900]!.withOpacity(.18) : Colors.blue[50],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.14) : Colors.teal[100]!, width: 1.3),
      ),
      child: DataTable(
        columns: [
          DataColumn(label: Text('a', style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
          DataColumn(label: Text('b', style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
          DataColumn(label: Text('a && b', style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
          DataColumn(label: Text('a || b', style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
          DataColumn(label: Text('!a', style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
        ],
        rows: rows
            .map((row) => DataRow(
          cells: row
              .map((cell) => DataCell(Text(cell.toString(),
              style: TextStyle(color: isDark ? Colors.yellowAccent : Colors.teal[900]))))
              .toList(),
        ))
            .toList(),
        columnSpacing: 20,
        headingRowHeight: 32,
        dataRowHeight: 28,
      ),
    );
  }

  Widget _precedenceOverlay(bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
        color: isDark ? Colors.yellow[900]!.withOpacity(.16) : Colors.yellow[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: isDark ? Colors.yellowAccent.withOpacity(.17) : Colors.yellow[200]!, width: 1.1)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Operator Precedence", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
        SizedBox(height: 6.0),
        Text(
            "! (NOT) happens first, then && (AND), then || (OR).\nUse parentheses to control the order.",
            style: TextStyle(fontSize: 13.0, color: isDark ? Colors.tealAccent : Colors.teal[900])),
        SizedBox(height: 7.0),
        Text("Example: !a && b || c",
            style: TextStyle(fontSize: 13.0, color: isDark ? Colors.greenAccent : Colors.teal[800])),
      ],
    ),
  );

  Widget _mistakeTip(bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.red[900]!.withOpacity(.13) : Colors.red[50],
      border: Border.all(color: isDark ? Colors.redAccent : Colors.red[200]!, width: 1.1),
      borderRadius: BorderRadius.circular(11.0),
    ),
    child: Row(
      children: [
        Icon(Icons.error_outline, color: isDark ? Colors.redAccent : Colors.red, size: 19.0),
        SizedBox(width: 10.0),
        Expanded(
            child: Text(
                "Common mistake: use && and || for logical ops (not & or |, those are bitwise).",
                style: TextStyle(color: isDark ? Colors.redAccent : Colors.red[800], fontSize: 14.0, fontWeight: FontWeight.w600))),
      ],
    ),
  );

  Widget _quizBox(bool isDark) {
    String quizQ = "What does if (a != 0 && b > 3) mean?";
    String quizA = "Both a is not zero and b is greater than 3 must be true.";
    String quizHint = 'This is a logical AND: requires both conditions to be true.';
    return Container(
      margin: EdgeInsets.only(top: 13.0, bottom: 10.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.teal[900]!.withOpacity(.14) : Colors.teal[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.13) : Colors.teal[200]!, width: 1.2),
      ),
      child: Column(
        children: [
          if (quizFeedback != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                quizFeedback!,
                style: TextStyle(
                    color: isDark ? Colors.greenAccent : Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ),
          Text(quizQ, style: TextStyle(fontWeight: FontWeight.w500, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
          SizedBox(height: 7.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? Colors.tealAccent.withOpacity(.15) : Colors.teal[100], minimumSize: Size(100.0, 38.0)),
            onPressed: () {
              setState(() {
                quizFeedback = quizA + "\n" + quizHint;
              });
            },
            child: Text("Show Explanation", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
          ),
        ],
      ),
    );
  }
}

