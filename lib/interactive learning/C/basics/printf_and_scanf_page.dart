import 'package:flutter/material.dart';

enum PrintfScanfStep {
  start,
  addPrintf,
  showOutput,
  explainPrintf,
  addScanf,
  showInputArrow,
  explainScanf,
  enterValidInput,
  explainFormat,
  showMemoryAddress,
  enterInvalidInput,
  summary,
}

class PrintfAndScanfPage extends StatefulWidget {
  @override
  State<PrintfAndScanfPage> createState() => _PrintfAndScanfPageState();
}

class _PrintfAndScanfPageState extends State<PrintfAndScanfPage> with TickerProviderStateMixin {
  PrintfScanfStep step = PrintfScanfStep.start;
  List<String> codeLines = [
    "#include <stdio.h>",
    "",
    "int main() {",
    "    int number;",
    "",
    "}"
  ];
  int? codeHighlight;

  String? infoMsg;
  String? errorMsg;
  String terminalOutput = "";
  bool showInputField = false;
  String inputBuffer = "";
  int? enteredNumber;
  bool zoomFormatSpec = false;
  bool showMemoryArrow = false;
  bool showInputError = false;
  bool summary = false;
  bool stepReady = true;

  @override
  void initState() {
    super.initState();
    _goToStep(PrintfScanfStep.addPrintf);
  }

  // USER-driven stepper, no autoplay:
  void _goToStep(PrintfScanfStep s) {
    setState(() {
      step = s;
      stepReady = false;
      infoMsg = null;
      errorMsg = null;
      showInputError = false;
      summary = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runStep();
    });
  }

  void _runStep() {
    switch (step) {
      case PrintfScanfStep.addPrintf:
        codeLines[4] = '    printf("Enter a number: ");';
        codeHighlight = 4;
        showInputField = false;
        terminalOutput = "";
        enteredNumber = null;
        zoomFormatSpec = false;
        showMemoryArrow = false;
        showInputError = false;
        stepReady = true;
        break;
      case PrintfScanfStep.showOutput:
        codeHighlight = null;
        terminalOutput = "Enter a number: ";
        showInputField = false;
        stepReady = true;
        break;
      case PrintfScanfStep.explainPrintf:
        infoMsg = 'printf displays messages or variables to the user.';
        stepReady = true;
        break;
      case PrintfScanfStep.addScanf:
        infoMsg = null;
        codeLines.insert(5, '    scanf("%d", &number);');
        codeHighlight = 5;
        showInputField = true;
        inputBuffer = "";
        showMemoryArrow = false;
        stepReady = true;
        break;
      case PrintfScanfStep.showInputArrow:
        showMemoryArrow = true;
        stepReady = true;
        break;
      case PrintfScanfStep.explainScanf:
        infoMsg = 'scanf collects input from the user;\n%d indicates an integer will be entered.';
        stepReady = true;
        break;
      case PrintfScanfStep.enterValidInput:
        infoMsg = null;
        codeHighlight = null;
        showInputField = true;
        showMemoryArrow = false;
        inputBuffer = "";
        stepReady = true;
        break;
      case PrintfScanfStep.explainFormat:
        zoomFormatSpec = true;
        stepReady = true;
        break;
      case PrintfScanfStep.showMemoryAddress:
        showMemoryArrow = true;
        stepReady = true;
        break;
      case PrintfScanfStep.enterInvalidInput:
        errorMsg = 'Error: Expected an integer value!';
        showInputError = true;
        stepReady = true;
        break;
      case PrintfScanfStep.summary:
        summary = true;
        stepReady = true;
        break;
      default:
        stepReady = true;
        break;
    }
    setState(() {});
  }

  void _onInputSubmitted(String val) {
    if (val.trim().isEmpty) return;
    final n = int.tryParse(val.trim());
    if (n == null) {
      _goToStep(PrintfScanfStep.enterInvalidInput);
      Future.delayed(Duration(seconds: 2), () {
        if (!mounted) return;
        setState(() {
          errorMsg = null;
          showInputError = false;
        });
        _goToStep(PrintfScanfStep.enterValidInput);
      });
      return;
    }
    setState(() {
      enteredNumber = n;
      codeLines.insert(6, '    printf("You entered: %d", number);');
      codeHighlight = 6;
      showInputField = false;
      terminalOutput = "Enter a number: $n\nYou entered: $n";
    });
    _goToStep(PrintfScanfStep.explainFormat);
  }

