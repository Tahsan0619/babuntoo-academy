import 'package:flutter/material.dart';

enum NatNumStep {
  intro,
  varDecl,
  loopHeader,
  loopBody,
  animateRun,
  loopEnd,
  recap,
}

class Problem1NaturalNumbersPage extends StatefulWidget {
  @override
  State<Problem1NaturalNumbersPage> createState() =>
      _Problem1NaturalNumbersPageState();
}

class _Problem1NaturalNumbersPageState
    extends State<Problem1NaturalNumbersPage> {
  NatNumStep step = NatNumStep.intro;
  List<String> code = [];
  int? iValue;
  List<int> output = [];
  String? annotation;
  bool loopHighlight = false;
  bool bodyHighlight = false;
  bool loopEnded = false;
  bool recapOn = false;

  // Control stepping through the loop
  int currentI = 1;

  final List<NatNumStep> _orderedSteps = NatNumStep.values;

  @override
  void initState() {
    super.initState();
    _prepareStep();
  }

  void _onNext() {
    setState(() {
      annotation = null;
    });
    switch (step) {
      case NatNumStep.intro:
        step = NatNumStep.varDecl;
        break;
      case NatNumStep.varDecl:
        step = NatNumStep.loopHeader;
        break;
      case NatNumStep.loopHeader:
        step = NatNumStep.loopBody;
        break;
      case NatNumStep.loopBody:
        currentI = 1;
        iValue = 1;
        output.clear();
        loopHighlight = true;
        bodyHighlight = false;
        loopEnded = false;
        step = NatNumStep.animateRun;
        break;
      case NatNumStep.animateRun:
      // Step through loop interaction
        if (bodyHighlight == false && currentI <= 10) {
          // Show header highlight
          setState(() {
            iValue = currentI;
            annotation = "i = $currentI  (Is $currentI ≤ 10? Yes)";
            loopHighlight = true;
            bodyHighlight = false;
          });
          bodyHighlight = true; // Next tap will highlight body
          return;
        } else if (bodyHighlight == true && iValue != null && iValue! <= 10) {
          // Now print and increment
          setState(() {
            output.add(iValue!);
            annotation = "printf prints ${iValue!}";
            loopHighlight = false;
            bodyHighlight = true;
          });
          currentI++;
          bodyHighlight = false;
          return;
        }
        // Done, move to loop end
        step = NatNumStep.loopEnd;
        iValue = 11;
        bodyHighlight = false;
        loopHighlight = false;
        loopEnded = true;
        annotation = "i = 11   (Is 11 ≤ 10? No) — Loop ends!";
        break;
      case NatNumStep.loopEnd:
        step = NatNumStep.recap;
        recapOn = true;
        break;
      case NatNumStep.recap:
        break;
    }
    _prepareStep();
  }

  void _onPrevious() {
    final idx = _orderedSteps.indexOf(step);

    // AnimateRun stepwise undo: if output is not empty, reverse last output
    if (step == NatNumStep.animateRun && output.isNotEmpty) {
      setState(() {
        if (bodyHighlight) {
          bodyHighlight = false;
        } else if (output.isNotEmpty) {
          output.removeLast();
          currentI = currentI > 1 ? currentI - 1 : 1;
          iValue = currentI;
          bodyHighlight = true;
        }
      });
      return;
    }

    if (idx > 0) {
      setState(() {
        step = _orderedSteps[idx - 1];
        // Reset state as needed for each step
        if (step != NatNumStep.animateRun) {
          output = step == NatNumStep.loopBody ? [] : output;
          recapOn = false;
          bodyHighlight = false;
          loopHighlight = false;
          loopEnded = false;
        }
        _prepareStep();
      });
    }
  }

  void _onFinish() => Navigator.of(context).maybePop();

  void _prepareStep() {
    setState(() {
      switch (step) {
        case NatNumStep.intro:
          code.clear();
          iValue = null;
          output.clear();
          annotation = "Let’s print numbers from 1 to 10 using a loop!";
          loopHighlight = false;
          bodyHighlight = false;
          loopEnded = false;
          recapOn = false;
          break;
        case NatNumStep.varDecl:
          code = ["int i;"];
          break;
        case NatNumStep.loopHeader:
          code = ["int i;", "for (i = 1; i <= 10; i++) {"];
          break;
        case NatNumStep.loopBody:
          code = [
            "int i;",
            "for (i = 1; i <= 10; i++) {",
            '  printf("%d ", i);',
            "}"
          ];
          break;
        case NatNumStep.animateRun:
          break;
        case NatNumStep.loopEnd:
          break;
        case NatNumStep.recap:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 500.0;
    final codeFont = TextStyle(
        fontFamily: "monospace",
        fontSize: 16.0,
        color: isDark ? Colors.tealAccent : Colors.black87);
    bool isRecap = step == NatNumStep.recap;
    final mainColor = isDark ? Colors.tealAccent : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: Text("First 10 Natural Numbers", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : Colors.teal[50],
        iconTheme: IconThemeData(color: isDark ? Colors.tealAccent : Colors.teal[900]),
      ),
      backgroundColor: isDark ? Color(0xFF11161D) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 12.0 : 18.0,
                    horizontal: isMobile ? 10.0 : 20.0),
                children: [
                  _codeEditor(codeFont, isDark),
                  SizedBox(height: 12.0),
                  _memoryAndLoopViz(codeFont, isDark),
                  SizedBox(height: 13.0),
                  _terminal(isDark),
                  if (annotation != null)
                    _popup(annotation!, isDark: isDark, color: isDark ? Colors.amber[800]!.withOpacity(.14) : Colors.amber[100]!),
                  if (recapOn) _recapOverlay(isDark),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
              child: Wrap(
                spacing: 12.0,
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
                      onPressed: () {
                        // AnimateRun needs two steps for each value:
                        // tap for header, tap for body
                        if (step == NatNumStep.animateRun &&
                            currentI <= 10 &&
                            !bodyHighlight) {
                          _onNext(); // highlight header
                        } else if (step == NatNumStep.animateRun &&
                            (bodyHighlight || currentI > 10)) {
                          _onNext(); // highlight body/increment or exit to loop end
                        } else {
                          _onNext();
                        }
                      },
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
        ),
      ),
    );
  }

  Widget _codeEditor(TextStyle codeFont, bool isDark) => Container(
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[900] : Colors.grey[50],
      border: Border.all(color: Colors.black12, width: 1.2),
      borderRadius: BorderRadius.circular(12.0),
    ),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: code.map((l) {
        bool loopH =
            l.contains("for") && loopHighlight && !bodyHighlight && !loopEnded;
        bool bodyH =
            l.contains("printf") && bodyHighlight && !loopEnded;
        return Container(
          decoration: (loopH || bodyH)
              ? BoxDecoration(
              color: loopH
                  ? (isDark ? Colors.yellowAccent.withOpacity(.09) : Colors.yellow[200])
                  : (isDark ? Colors.greenAccent.withOpacity(.09) : Colors.lightGreen[100]),
              borderRadius: BorderRadius.circular(7.0))
              : null,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(l, style: codeFont.copyWith(
              color: (loopH || bodyH)
                  ? (isDark ? Colors.tealAccent : Colors.teal[700])
                  : (isDark ? Colors.tealAccent[100] : Colors.black87),
              fontWeight: (loopH || bodyH) ? FontWeight.bold : FontWeight.normal,
            )),
          ),
        );
      }).toList(),
    ),
  );

  Widget _memoryAndLoopViz(TextStyle codeFont, bool isDark) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Text('Memory:', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
          if (iValue != null)
            Container(
              margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 7.0),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.white,
                  border: Border.all(
                      color: isDark ? Colors.blueAccent.withOpacity(.23) : Colors.blue[200]!, width: 2.0),
                  borderRadius: BorderRadius.circular(9.0)),
              child: Column(
                children: [
                  Text('i',
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.w600, color: isDark ? Colors.tealAccent : Colors.black)),
                  Text(iValue.toString(),
                      style: TextStyle(
                          fontSize: 17.0,
                          color: iValue! <= 10
                              ? (isDark ? Colors.greenAccent : Colors.teal)
                              : (isDark ? Colors.redAccent : Colors.redAccent),
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
        ],
      ),
      SizedBox(width: 20.0),
      if (!loopEnded && iValue != null)
        Column(
          children: [
            Icon(Icons.loop, size: 32.0, color: isDark ? Colors.tealAccent : Colors.teal[700]),
            SizedBox(height: 4.0),
            Text("i = $iValue",
                style: TextStyle(
                    color: isDark ? Colors.tealAccent : Colors.teal[700], fontWeight: FontWeight.bold))
          ],
        ),
    ],
  );

  Widget _terminal(bool isDark) => Container(
    margin: EdgeInsets.only(top: 7.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.black.withOpacity(.92) : Colors.black,
      borderRadius: BorderRadius.circular(7.0),
    ),
    padding: EdgeInsets.all(11.0),
    height: 54.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Output: ',
            style: TextStyle(
                color: isDark ? Colors.yellowAccent : Colors.amber,
                fontFamily: "monospace",
                fontSize: 15.0)),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              output.map((e) => "$e").join(" "),
              style: TextStyle(
                  color: isDark ? Colors.greenAccent : Colors.greenAccent,
                  fontFamily: "monospace",
                  fontSize: 17.0),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _popup(String txt, {required bool isDark, required Color color}) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
    decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(11.0)),
    child: Center(
        child: Text(txt,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.tealAccent : Colors.black))),
  );

  Widget _recapOverlay(bool isDark) => Center(
    child: Container(
      margin: EdgeInsets.only(top: 40.0),
      padding: EdgeInsets.all(23.0),
      decoration: BoxDecoration(
          color: isDark ? Colors.teal[900]!.withOpacity(.12) : Colors.teal[50],
          border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.13) : Colors.teal[300]!, width: 2.0),
          borderRadius: BorderRadius.circular(18.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: isDark ? Colors.greenAccent : Colors.teal, size: 34.0),
          SizedBox(height: 7.0),
          Text(
              "Loop Recap:\n- i starts at 1\n- For each i ≤ 10, prints i then increments\n- Stops after printing 10\n\nOutput: 1 2 3 4 5 6 7 8 9 10",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0, color: isDark ? Colors.tealAccent : Colors.black)),
        ],
      ),
    ),
  );
}
