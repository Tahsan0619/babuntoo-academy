import 'package:flutter/material.dart';

class SumFirstTenPage extends StatefulWidget {
  @override
  State<SumFirstTenPage> createState() => _SumFirstTenPageState();
}

enum SumStep {
  intro,
  declareVars,
  loopEntry,
  insideLoop,
  duringLoop,
  afterLoop,
  codeRecap,
}

class _SumFirstTenPageState extends State<SumFirstTenPage> {
  SumStep step = SumStep.intro;
  List<String> code = [];
  int i = 1;
  int sum = 0;
  List<int> sumByStep = [];
  String? infoMsg;
  bool loopRunning = false;
  String? terminal;
  bool showRecap = false;

  // Store loop state for user stepping
  int loopIdx = 1;

  final List<SumStep> _orderedSteps = SumStep.values;

  @override
  void initState() {
    super.initState();
    _prepareStep();
  }

  void _onNext() {
    setState(() {
      infoMsg = null;
      terminal = null;
      showRecap = false;
    });
    switch (step) {
      case SumStep.intro:
        step = SumStep.declareVars;
        break;
      case SumStep.declareVars:
        step = SumStep.loopEntry;
        break;
      case SumStep.loopEntry:
        step = SumStep.insideLoop;
        break;
      case SumStep.insideLoop:
        i = 1;
        sum = 0;
        loopIdx = 1;
        sumByStep.clear();
        loopRunning = true;
        step = SumStep.duringLoop;
        break;
      case SumStep.duringLoop:
        if (loopIdx <= 10) {
          setState(() {
            i = loopIdx;
            sum += i;
            sumByStep.add(sum);
            loopIdx++;
          });
          return; // stay in this step, next tap = next iteration or exit
        }
        loopRunning = false;
        step = SumStep.afterLoop;
        break;
      case SumStep.afterLoop:
        code.add('printf("Sum: %d", sum);');
        terminal = "Sum: $sum";
        step = SumStep.codeRecap;
        break;
      case SumStep.codeRecap:
        showRecap = true;
        break;
    }
    _prepareStep();
  }

  void _onPrevious() {
    final idx = _orderedSteps.indexOf(step);

    // Allow stepwise undo for duringLoop:
    if (step == SumStep.duringLoop && sumByStep.isNotEmpty) {
      setState(() {
        sumByStep.removeLast();
        if (loopIdx > 1) {
          loopIdx -= 1;
          i = loopIdx;
        }
        sum = sumByStep.isNotEmpty ? sumByStep.last : 0;
      });
      return;
    }

    if (idx > 0) {
      setState(() {
        step = _orderedSteps[idx - 1];
        if (step != SumStep.duringLoop) {
          showRecap = false;
          loopRunning = false;
        }
        _prepareStep();
      });
    }
  }

  void _onFinish() => Navigator.of(context).maybePop();