  void _onNext() {
    switch (step) {
      case PrintfScanfStep.addPrintf:
        _goToStep(PrintfScanfStep.showOutput);
        break;
      case PrintfScanfStep.showOutput:
        _goToStep(PrintfScanfStep.explainPrintf);
        break;
      case PrintfScanfStep.explainPrintf:
        _goToStep(PrintfScanfStep.addScanf);
        break;
      case PrintfScanfStep.addScanf:
        _goToStep(PrintfScanfStep.showInputArrow);
        break;
      case PrintfScanfStep.showInputArrow:
        _goToStep(PrintfScanfStep.explainScanf);
        break;
      case PrintfScanfStep.explainScanf:
        _goToStep(PrintfScanfStep.enterValidInput);
        break;
      case PrintfScanfStep.enterValidInput:
        break;
      case PrintfScanfStep.explainFormat:
        _goToStep(PrintfScanfStep.showMemoryAddress);
        break;
      case PrintfScanfStep.showMemoryAddress:
        _goToStep(PrintfScanfStep.summary);
        break;
      case PrintfScanfStep.summary:
        Navigator.of(context).pop();
        break;
      case PrintfScanfStep.enterInvalidInput:
        break;
      default:
        break;
    }
  }

  void _onPrevious() {
    switch (step) {
      case PrintfScanfStep.addPrintf:
      // do nothing
        break;
      case PrintfScanfStep.showOutput:
        _goToStep(PrintfScanfStep.addPrintf);
        break;
      case PrintfScanfStep.explainPrintf:
        _goToStep(PrintfScanfStep.showOutput);
        break;
      case PrintfScanfStep.addScanf:
        _goToStep(PrintfScanfStep.explainPrintf);
        break;
      case PrintfScanfStep.showInputArrow:
        _goToStep(PrintfScanfStep.addScanf);
        break;
      case PrintfScanfStep.explainScanf:
        _goToStep(PrintfScanfStep.showInputArrow);
        break;
      case PrintfScanfStep.enterValidInput:
        _goToStep(PrintfScanfStep.explainScanf);
        break;
      case PrintfScanfStep.explainFormat:
        _goToStep(PrintfScanfStep.enterValidInput);
        break;
      case PrintfScanfStep.showMemoryAddress:
        _goToStep(PrintfScanfStep.explainFormat);
        break;
      case PrintfScanfStep.summary:
        _goToStep(PrintfScanfStep.showMemoryAddress);
        break;
      case PrintfScanfStep.enterInvalidInput:
        _goToStep(PrintfScanfStep.enterValidInput);
        break;
      default:
        break;
    }
  }

