import 'dart:async';
import 'package:flutter/material.dart';

enum SyntaxStep {
  start,
  include,
  mainFn,
  printfMissingSemicolon,
  printfFixed,
  returnStatement,
  afterReturn,
  summary,
}

class SyntaxOfCPage extends StatefulWidget {
  const SyntaxOfCPage({Key? key}) : super(key: key);

  @override
  State<SyntaxOfCPage> createState() => _SyntaxOfCPageState();
}

class _SyntaxOfCPageState extends State<SyntaxOfCPage> with TickerProviderStateMixin {
  SyntaxStep currentStep = SyntaxStep.start;
  Timer? _timer;

  int _typingIndex = 0;
  String? _currentLine;
  String? _typingTarget;

  List<String> lines = [];
  int? highlightLine;
  String? errorMsg;
  String? infoMsg;
  bool showSummary = false;
  bool stepReady = false;

  @override
  void initState() {
    super.initState();
    _prepareStep();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _prepareStep([SyntaxStep? forceStep]) {
    SyntaxStep step = forceStep ?? currentStep;
    setState(() { stepReady = false; });
    switch (step) {
      case SyntaxStep.start:
        setState(() {
          lines = [];
          highlightLine = null;
          errorMsg = null;
          infoMsg = null;
          showSummary = false;
        });
        Future.delayed(const Duration(milliseconds: 150), () { setState(() { stepReady = true; }); });
        break;
      case SyntaxStep.include:
        _typeLine('#include <stdio.h>', 0, () {
          setState(() {
            infoMsg = "Header files include standard functions needed by the program.";
            stepReady = true;
          });
        });
        break;
      case SyntaxStep.mainFn:
        _typeLine('int main() {', 1, () {
          setState(() {
            highlightLine = 1;
            infoMsg = "Every C program must have a main() function. Program execution starts here.";
            stepReady = true;
          });
        });
        break;
      case SyntaxStep.printfMissingSemicolon:
        _typeLine('    printf("Hello, World!\\n")', 2, () {
          setState(() {
            highlightLine = 2;
            errorMsg = "Oops! Missing semicolon.";
            stepReady = true;
          });
        });
        break;
      case SyntaxStep.printfFixed:
        setState(() {
          lines[2] = '    printf("Hello, World!\\n"); //Prints Hello, World!';
          infoMsg = "Statements end with a semicolon.\nComments start with //. Indentation improves readability.";
          highlightLine = 2;
          stepReady = true;
        });
        break;
      case SyntaxStep.returnStatement:
        _typeLine('    return 0;', 3, () {
          setState(() {
            stepReady = true;
          });
        });
        break;
      case SyntaxStep.afterReturn:
        _typeLine('}', 4, () {
          setState(() {
            infoMsg = "return 0; signals the program ended successfully.";
            highlightLine = 3;
            stepReady = true;
          });
        });
        break;
      case SyntaxStep.summary:
        setState(() {
          showSummary = true;
          highlightLine = null;
          stepReady = true;
        });
        break;
    }
  }

  void _nextStep() {
    setState(() { errorMsg = null; infoMsg = null; });
    switch (currentStep) {
      case SyntaxStep.start: currentStep = SyntaxStep.include; break;
      case SyntaxStep.include: currentStep = SyntaxStep.mainFn; break;
      case SyntaxStep.mainFn: currentStep = SyntaxStep.printfMissingSemicolon; break;
      case SyntaxStep.printfMissingSemicolon: currentStep = SyntaxStep.printfFixed; break;
      case SyntaxStep.printfFixed: currentStep = SyntaxStep.returnStatement; break;
      case SyntaxStep.returnStatement: currentStep = SyntaxStep.afterReturn; break;
      case SyntaxStep.afterReturn: currentStep = SyntaxStep.summary; break;
      case SyntaxStep.summary: Navigator.of(context).pop(); return;
    }
    _prepareStep();
  }

  void _previousStep() {
    setState(() { errorMsg = null; infoMsg = null; });
    switch (currentStep) {
      case SyntaxStep.start: break;
      case SyntaxStep.include: currentStep = SyntaxStep.start; break;
      case SyntaxStep.mainFn: currentStep = SyntaxStep.include; break;
      case SyntaxStep.printfMissingSemicolon: currentStep = SyntaxStep.mainFn; break;
      case SyntaxStep.printfFixed: currentStep = SyntaxStep.printfMissingSemicolon; break;
      case SyntaxStep.returnStatement: currentStep = SyntaxStep.printfFixed; break;
      case SyntaxStep.afterReturn: currentStep = SyntaxStep.returnStatement; break;
      case SyntaxStep.summary: currentStep = SyntaxStep.afterReturn; break;
    }
    _prepareStep();
  }

  void _typeLine(String line, int index, VoidCallback onDone) {
    _timer?.cancel();
    setState(() {
      _currentLine = '';
      _typingIndex = 0;
      _typingTarget = line;
      while (lines.length <= index) lines.add('');
    });
    _timer = Timer.periodic(const Duration(milliseconds: 19), (timer) {
      if (_typingIndex > line.length) {
        timer.cancel();
        _timer = null;
        setState(() { lines[index] = line; });
        onDone();
        return;
      }
      setState(() {
        _currentLine = line.substring(0, _typingIndex);
        lines[index] = _currentLine!;
      });
      _typingIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    double codeFontSize = (width < 340) ? 11 : (width < 500) ? 13 : (width < 700) ? 15 : 17;
    double verticalPad = (width < 340) ? 9 : (width < 500) ? 16 : (width < 700) ? 21 : 28;
    double horizontalPad = (width < 340) ? 3 : (width < 500) ? 8 : (width < 700) ? 17 : 32;
    double boxMaxWidth = (width < 340) ? width * 0.98 : (width < 550) ? width * 0.93 : 480;
    double boxMinWidth = (width < 500) ? 160 : 260;
    double boxMaxHeight = (height < 520) ? height * 0.82 : height * 0.78;
    double boxMinHeight = (height < 400) ? 90 : 220;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Syntax of C - Interactive"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: LayoutBuilder(
                        builder: (ctx, constraints) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: verticalPad, horizontal: horizontalPad),
                            constraints: BoxConstraints(
                              maxWidth: boxMaxWidth,
                              minWidth: boxMinWidth,
                              maxHeight: boxMaxHeight,
                              minHeight: boxMinHeight,
                            ),
                            decoration: BoxDecoration(
                              color: isDark ? Color(0xFF232b32) : Color(0xFFF4F6F9),
                              borderRadius: BorderRadius.circular(17),
                              border: Border.all(
                                  color: isDark ? Colors.greenAccent.shade200 : Colors.grey.shade300,
                                  width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    offset: Offset(0, 2),
                                    blurRadius: 13)
                              ],
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SelectableText.rich(
                                TextSpan(
                                  children: [
                                    // FIX: Add \n after each line except the last
                                    for (int i = 0; i < lines.length; i++) ...[
                                      _styledLineDark(
                                        lines[i],
                                        index: i,
                                        highlight: highlightLine == i,
                                        fontSize: codeFontSize,
                                        isDark: isDark,
                                      ),
                                      if (i != lines.length - 1) const TextSpan(text: '\n'),
                                    ],
                                  ],
                                ),
                                style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: codeFontSize,
                                    height: 1.8),
                                maxLines: null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                if (!showSummary)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.arrow_back_ios, size: 18),
                          label: Text("Previous Step"),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(width < 350 ? 90 : 120, width < 350 ? 34 : 44),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              textStyle: TextStyle(fontSize: codeFontSize)),
                          onPressed: currentStep != SyntaxStep.start && stepReady ? _previousStep : null,
                        ),
                        ElevatedButton.icon(
                          icon: Icon(
                              showSummary ? Icons.done : Icons.arrow_forward_ios,
                              size: 18),
                          label: Text(currentStep == SyntaxStep.summary ? "Finish" : "Next Step"),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(width < 350 ? 90 : 120, width < 350 ? 34 : 44),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              textStyle: TextStyle(fontSize: codeFontSize)),
                          onPressed: stepReady ? _nextStep : null,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (infoMsg != null)
              _InfoPopup(
                  text: infoMsg!,
                  isDark: isDark),
            if (errorMsg != null)
              _ErrorPopup(text: errorMsg!, isDark: isDark),
            if (showSummary)
              _ResponsiveSummaryOverlay(
                onDone: () => Navigator.of(context).pop(),
                isDark: isDark,
              ),
          ],
        ),
      ),
    );
  }
}

