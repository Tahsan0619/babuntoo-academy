import 'package:flutter/material.dart';

class Problem4FactorialPage extends StatefulWidget {
  @override
  State<Problem4FactorialPage> createState() => _Problem4FactorialPageState();
}

enum FactStep {
  intro,
  inputShow,
  declareVars,
  loopExplain,
  loopIter,
  afterLoop,
  recap,
}

class _Problem4FactorialPageState extends State<Problem4FactorialPage> {
  int n = 5;
  int i = 1;
  int fact = 1;
  List<int> factTrace = [];
  bool running = false;
  String? infoMsg;
  String? annotation;
  String? terminalOutput;
  FactStep step = FactStep.intro;
  int loopIdx = 1;
  bool stageIsBeforeMultiply = true;
  final List<FactStep> _orderedSteps = FactStep.values;

  @override
  void initState() {
    super.initState();
    _prepareStep();
  }

  void _onNext() {
    setState(() {
      infoMsg = null;
      annotation = null;
      terminalOutput = null;
    });
    switch (step) {
      case FactStep.intro:
        step = FactStep.inputShow;
        break;
      case FactStep.inputShow:
        step = FactStep.declareVars;
        break;
      case FactStep.declareVars:
        step = FactStep.loopExplain;
        break;
      case FactStep.loopExplain:
        i = 1;
        fact = 1;
        factTrace.clear();
        running = true;
        loopIdx = 1;
        stageIsBeforeMultiply = true;
        step = FactStep.loopIter;
        break;
      case FactStep.loopIter:
        if (i <= n) {
          if (stageIsBeforeMultiply) {
            annotation = "Iteration $i: fact = $fact × $i";
            stageIsBeforeMultiply = false;
          } else {
            fact *= i;
            factTrace.add(fact);
            annotation = "After multiplication: fact = $fact";
            i++;
            stageIsBeforeMultiply = true;
          }
        } else {
          running = false;
          step = FactStep.afterLoop;
        }
        break;
      case FactStep.afterLoop:
        terminalOutput = "Factorial of $n = $fact";
        step = FactStep.recap;
        break;
      case FactStep.recap:
        return;
    }
    _prepareStep();
  }