  // === DARK MODE COLOR HELPERS ===
  Color _codeTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.greenAccent.shade200
          : Colors.black;
  Color _monoDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Color(0xFF141820) : Color(0xFFF7F9FA);
  Color _highlightDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.yellow.shade900.withOpacity(0.18) : Colors.orange.withOpacity(0.10);
  Color _stepHighlight(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.yellow.shade100.withOpacity(0.08) : Colors.orange.withOpacity(0.12);
  Color _formatBg(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.teal.shade900.withOpacity(.7)
        : Colors.blue.shade50;
  }
  Color _formatAccent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.greenAccent.shade100
          : Colors.deepPurple;
  Color _formatSideText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.greenAccent.shade200
          : Colors.black87;
  Color _infoColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.green.shade900.withOpacity(.86)
          : Colors.blue.shade50.withOpacity(.98);
  Color _infoSubtitle(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.greenAccent.shade100
          : Colors.blue.shade900;
  Color _terminalBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.grey.shade900;
  Color _terminalText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.greenAccent.shade100
          : Colors.greenAccent;

  Color _summaryBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withOpacity(.79)
          : Colors.white;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final codeFontSize = width < 500.0 ? 13.0 : 16.0;
    final codePadH = width < 500.0 ? 8.0 : 26.0;
    final terminalFontSize = width < 500.0 ? 13.0 : 16.0;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('printf & scanf - Interactive')),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: width < 500.0 ? 8.0 : 32.0),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 17.0, horizontal: codePadH),
                    constraints: BoxConstraints(
                        maxWidth: 490.0, minWidth: 220.0, minHeight: 170.0, maxHeight: 360.0),
                    decoration: BoxDecoration(
                      color: _monoDark(context),
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(
                        color: codeHighlight != null
                            ? Colors.orange
                            : (isDark
                            ? Colors.greenAccent.shade400.withOpacity(0.4)
                            : Colors.grey.shade300),
                        width: codeHighlight != null ? 2.3 : 1.4,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            offset: Offset(0, 3),
                            blurRadius: 8)
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: codeFontSize,
                              color: _codeTextColor(context)),
                          children: codeLines.asMap().entries.map((e) {
                            int idx = e.key;
                            String line = e.value;
                            return _buildCodeInlineSpanDark(
                                line,
                                idx,
                                highlight: codeHighlight == idx,
                                fontSize: codeFontSize,
                                zoomFormatSpec: zoomFormatSpec,
                                context: context);
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    _terminalBox(
                        terminalOutput,
                        showInputField,
                        inputBuffer,
                            (s) {
                          if (step == PrintfScanfStep.enterValidInput) {
                            _onInputSubmitted(s);
                          }
                        },
                        terminalFontSize,
                        showInputError,
                        _terminalBg(context),
                        _terminalText(context),
                        isDark),
                    if (showInputField && showMemoryArrow && !showInputError)
                      Positioned(
                        left: 36.0,
                        right: 36.0,
                        bottom: 34.0,
                        child: AnimatedOpacity(
                          opacity: showMemoryArrow ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 700),
                          child: _inputToMemoryArrow(context),
                        ),
                      ),
                  ],
                ),
                if (zoomFormatSpec)
                  _formatSpecSidebar(width < 500.0 ? 310.0 : 400.0, context),
                SizedBox(height: 30.0),
                if (step != PrintfScanfStep.enterValidInput && step != PrintfScanfStep.enterInvalidInput && step != PrintfScanfStep.summary)
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.arrow_back),
                          label: Text("Previous Step"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(120.0, 42.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0)),
                            textStyle: TextStyle(fontSize: codeFontSize),
                          ),
                          onPressed: (step == PrintfScanfStep.addPrintf) ? null : stepReady ? _onPrevious : null,
                        ),
                        if (step == PrintfScanfStep.summary)
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(120.0, 42.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0)),
                              textStyle: TextStyle(fontSize: codeFontSize),
                            ),
                            onPressed: stepReady
                                ? () {
                              Navigator.of(context).pop();
                            }
                                : null,
                            icon: Icon(Icons.check),
                            label: Text("Finish"),
                          )
                        else
                          ElevatedButton.icon(
                            icon: Icon(Icons.arrow_forward),
                            label: Text("Next Step"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(120.0, 42.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0)),
                              textStyle: TextStyle(fontSize: codeFontSize),
                            ),
                            onPressed: stepReady ? _onNext : null,
                          ),
                      ],
                    ),
                  ),
              ],
            ),
            if (infoMsg != null) _InfoPopup(text: infoMsg!, color: _infoColor(context), textColor: _infoSubtitle(context)),
            if (errorMsg != null) _ErrorPopup(text: errorMsg!),
            if (summary) _SummaryOverlay(bgColor: _summaryBg(context), txtColor: _codeTextColor(context)),
          ],
        ),
      ),
    );
  }
}