TextSpan _styledLineDark(
    String line, {
      required int index,
      required bool highlight,
      required double fontSize,
      required bool isDark,
    }) {
  final boldStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: isDark ? Colors.cyanAccent.shade400 : Colors.deepPurple,
      fontSize: fontSize);
  final normalStyle = TextStyle(color: isDark ? Colors.greenAccent.shade100 : Colors.black, fontSize: fontSize);
  final commentStyle = TextStyle(color: isDark ? Colors.lightGreenAccent.withOpacity(.9) : Colors.green.shade700, fontSize: fontSize);
  final errorStyle = TextStyle(color: Colors.red.shade800, fontSize: fontSize);

  List<TextSpan> spans = [];
  String working = line;
  while (working.isNotEmpty) {
    if (working.startsWith('#include')) {
      spans.add(TextSpan(
          text: '#include', style: boldStyle.copyWith(color: isDark ? Colors.greenAccent.shade200 : Colors.teal)));
      working = working.substring(8);
    } else if (working.startsWith('int main()')) {
      spans.add(TextSpan(
          text: 'int main()', style: boldStyle.copyWith(color: isDark ? Colors.cyanAccent : Colors.blue)));
      working = working.substring(10);
    } else if (working.contains('"')) {
      var start = working.indexOf('"');
      if (start > 0) {
        spans.add(TextSpan(text: working.substring(0, start), style: normalStyle));
      }
      var end = working.indexOf('"', start + 1);
      if (end > 0) {
        spans.add(TextSpan(
            text: working.substring(start, end + 1),
            style: TextStyle(color: isDark ? Colors.yellowAccent : Colors.orange.shade800, fontSize: fontSize)));
        working = working.substring(end + 1);
      } else {
        spans.add(TextSpan(text: working.substring(start), style: normalStyle));
        working = '';
      }
    } else if (working.trim().startsWith('//')) {
      spans.add(TextSpan(text: working, style: commentStyle));
      working = '';
    } else if (working.trim().endsWith(';')) {
      spans.add(TextSpan(
          text: working.trimRight().substring(
              0, working.trimRight().length - 1),
          style: normalStyle));
      spans.add(TextSpan(
          text: ';', style: boldStyle.copyWith(color: isDark ? Colors.yellow.shade300 : Colors.red)));
      working = '';
    } else {
      spans.add(TextSpan(text: working, style: normalStyle));
      working = '';
    }
  }
  return TextSpan(
      children: spans,
      style: highlight
          ? TextStyle(
          background: Paint()
            ..color = isDark ? Colors.yellow.shade800.withOpacity(0.19) : Colors.yellow.withOpacity(0.26),
          fontWeight: FontWeight.w700)
          : null);
}

