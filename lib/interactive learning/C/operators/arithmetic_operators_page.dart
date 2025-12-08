import 'package:flutter/material.dart';

enum ArithStep {
  intro,
  declareVars,
  addition,
  subtraction,
  multiplication,
  division,
  modulus,
  floatDivision,
  chainedExpr,
  precedenceTable,
  divideByZero,
  recap,
}

class ArithmeticOperatorsPage extends StatefulWidget {
  @override
  State<ArithmeticOperatorsPage> createState() => _ArithmeticOperatorsPageState();
}

class _ArithmeticOperatorsPageState extends State<ArithmeticOperatorsPage> {
  ArithStep step = ArithStep.intro;
  List<String> code = [];
  Map<String, dynamic> memory = {};
  String? infoMsg;
  String? errorMsg;
  String? annotation;
  String? terminalOutput;
  bool showOperators = false;
  bool showPrecedenceTable = false;
  bool showQuiz = false;
  String? quizAnswer;
  String? quizFeedback;
  String? quizQuestion = "What will 7 % 3 output?";
  String? highlightOp;
  int animIndex = 0;
  List<String> animatedExprSteps = [
    'a + [b * 2] - 1',
    'a + 6 - 1',
    '[a + 6] - 1',
    '16 - 1',
    '15'
  ];

  final List<ArithStep> _orderedSteps = ArithStep.values;

  @override
  void initState() {
    super.initState();
    code = [];
    _prepareStep();
  }

  void _onNext() {
    setState(() {
      infoMsg = null;
      errorMsg = null;
      annotation = null;
      terminalOutput = null;
      highlightOp = null;
    });
    switch(step) {
      case ArithStep.intro: step = ArithStep.declareVars; break;
      case ArithStep.declareVars: step = ArithStep.addition; break;
      case ArithStep.addition: step = ArithStep.subtraction; break;
      case ArithStep.subtraction: step = ArithStep.multiplication; break;
      case ArithStep.multiplication: step = ArithStep.division; break;
      case ArithStep.division: step = ArithStep.modulus; break;
      case ArithStep.modulus: step = ArithStep.floatDivision; break;
      case ArithStep.floatDivision: step = ArithStep.chainedExpr; break;
      case ArithStep.chainedExpr:
        if (animIndex + 1 < animatedExprSteps.length) {
          setState(() => animIndex++);
          return;
        }
        step = ArithStep.precedenceTable; animIndex = 0; break;
      case ArithStep.precedenceTable: step = ArithStep.divideByZero; break;
      case ArithStep.divideByZero: step = ArithStep.recap; break;
      case ArithStep.recap: return;
    }
    _prepareStep();
  }