// ==== InlineSpan builder (Dark-theme aware) ====
InlineSpan _buildCodeInlineSpanDark(
    String line,
    int index, {
      required bool highlight,
      required double fontSize,
      required bool zoomFormatSpec,
      required BuildContext context,
    }) {

  final codeText = Theme.of(context).brightness == Brightness.dark
      ? Colors.greenAccent.shade200
      : Colors.black;

  final boldStyle = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.tealAccent.shade200, fontSize: fontSize);
  final normalStyle = TextStyle(color: codeText, fontSize: fontSize);
  final commentStyle = TextStyle(color: Colors.green.shade400, fontSize: fontSize);
  List<InlineSpan> inline = [];

  String working = line;
  while (working.isNotEmpty) {
    if (working.startsWith("int main()")) {
      inline.add(TextSpan(
          text: "int main()",
          style: boldStyle.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.lightGreenAccent
                  : Colors.blue.shade800)));
      working = working.substring(10);
    } else if (working.startsWith("#include")) {
      inline.add(TextSpan(
          text: "#include",
          style: boldStyle.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.cyanAccent
                  : Colors.teal)));
      working = working.substring(8);
    } else if (working.contains("%d")) {
      int idx = working.indexOf("%d");
      if (idx > 0) {
        inline.add(TextSpan(text: working.substring(0, idx), style: normalStyle));
      }
      inline.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: zoomFormatSpec
              ? AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeOut,
            child: Transform.scale(
              scale: 1.25,
              child: Text(
                "%d",
                style: TextStyle(
                    background: Paint()
                      ..color = Colors.yellow.withOpacity(0.26),
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.yellowAccent : Colors.red.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize + 2.0),
              ),
            ),
          )
              : Text("%d",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.yellow.shade200 : Colors.red.shade800,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              )),
        ),
      );
      working = working.substring(idx + 2);
    } else if (working.contains("//")) {
      final prev = working.split("//")[0];
      if (prev.isNotEmpty) {
        inline.add(TextSpan(text: prev, style: normalStyle));
      }
      final comment = working.substring(working.indexOf("//"));
      inline.add(TextSpan(text: comment, style: commentStyle));
      working = '';
    } else if (working.trim().isEmpty) {
      inline.add(TextSpan(text: working, style: normalStyle));
      working = '';
    } else {
      inline.add(TextSpan(text: working, style: normalStyle));
      working = '';
    }
  }

  InlineSpan result = TextSpan(children: inline);

  if (highlight) {
    result = WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.yellow.shade700.withOpacity(0.10)
              : Colors.orange.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: RichText(
          text: TextSpan(children: [result]),
        ),
      ),
    );
  }
  return result;
}

// ==== Terminal Box ====
// Now theme-responsive!
Widget _terminalBox(
    String output,
    bool showInputField,
    String inputBuffer,
    ValueChanged<String> onSubmit,
    double fontSize,
    bool showInputError,
    Color bg,
    Color txt,
    bool isDark,
    ) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 22.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(13.0),
      border: Border.all(color: Colors.black54, width: 1.4),
    ),
    constraints: BoxConstraints(
      minHeight: 68.0,
      maxWidth: 490.0,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Wrap(
            children: [
              Text(
                output,
                style: TextStyle(color: txt, fontSize: fontSize),
              ),
              if (showInputField)
                SizedBox(
                  width: 85.0,
                  child: TextField(
                    autofocus: true,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: fontSize,
                        color: showInputError
                            ? Colors.redAccent
                            : (isDark ? Colors.greenAccent : Colors.green)),
                    decoration: InputDecoration(
                        hintText: "number",
                        hintStyle: TextStyle(color: Colors.white38, fontSize: fontSize - 1.0),
                        isDense: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 3.0)),
                    keyboardType: TextInputType.number,
                    onChanged: (s) {},
                    onSubmitted: (val) => onSubmit(val),
                    enableInteractiveSelection: false,
                  ),
                )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _inputToMemoryArrow(BuildContext context) {
  final txtColor = Theme.of(context).brightness == Brightness.dark
      ? Colors.greenAccent.shade100
      : Colors.purple;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.arrow_right_alt, size: 32.0, color: txtColor),
      SizedBox(width: 8.0),
      Text(
        'Input goes to variable: &number',
        style: TextStyle(color: txtColor, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

// ==== Format Specifier Sidebar ====
Widget _formatSpecSidebar(double width, BuildContext context) {
  final bg = Theme.of(context).brightness == Brightness.dark
      ? Colors.teal.shade900.withOpacity(.97)
      : Colors.blue.shade50;
  final accent = Theme.of(context).brightness == Brightness.dark
      ? Colors.greenAccent.shade100
      : Colors.deepPurple;
  final txt = Theme.of(context).brightness == Brightness.dark
      ? Colors.greenAccent.shade100
      : Colors.black87;

  return Positioned(
    top: 120.0,
    right: 0.0,
    child: Container(
      width: width < 270.0 ? width - 50.0 : 210.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(13.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Common Format Specifiers',
              style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0)),
          Divider(color: accent, thickness: 1.1),
          _recapRow('%d', 'Integer (int)', txt, accent),
          _recapRow('%f', 'Float (float, double)', txt, accent),
          _recapRow('%c', 'Character (char)', txt, accent),
          _recapRow('%s', 'String (char array)', txt, accent),
        ],
      ),
    ),
  );
}