  void _prepareStep() {
    setState(() {
      switch (step) {
        case SumStep.intro:
          code.clear();
          sum = 0;
          i = 1;
          sumByStep.clear();
          infoMsg = "Sum the first 10 natural numbers.";
          terminal = null;
          showRecap = false;
          loopRunning = false;
          break;
        case SumStep.declareVars:
          code = ["int i, sum = 0;"];
          break;
        case SumStep.loopEntry:
          code = ["int i, sum = 0;", "for (i = 1; i <= 10; i++) {"];
          break;
        case SumStep.insideLoop:
          code = ["int i, sum = 0;", "for (i = 1; i <= 10; i++) {", "  sum += i;", "}"];
          break;
        case SumStep.duringLoop:
        // controlled by user via tap
          break;
        case SumStep.afterLoop:
        // set in onNext
          break;
        case SumStep.codeRecap:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 500.0;
    final isRecap = step == SumStep.codeRecap;
    final mainColor = isDark ? Colors.tealAccent : Colors.black87;

    return Scaffold(
        appBar: AppBar(
            title: Text("Sum of First 10 Natural Numbers",
                style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
            centerTitle: true,
            backgroundColor: isDark ? Colors.black : Colors.teal[50],
            iconTheme: IconThemeData(color: isDark ? Colors.tealAccent : Colors.teal[900])),
        backgroundColor: isDark ? Color(0xFF11161D) : Colors.white,
        body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 10.0 : 22.0, vertical: 10.0),
                    children: [
                      if (infoMsg != null)
                        _popup(infoMsg!,
                            isDark: isDark,
                            color: isDark
                                ? Colors.blueGrey[900]!.withOpacity(.16)
                                : Colors.blue[50]!),
                      _codeEditor(isDark),
                      SizedBox(height: 12.0),
                      _memoryRow(isDark),
                      if (loopRunning) _sumTrace(isDark),
                      if (terminal != null) _terminalBox(terminal!, isDark),
                      if (showRecap) _recapBox(isDark),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 8.0,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (_orderedSteps.indexOf(step) > 0 && !isRecap)
                        ElevatedButton.icon(
                          icon: Icon(Icons.arrow_back, color: isDark ? Colors.tealAccent : Colors.teal),
                          label: Text('Previous Step', style: TextStyle(color: mainColor)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(isMobile ? 100 : 115, 44),
                            backgroundColor: isDark ? Colors.teal[800] : Colors.teal[100],
                            foregroundColor: mainColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                          ),
                          onPressed: _onPrevious,
                        ),
                      if (!isRecap)
                        ElevatedButton.icon(
                          icon: Icon(Icons.arrow_forward, color: isDark ? Colors.tealAccent : Colors.teal),
                          label: Text('Next Step', style: TextStyle(color: mainColor)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(isMobile ? 100 : 115, 44),
                            backgroundColor: isDark ? Colors.teal[900] : Colors.teal[300],
                            foregroundColor: mainColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                          ),
                          onPressed: _onNext,
                        ),
                      if (isRecap)
                        ElevatedButton.icon(
                          icon: Icon(Icons.check_circle_outlined, color: isDark ? Colors.greenAccent : Colors.teal),
                          label: Text('Finish', style: TextStyle(color: isDark ? Colors.black : Colors.black)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(isMobile ? 100 : 120, 44),
                            backgroundColor: isDark ? Colors.greenAccent : Colors.tealAccent[700],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                            textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                          ),
                          onPressed: _onFinish,
                        ),
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget _popup(String text, {required bool isDark, required Color color}) =>
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(11.0)),
        child: Text(text,
            style: TextStyle(
                fontSize: 15.0,
                color: isDark ? Colors.tealAccent : Colors.black87)),
      );

  Widget _codeEditor(bool isDark) => Container(
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[900] : Colors.grey[50],
      border: Border.all(color: Colors.black12, width: 1.2),
      borderRadius: BorderRadius.circular(12.0),
    ),
    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: code.asMap().entries.map((entry) {
        int idx = entry.key;
        String l = entry.value;
        Color? bg;
        if (step == SumStep.declareVars && idx == 0) {
          bg = isDark ? Colors.yellowAccent.withOpacity(.08) : Colors.yellow[100];
        } else if ((step == SumStep.loopEntry && idx == 1) ||
            (step == SumStep.insideLoop && (idx == 1 || idx == 2))) {
          bg = isDark ? Colors.tealAccent.withOpacity(.08) : Colors.teal[50];
        } else if (step == SumStep.insideLoop && idx == 2) {
          bg = isDark ? Colors.blueAccent.withOpacity(.09) : Colors.blue[50];
        } else if (step == SumStep.afterLoop && l.contains("printf")) {
          bg = isDark ? Colors.greenAccent.withOpacity(.10) : Colors.green[100];
        }
        return Container(
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
          decoration: BoxDecoration(
            color: bg ?? Colors.transparent,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              l,
              style: TextStyle(
                fontFamily: "monospace",
                color: bg != null
                    ? (isDark
                    ? Colors.tealAccent
                    : Colors.teal[800])
                    : (isDark ? Colors.tealAccent[100]! : Colors.black87),
                fontSize: 16.0,
                fontWeight: bg != null ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );

  Widget _memoryRow(bool isDark) => Row(
    children: [
      Text('Memory:',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.yellowAccent : Colors.teal[900])),
      SizedBox(width: 10.0),
      _memoryCell("i", loopRunning ? (i <= 10 ? i : 10) : 10, isDark),
      SizedBox(width: 10.0),
      _memoryCell(
          "sum",
          sumByStep.isNotEmpty && loopRunning
              ? sumByStep.last
              : sum,
          isDark),
    ],
  );

  Widget _memoryCell(String label, int value, bool isDark) => Container(
    margin: EdgeInsets.symmetric(horizontal: 6.0),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[900] : Colors.white,
      border: Border.all(
          color: isDark
              ? Colors.blueAccent.withOpacity(.15)
              : Colors.blue[100]!,
          width: 2.0),
      borderRadius: BorderRadius.circular(9.0),
    ),
    child: Column(
      children: [
        Text('$label',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.tealAccent : Colors.black)),
        Text(value.toString(),
            style: TextStyle(
                fontSize: 17.0,
                color: isDark ? Colors.greenAccent : Colors.teal)),
      ],
    ),
  );

  Widget _sumTrace(bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 14.0, horizontal: 7.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.amber[800]!.withOpacity(.11) : Colors.amber[50],
      borderRadius: BorderRadius.circular(11.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trace:',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.yellowAccent : Colors.teal[900])),
        SizedBox(height: 5.0),
        ...sumByStep.asMap().entries.map((entry) {
          int idx = entry.key + 1;
          int val = entry.value;
          return Row(
            children: [
              Text('After i=$idx:',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: isDark ? Colors.yellowAccent : Colors.black)),
              SizedBox(width: 7.0),
              Text('sum = $val',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.greenAccent : Colors.teal)),
            ],
          );
        }),
      ],
    ),
  );

  Widget _terminalBox(String content, bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 9.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.black.withOpacity(.95) : Colors.black,
      borderRadius: BorderRadius.circular(9.0),
    ),
    child: Text(content,
        style: TextStyle(
            color: isDark ? Colors.greenAccent : Colors.greenAccent[400],
            fontSize: 16.0)),
  );

  Widget _recapBox(bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
        color: isDark ? Colors.teal[900]!.withOpacity(.18) : Colors.blue[50],
        border: Border.all(
            color: isDark
                ? Colors.tealAccent.withOpacity(.17)
                : Colors.teal[100]!,
            width: 1.3),
        borderRadius: BorderRadius.circular(12.0)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recap:',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: isDark ? Colors.yellowAccent : Colors.teal[900])),
        SizedBox(height: 7.0),
        _recapRow(
            "Initialization", "int i, sum = 0;", isDark),
        _recapRow("Loop", "for (i = 1; i <= 10; i++)", isDark),
        _recapRow(
            "Addition", "sum += i; // inside the loop", isDark),
        _recapRow("Output", 'printf("Sum: %d", sum);', isDark),
        SizedBox(height: 8.0),
        Text(
          "Result: Sum of first 10 natural numbers is 55.",
          style: TextStyle(
              color: isDark ? Colors.greenAccent : Colors.teal[900],
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );

  Widget _recapRow(String head, String desc, bool isDark) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
    child: Row(
      children: [
        Text('$head:',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.tealAccent : Colors.teal,
                fontSize: 13.0)),
        SizedBox(width: 7.0),
        Expanded(
            child: Text(desc,
                style: TextStyle(
                    color:
                    isDark ? Colors.tealAccent[100] : Colors.black87,
                    fontSize: 13.0))),
      ],
    ),
  );
}