  void _onPrevious() {
    final idx = _orderedSteps.indexOf(step);
    if (step == ArithStep.chainedExpr && animIndex > 0) {
      setState(() {
        animIndex--;
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
        case ArithStep.intro:
          code.clear();
          memory.clear();
          terminalOutput = null;
          infoMsg = "Let’s explore arithmetic operators in C!";
          showOperators = true;
          showPrecedenceTable = false;
          showQuiz = false;
          break;
        case ArithStep.declareVars:
          showOperators = false;
          code = ['int a = 10, b = 3;'];
          memory = {'a': 10, 'b': 3};
          break;
        case ArithStep.addition:
          code.add('int sum = a + b;');
          memory['sum'] = 13;
          terminalOutput = '13';
          infoMsg = "The + operator adds two numbers.";
          highlightOp = "+";
          break;
        case ArithStep.subtraction:
          code.add('int diff = a - b;');
          memory['diff'] = 7;
          terminalOutput = '7';
          infoMsg = "- subtracts the right operand from the left.";
          highlightOp = "-";
          break;
        case ArithStep.multiplication:
          code.add('int prod = a * b;');
          memory['prod'] = 30;
          terminalOutput = '30';
          infoMsg = "* multiplies two numbers.";
          highlightOp = "*";
          break;
        case ArithStep.division:
          code.add('int div = a / b;');
          memory['div'] = 3; // integer division
          terminalOutput = '3';
          infoMsg = "/ divides; for integers, fraction is dropped.";
          highlightOp = "/";
          break;
        case ArithStep.modulus:
          code.add('int mod = a % b;');
          memory['mod'] = 1;
          terminalOutput = '1';
          infoMsg = "% gives the remainder after division.";
          highlightOp = "%";
          break;
        case ArithStep.floatDivision:
          code.add('float result = (float)a / b;');
          memory['result'] = 3.333333;
          terminalOutput = 'int div: 3  |  float result: 3.333333';
          annotation = "C allows integer and float division. Casting preserves decimals.";
          highlightOp = "/";
          break;
        case ArithStep.chainedExpr:
          code.add('int expr = a + b * 2 - 1;');
          animIndex = 0;
          memory['expr'] = 15;
          terminalOutput = null;
          infoMsg = "Operator precedence: *, /, % (high); +, - (low). Multiplication happens before addition.";
          break;
        case ArithStep.precedenceTable:
          showPrecedenceTable = true;
          break;
        case ArithStep.divideByZero:
          showPrecedenceTable = false;
          code.add('int bad = a / 0;');
          errorMsg = "Cannot divide by zero!";
          break;
        case ArithStep.recap:
          errorMsg = null;
          showQuiz = true;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 520.0;
    final isLastStep = step == ArithStep.recap;
    final mainColor = isDark ? Colors.tealAccent : Colors.black87;
    bool showNext = true;
    if (step == ArithStep.chainedExpr && animIndex + 1 < animatedExprSteps.length) showNext = true;
    else if (step == ArithStep.recap) showNext = false;
    else showNext = true;
    return Scaffold(
      appBar: AppBar(
        title: Text('Arithmetic Operators in C', style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
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
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: isMobile ? 7.0 : 19.0),
                children: [
                  _introOperators(context, isMobile, isDark),
                  _codeEditor(context, isDark),
                  SizedBox(height: 10.0),
                  _memoryGrid(context, isDark),
                  if (terminalOutput != null) _terminal(context, isDark),
                  if (infoMsg != null) _annotBox(context, infoMsg!, isDark ? Colors.teal[800]!.withOpacity(.12) : Colors.blue[100]!),
                  if (errorMsg != null) _errorBox(context, errorMsg!, isDark),
                  if (annotation != null) _annotBox(context, annotation!, isDark ? Colors.amber[800]!.withOpacity(.14) : Colors.amber[400]!),
                  if (step == ArithStep.chainedExpr)
                    _exprEvalSteps(isDark),
                  if (showPrecedenceTable) SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        constraints: BoxConstraints(minWidth: 280),
                        child: _precedenceTable(isDark),
                      )),
                  if (showQuiz) _quizBox(isDark),
                  SizedBox(height: 6.0)
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
            )
          ],
        ),
      ),
    );
  }

  Widget _introOperators(BuildContext context, bool isMobile, bool isDark) {
    if (!showOperators) return SizedBox.shrink();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 8.0),
        padding: EdgeInsets.all(21.0),
        decoration: BoxDecoration(
          color: isDark ? Colors.teal[800]!.withOpacity(.11) : Colors.teal[50],
          borderRadius: BorderRadius.circular(13.0),
          border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(0.18) : Colors.teal[100]!, width: 1.3),
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Text("Operators: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
            ...["+", "-", "*", "/", "%"].map(
                  (op) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 450),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: highlightOp == op
                        ? (isDark ? Colors.yellowAccent.withOpacity(.22) : Colors.yellow[700])
                        : (isDark ? Colors.teal[900] : Colors.teal[200]),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 4.0),
                  child: Text(op,
                      style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.w800,
                          color: highlightOp == op
                              ? (isDark ? Colors.black : Colors.white)
                              : (isDark ? Colors.tealAccent : Colors.teal[900]))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _codeEditor(BuildContext context, bool isDark) => Container(
    margin: EdgeInsets.only(top: 6.0),
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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: RichText(
            text: TextSpan(
              text: l,
              style: TextStyle(
                fontFamily: "monospace",
                color: l.contains('+')
                    ? (isDark ? Colors.tealAccent : Colors.teal[700])
                    : l.contains('-')
                    ? (isDark ? Colors.pink[200] : Colors.pink[800])
                    : l.contains('*')
                    ? (isDark ? Colors.purpleAccent : Colors.purple[900])
                    : l.contains('/')
                    ? (isDark ? Colors.blue[200] : Colors.blue[800])
                    : l.contains('%')
                    ? (isDark ? Colors.orangeAccent : Colors.orange[800])
                    : (isDark ? Colors.tealAccent[100]! : Colors.black87),
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ))
          .toList(),
    ),
  );

  Widget _memoryGrid(BuildContext context, bool isDark) {
    if (memory.isEmpty) return SizedBox.shrink();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text('Memory:', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
          SizedBox(width: 10.0),
          Wrap(
            spacing: 2,
            runSpacing: 4,
            children: memory.entries.map((e) => _memoryCell(
                context: context, label: e.key, value: e.value, op: _guessOp(e.key), isDark: isDark)
            ).toList(),
          )
        ],
      ),
    );
  }

  String? _guessOp(String key) {
    if (key == "sum") return "+";
    if (key == "diff") return "-";
    if (key == "prod") return "*";
    if (key == "div" || key == "result") return "/";
    if (key == "mod") return "%";
    return null;
  }

  Widget _memoryCell({required BuildContext context, required String label, required dynamic value, String? op, required bool isDark}) {
    Color cellColor =
    op == "+"
        ? (isDark ? Colors.teal[900]! : Colors.teal[100]!)
        : op == "-"
        ? (isDark ? Colors.pink[900]! : Colors.pink[50]!)
        : op == "*"
        ? (isDark ? Colors.purple[900]! : Colors.purple[50]!)
        : op == "/"
        ? (isDark ? Colors.blue[900]! : Colors.blue[50]!)
        : op == "%"
        ? (isDark ? Colors.orange[900]! : Colors.orange[50]!)
        : (isDark ? Colors.grey[850]! : Colors.white);

    Color fgColor = isDark ? Colors.tealAccent : Colors.teal[900]!;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 10.0),
      constraints: BoxConstraints(minWidth: 60, maxWidth: 110),
      decoration: BoxDecoration(
        color: cellColor,
        border: Border.all(
            color: cellColor.withOpacity(0.7), width: 2.0),
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: fgColor)),
          SizedBox(height: 2.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
                value == null
                    ? '—'
                    : (value is double
                    ? value.toStringAsFixed(6)
                    : value.toString()),
                style: TextStyle(fontSize: 16.0, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
          ),
        ],
      ),
    );
  }

  Widget _terminal(BuildContext context, bool isDark) => Padding(
    padding: const EdgeInsets.only(top: 7.0, left: 0.0, right: 0.0),
    child: Container(
      constraints: BoxConstraints(minHeight: 40.0, maxHeight: 65.0),
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.black.withOpacity(.92) : Colors.black,
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

  Widget _annotBox(BuildContext context, String text, Color color) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 13.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(text, style: TextStyle(
        fontSize: 15.0,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.tealAccent
            : Colors.black87)),
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

  Widget _exprEvalSteps(bool isDark) {
    if (animatedExprSteps.isEmpty || animIndex == 0) return SizedBox.shrink();
    return Column(
      children: [
        SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            'Evaluating: int expr = a + b * 2 - 1;',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: isDark ? Colors.yellowAccent : Colors.teal[900]),
          ),
        ),
        SizedBox(height: 7.0),
        ...List.generate(
          animIndex + 1,
              (i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                animatedExprSteps[i],
                style: TextStyle(
                    fontSize: 15.0,
                    color: i == animIndex
                        ? (isDark ? Colors.tealAccent : Colors.teal[800])
                        : (isDark ? Colors.teal[200] : Colors.teal[300]),
                    fontWeight: i == animIndex ? FontWeight.bold : FontWeight.normal),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _precedenceTable(bool isDark) {
    List<Map<String, String>> data = [
      {
        "Operator": "* / %",
        "Description": "multiply, divide, mod",
        "Precedence": "1 (high)"
      },
      {
        "Operator": "+ -",
        "Description": "add, subtract",
        "Precedence": "2 (low)"
      },
    ];
    List<String> headers = data.first.keys.toList();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.blueGrey[900]!.withOpacity(.20) : Colors.blue[50],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: isDark ? Colors.blueAccent.withOpacity(.18) : Colors.blue[100]!, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Operator Precedence", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
          Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: headers
                  .map((h) => DataColumn(
                  label: Text(h,
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: isDark ? Colors.tealAccent : Colors.black))))
                  .toList(),
              rows: data
                  .map((row) => DataRow(
                cells: headers
                    .map((col) => DataCell(
                    Text(row[col]!, style: TextStyle(fontSize: 13.0, color: isDark ? Colors.tealAccent[100] : Colors.black87))))
                    .toList(),
              ))
                  .toList(),
              headingRowHeight: 32.0,
              dataRowHeight: 28.0,
              columnSpacing: 11.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
              "Note: *, /, % are evaluated before + and - in an expression.",
              style: TextStyle(fontSize: 13.0, color: isDark ? Colors.tealAccent : Colors.teal[900])),
        ],
      ),
    );
  }

  Widget _quizBox(bool isDark) {
    List<String> options = ["1", "2", "3", "0"];
    return Container(
      margin: EdgeInsets.only(top: 14.0, bottom: 10.0),
      padding: EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.teal[900]!.withOpacity(.11) : Colors.teal[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.14) : Colors.teal[200]!, width: 1.2),
      ),
      child: Column(
        children: [
          if (quizFeedback != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  quizFeedback!,
                  style: TextStyle(
                      color: quizFeedback == "Correct!" ? (isDark ? Colors.greenAccent : Colors.green) : (isDark ? Colors.redAccent : Colors.red),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(quizQuestion!, style: TextStyle(fontWeight: FontWeight.w500, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
          ),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: options
                .map(
                  (o) => SizedBox(
                width: 60,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      quizAnswer = o;
                      quizFeedback = (o == "1")
                          ? "Correct!"
                          : "Try again!";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(30.0, 33.0),
                    backgroundColor:
                    quizAnswer == o
                        ? (isDark ? Colors.tealAccent : Colors.teal[300])
                        : (isDark ? Colors.teal[900] : Colors.teal[100]),
                    foregroundColor: quizAnswer == o
                        ? (isDark ? Colors.black : Colors.white)
                        : (isDark ? Colors.tealAccent : Colors.teal[900]),
                  ),
                  child: FittedBox(child: Text(o, style: TextStyle(fontWeight: FontWeight.bold))),
                ),
              ),
            )
                .toList(),
          )
        ],
      ),
    );
  }
}