Widget _recapRow(String label, String desc, Color txt, Color accent) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 4.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: TextStyle(fontWeight: FontWeight.w600, color: accent, fontSize: 13.0)),
      SizedBox(width: 10.0),
      Expanded(child: Text(desc, style: TextStyle(color: txt, fontSize: 13.0))),
    ],
  ),
);

// ==== Popups and Overlays ====
class _InfoPopup extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  const _InfoPopup({required this.text, required this.color, required this.textColor});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: width < 500.0 ? 26.0 : 46.0,
      left: 0.0,
      right: 0.0,
      child: Center(
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(milliseconds: 310),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: 15.0, horizontal: width < 500.0 ? 15.0 : 36.0),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: Colors.greenAccent.shade100,
                  width: 1.4,
                ),
                boxShadow: [
                  BoxShadow(color: color.withOpacity(.35), blurRadius: 12.0)
                ]),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style:
              TextStyle(color: textColor, fontSize: width < 500.0 ? 14.0 : 16.0),
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorPopup extends StatelessWidget {
  final String text;
  const _ErrorPopup({required this.text});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final errorBg = Theme.of(context).brightness == Brightness.dark
        ? Colors.red.shade900.withOpacity(.97)
        : Colors.red.shade50.withOpacity(.98);
    final errorBorder = Theme.of(context).brightness == Brightness.dark
        ? Colors.redAccent.shade200
        : Colors.red.shade400;

    return Positioned(
      top: 52.0,
      left: 0.0,
      right: 0.0,
      child: Center(
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          opacity: 1.0,
          child: Container(
            padding:
            EdgeInsets.symmetric(vertical: 12.0, horizontal: width < 500.0 ? 17.0 : 32.0),
            decoration: BoxDecoration(
                color: errorBg,
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: errorBorder,
                  width: 1.7,
                ),
                boxShadow: [
                  BoxShadow(color: errorBg.withOpacity(.54), blurRadius: 12.0)
                ]),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, color: errorBorder, size: 23.0),
                SizedBox(width: 8.0),
                Flexible(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: errorBorder,
                        fontSize: width < 500.0 ? 14.0 : 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryOverlay extends StatelessWidget {
  final Color bgColor;
  final Color txtColor;
  const _SummaryOverlay({required this.bgColor, required this.txtColor});
  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).brightness == Brightness.dark
        ? Colors.greenAccent.shade100
        : Colors.blueAccent;
    return Container(
      color: Colors.black.withOpacity(0.66),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(23.0),
          constraints: BoxConstraints(maxWidth: 350.0),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(22.0),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8.0)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.assistant_photo, color: accent, size: 44.0),
              SizedBox(height: 12.0),
              Text('Key Points', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: txtColor)),
              SizedBox(height: 9.0),
              _recapRow('printf:', 'shows output/messages on the terminal.', txtColor, accent),
              _recapRow('scanf:', 'reads user input from the terminal.', txtColor, accent),
              _recapRow('%d:', 'format specifier for integers.', txtColor, accent),
              _recapRow('&number:', 'address-of operator; scanf stores value there.', txtColor, accent),
              SizedBox(height: 9.0),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(110.0, 43.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0))),
                onPressed: () => Navigator.of(context).pop(),
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