Widget _recapRow(String label, String desc, double fontSize, bool isDark) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 4),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: TextStyle(
              fontWeight: FontWeight.w600, color: isDark ? Colors.cyanAccent : Colors.deepPurple, fontSize: fontSize)),
      SizedBox(width: 6),
      Expanded(
          child: Text(desc, style: TextStyle(color: isDark ? Colors.greenAccent.shade100 : Colors.black87, fontSize: fontSize))),
    ],
  ),
);

class _InfoPopup extends StatelessWidget {
  final String text;
  final bool isDark;
  const _InfoPopup({required this.text, this.isDark = false});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // These values keep popup above the buttons on most devices
    double minBottom = width < 400 ? 100 : 115;
    double infoPopupBottom = width < 500 ? minBottom : 104;

    return Positioned(
      left: 0,
      right: 0,
      bottom: infoPopupBottom,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: 1.0,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 16, horizontal: width < 500 ? 17 : 40),
              decoration: BoxDecoration(
                  color: isDark ? Colors.green.shade900.withOpacity(.8) : Colors.blue.shade50.withOpacity(0.97),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isDark ? Colors.greenAccent.shade200 : Colors.blue.shade300, width: 1.7,
                  ),
                  boxShadow: [
                    BoxShadow(color: isDark ? Colors.green.shade800.withOpacity(.27) : Colors.blue.shade100, blurRadius: 12)
                  ]),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isDark ? Colors.greenAccent.shade100 : Colors.blue.shade900, fontSize: width < 500 ? 14 : 16
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _ErrorPopup extends StatelessWidget {
  final String text;
  final bool isDark;
  const _ErrorPopup({required this.text, this.isDark = false});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Positioned(
      top: 58,
      left: 0,
      right: 0,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: 1.0,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 12, horizontal: width < 500 ? 20 : 38),
              decoration: BoxDecoration(
                  color: isDark
                      ? Colors.red.shade900.withOpacity(.97)
                      : Colors.red.shade50.withOpacity(0.97),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isDark ? Colors.redAccent.shade100 : Colors.red.shade400, width: 1.7,
                  ),
                  boxShadow: [
                    BoxShadow(color: isDark ? Colors.red.shade800.withOpacity(.19) : Colors.red.shade100, blurRadius: 12)
                  ]),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, color: isDark ? Colors.redAccent.shade100 : Colors.red, size: 24),
                  SizedBox(width: 9),
                  Flexible(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: isDark ? Colors.redAccent.shade100 : Colors.red.shade900, fontSize: width < 500 ? 14 : 16
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResponsiveSummaryOverlay extends StatelessWidget {
  final VoidCallback onDone;
  final bool isDark;
  const _ResponsiveSummaryOverlay({required this.onDone, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double popupPad = width < 350 ? 12 : 24;
    final double headerSize = width < 350 ? 32 : 52;
    final double titleFontSize = width < 350 ? 15 : 22;
    final double recapSize = width < 350 ? 11 : 13;
    final double buttonWidth = width < 350 ? 88 : 130;
    final double buttonHeight = width < 350 ? 36 : 46;
    final double spacing = width < 350 ? 7 : 18;
    final accent = isDark ? Colors.cyanAccent : Colors.deepPurple;

    return Container(
      color: Colors.black.withOpacity(0.64),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(popupPad),
          constraints: BoxConstraints(maxWidth: 350),
          decoration: BoxDecoration(
            color: isDark ? Color(0xFF232b32) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 9)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.celebration, color: accent, size: headerSize),
              SizedBox(height: spacing),
              Text('C Program Built!',
                  style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.cyanAccent : Colors.deepPurple)),
              SizedBox(height: spacing * 0.7),
              _recapRow('Header (#include):', 'Includes useful C libraries.', recapSize, isDark),
              _recapRow('main():', 'Every C program starts here.', recapSize, isDark),
              _recapRow('Curly braces {}:', 'Enclose function body.', recapSize, isDark),
              _recapRow('Semicolon ;:', 'Ends each statement.', recapSize, isDark),
              _recapRow('//:', 'Start a single-line comment.', recapSize, isDark),
              _recapRow('Indentation:', 'Makes code structured & readable.', recapSize, isDark),
              SizedBox(height: spacing + 2),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(buttonWidth, buttonHeight),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: onDone,
                icon: Icon(Icons.done),
                label: Text('Finish'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