  void _onPrevious() {
    final idx = _orderedSteps.indexOf(step);

    if (step == FactStep.loopIter) {
      if (!stageIsBeforeMultiply && i > 1) {
        setState(() {
          stageIsBeforeMultiply = true;
          i--;
          if (factTrace.isNotEmpty) factTrace.removeLast();
          fact = factTrace.isEmpty ? 1 : factTrace.last;
          annotation = "Back to iteration $i: ready to multiply.";
        });
        return;
      } else if (stageIsBeforeMultiply && i > 1) {
        setState(() {
          stageIsBeforeMultiply = false;
          annotation = "Showing after multiplication at iteration ${i-1}";
        });
        return;
      }
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
        case FactStep.intro:
          i = 1;
          fact = 1;
          factTrace.clear();
          terminalOutput = null;
          annotation = null;
          running = false;
          infoMsg = "Calculate factorial of a user-entered number (n!).";
          stageIsBeforeMultiply = true;
          break;
        case FactStep.inputShow:
          annotation = "Input: n = $n";
          break;
        case FactStep.declareVars:
          annotation =
          "Variable declaration:\nint n, i;\nunsigned long long fact = 1;";
          break;
        case FactStep.loopExplain:
          annotation = "For loop: for (i = 1; i <= n; i++)";
          break;
        case FactStep.loopIter:
        // Handled dynamically step-by-step
          break;
        case FactStep.afterLoop:
          break;
        case FactStep.recap:
          break;
      }
    });
  }

  void onSliderChanged(double v) {
    setState(() {
      n = v.round();
    });
    step = FactStep.intro;
    _prepareStep();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 470.0;
    bool showNext = step != FactStep.recap;
    final mainColor = isDark ? Colors.tealAccent : Colors.black87;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Problem 4: Factorial Calculation",
          style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900]),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : Colors.teal[50],
        iconTheme: IconThemeData(color: isDark ? Colors.tealAccent : Colors.teal[900]),
      ),
      backgroundColor: isDark ? Color(0xFF11161D) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 12.0, horizontal: isMobile ? 9.0 : 22.0),
          child: Column(
            children: [
              Text(
                "Visualize: Calculate factorial of a number (n!)",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 15.0 : 17.0,
                    color: mainColor),
              ),
              SizedBox(height: 20.0),
              Text(
                "Choose n:",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: isMobile ? 12.0 : 15.0,
                  color: mainColor,
                ),
              ),
              Slider(
                value: n.toDouble(),
                min: 2,
                max: 8,
                divisions: 6,
                label: "$n",
                activeColor: isDark ? Colors.tealAccent : Colors.teal,
                inactiveColor: isDark ? Colors.teal[800] : Colors.teal[200],
                onChanged: (v) => onSliderChanged(v),
              ),
              SizedBox(height: 4.0),
              Expanded(
                child: ListView(
                  children: [
                    _factorialCode(isDark),
                    SizedBox(height: 16.0),
                    _memoryDisplay(isDark),
                    SizedBox(height: 14.0),
                    if (annotation != null)
                      _annotationBox(annotation!, isDark),
                    if (terminalOutput != null)
                      _terminalOutput(terminalOutput!, isDark),
                    if (infoMsg != null)
                      _infoBox(infoMsg!, isDark),
                    if (step == FactStep.recap)
                      _recapBox(isDark),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 14, top: 6, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_orderedSteps.indexOf(step) > 0)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton.icon(
                            onPressed: _onPrevious,
                            icon: Icon(Icons.arrow_back,
                                color: isDark ? Colors.tealAccent : Colors.teal),
                            label: Text('Previous Step',
                                style: TextStyle(color: mainColor)),
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                              Size(isMobile ? 100 : 115, 44),
                              backgroundColor:
                              isDark ? Colors.teal[800] : Colors.teal[100],
                              foregroundColor: mainColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0)),
                              textStyle: TextStyle(
                                  fontSize: isMobile ? 15.0 : 17.0),
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton.icon(
                          onPressed: showNext ? _onNext : _onFinish,
                          icon: Icon(
                            showNext ? Icons.arrow_forward : Icons.done,
                            color: isDark ? Colors.tealAccent : Colors.teal,
                          ),
                          label: Text(
                              showNext ? 'Next Step' : 'Finish',
                              style: TextStyle(color: mainColor)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(isMobile ? 100 : 115, 44),
                            backgroundColor:
                            isDark ? Colors.teal[900] : Colors.teal[300],
                            foregroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0)),
                            textStyle: TextStyle(
                                fontSize: isMobile ? 15.0 : 17.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _factorialCode(bool isDark) => Container(
    margin: EdgeInsets.only(top: 10.0, bottom: 7.0),
    padding: EdgeInsets.all(9.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[900] : Colors.grey[50],
      border: Border.all(
          color: isDark
              ? Colors.tealAccent.withOpacity(.13)
              : Colors.blue[100]!,
          width: 1.1),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 15.0,
              color: isDark ? Colors.tealAccent : Colors.black87,
            ),
            children: [
              TextSpan(text: "int n = $n, i;\n"),
              TextSpan(
                  text: "unsigned long long fact = 1;\n",
                  style: TextStyle(
                      color: isDark ? Colors.tealAccent : Colors.teal[800],
                      fontWeight: FontWeight.w600)),
              TextSpan(
                  text: "for (i = 1; i <= n; i++) {\n",
                  style: TextStyle(
                      color: isDark ? Colors.tealAccent : Colors.teal[900],
                      fontWeight: FontWeight.bold)),
              TextSpan(text: "    fact = fact * i;\n"),
              TextSpan(text: "}\n"),
              TextSpan(
                  text: 'printf("Factorial of %d = %llu", n, fact);',
                  style: TextStyle(
                    color: isDark ? Colors.blue[300] : Colors.blue[700],
                  )),
            ],
          )),
    ),
  );

  Widget _memoryDisplay(bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
    decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.orange[50],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
            color: isDark
                ? Colors.orangeAccent.withOpacity(.3)
                : Colors.orange[200]!,
            width: 1.2)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _memCell("n", n, isDark),
        _memCell("i", i <= n ? i : n, isDark),
        _memCell(
            "fact",
            factTrace.isEmpty ? "1" : factTrace.last.toString(),
            isDark),
      ],
    ),
  );

  Widget _memCell(String label, dynamic value, bool isDark) => Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[850] : Colors.white,
      border: Border.all(
          color: isDark
              ? Colors.orangeAccent.withOpacity(.4)
              : Colors.orange[200]!,
          width: 1.4),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.orangeAccent : Colors.orange[900])),
        Text(value.toString(),
            style: TextStyle(
                fontSize: 15.0,
                color: isDark ? Colors.orangeAccent : Colors.orange[900],
                fontWeight: FontWeight.bold)),
      ],
    ),
  );

  // MAIN FIX: bright annotation text, dark bg for dark theme.
  Widget _annotationBox(String msg, bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[850] : Colors.amber[100],
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(
      msg,
      style: TextStyle(
          fontSize: 15.0,
          color: isDark ? Colors.yellowAccent : Colors.amber[900],
          fontWeight: FontWeight.w700),
    ),
  );

  Widget _terminalOutput(String msg, bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 13.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      color: isDark ? Colors.black87 : Colors.black,
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        msg,
        style: TextStyle(
          color: isDark ? Colors.greenAccent : Colors.greenAccent[400],
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
          fontFamily: "monospace",
        ),
      ),
    ),
  );

  Widget _infoBox(String msg, bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 15.0),
    decoration: BoxDecoration(
      color: isDark
          ? Colors.teal[900]!.withOpacity(.19)
          : Colors.blue[50],
      borderRadius: BorderRadius.circular(11.0),
    ),
    child: Text(
      msg,
      style: TextStyle(
          fontSize: 15.0,
          color: isDark ? Colors.tealAccent : Colors.black87),
    ),
  );

  Widget _recapBox(bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
        color: isDark ? Colors.teal[900]!.withOpacity(.18) : Colors.teal[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
            color: isDark
                ? Colors.tealAccent.withOpacity(.17)
                : Colors.teal[100]!,
            width: 1.3)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recap',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: isDark ? Colors.yellowAccent : Colors.teal[900])),
        SizedBox(height: 8.0),
        Text("• Initialize fact to 1.",
            style: TextStyle(
                fontSize: 15.0,
                color: isDark ? Colors.tealAccent[100] : Colors.black87)),
        Text("• For each i = 1...n, multiply fact × i.",
            style: TextStyle(
                fontSize: 15.0,
                color: isDark ? Colors.tealAccent[100] : Colors.black87)),
        Text("• After the loop, print fact.",
            style: TextStyle(
                fontSize: 15.0,
                color: isDark ? Colors.tealAccent[100] : Colors.black87)),
        SizedBox(height: 12.0),
        Text("Result: $n! = $fact",
            style: TextStyle(
                color: isDark ? Colors.orangeAccent : Colors.orange[900],
                fontWeight: FontWeight.bold,
                fontSize: 16.0)),
      ],
    ),
  );
}
