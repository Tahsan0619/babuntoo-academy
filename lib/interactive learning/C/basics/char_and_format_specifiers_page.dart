import 'package:flutter/material.dart';

// Enum for the tutorial steps
enum CharStep {
  intro,
  declareChar,
  assignChar,
  printChar,
  assignAscii,
  printAscii,
  wrongMulti,
  stringIntro,
  printString,
  charRange,
  formatTable,
  multiPrintf,
  recap,
  quiz,
}

class CharAndFormatSpecifierPage extends StatefulWidget {
  @override
  State<CharAndFormatSpecifierPage> createState() => _CharAndFormatSpecifierPageState();
}

class _CharAndFormatSpecifierPageState extends State<CharAndFormatSpecifierPage> {
  CharStep step = CharStep.intro;
  List<String> code = [];
  Map<String, dynamic> memory = {};
  String? infoMsg;
  String? errorMsg;
  String? annotation;
  String? terminalOutput;
  bool showSidebar = false;
  bool showFormatTable = false;
  bool showRangeOverlay = false;
  bool showQuiz = false;
  bool showArrows = false;
  String? quizAnswer;
  String? quizFeedback;
  String? quizQuestion = "Which format specifier prints a char variable?";
  final Map<String, String> quizMap = {
    "%d": "int",
    "%c": "char",
    "%f": "float",
    "%s": "string",
    "%lf": "double",
  };
  String? lastHighlightMem;
  bool stepReady = true;

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
      terminalOutput = terminalOutput;
      showSidebar = showSidebar;
      showFormatTable = showFormatTable;
      showRangeOverlay = showRangeOverlay;
      showQuiz = showQuiz;
      showArrows = showArrows;
      lastHighlightMem = lastHighlightMem;
    });
    switch (step) {
      case CharStep.intro:
        step = CharStep.declareChar;
        break;
      case CharStep.declareChar:
        step = CharStep.assignChar;
        break;
      case CharStep.assignChar:
        step = CharStep.printChar;
        break;
      case CharStep.printChar:
        step = CharStep.assignAscii;
        break;
      case CharStep.assignAscii:
        step = CharStep.printAscii;
        break;
      case CharStep.printAscii:
        step = CharStep.wrongMulti;
        break;
      case CharStep.wrongMulti:
        step = CharStep.stringIntro;
        break;
      case CharStep.stringIntro:
        step = CharStep.printString;
        break;
      case CharStep.printString:
        step = CharStep.charRange;
        break;
      case CharStep.charRange:
        step = CharStep.formatTable;
        break;
      case CharStep.formatTable:
        step = CharStep.multiPrintf;
        break;
      case CharStep.multiPrintf:
        step = CharStep.recap;
        break;
      case CharStep.recap:
        step = CharStep.quiz;
        break;
      case CharStep.quiz:
      // do nothing here, finish is separate
        break;
    }
    _prepareStep();
  }

  void _onPrevious() {
    setState(() {
      infoMsg = null;
      errorMsg = null;
      annotation = null;
      terminalOutput = terminalOutput;
      showSidebar = showSidebar;
      showFormatTable = showFormatTable;
      showRangeOverlay = showRangeOverlay;
      showQuiz = showQuiz;
      showArrows = showArrows;
      lastHighlightMem = lastHighlightMem;
    });
    switch (step) {
      case CharStep.intro:
        break;
      case CharStep.declareChar:
        step = CharStep.intro;
        break;
      case CharStep.assignChar:
        step = CharStep.declareChar;
        break;
      case CharStep.printChar:
        step = CharStep.assignChar;
        break;
      case CharStep.assignAscii:
        step = CharStep.printChar;
        break;
      case CharStep.printAscii:
        step = CharStep.assignAscii;
        break;
      case CharStep.wrongMulti:
        step = CharStep.printAscii;
        break;
      case CharStep.stringIntro:
        step = CharStep.wrongMulti;
        break;
      case CharStep.printString:
        step = CharStep.stringIntro;
        break;
      case CharStep.charRange:
        step = CharStep.printString;
        break;
      case CharStep.formatTable:
        step = CharStep.charRange;
        break;
      case CharStep.multiPrintf:
        step = CharStep.formatTable;
        break;
      case CharStep.recap:
        step = CharStep.multiPrintf;
        break;
      case CharStep.quiz:
        step = CharStep.recap;
        break;
    }
    _prepareStep();
  }

  void _onFinish() {
    Navigator.of(context).maybePop();
  }

  void _prepareStep() {
    setState(() {
      stepReady = false;
      switch (step) {
        case CharStep.intro:
          code = [];
          memory.clear();
          terminalOutput = null;
          infoMsg = "Let's learn about single characters and printing types in C!";
          showSidebar = false;
          lastHighlightMem = null;
          showFormatTable = false;
          showRangeOverlay = false;
          showArrows = false;
          showQuiz = false;
          errorMsg = null;
          annotation = null;
          break;
        case CharStep.declareChar:
          code = ["char grade;"];
          infoMsg = "char reserves 1 byte to store a single character.";
          showSidebar = true;
          memory.clear();
          showQuiz = false;
          errorMsg = null;
          annotation = null;
          terminalOutput = null;
          lastHighlightMem = null;
          break;
        case CharStep.assignChar:
          code = ["char grade;", "grade = 'A';"];
          memory["grade"] = "A";
          annotation = "Character values use single quotes and are stored by their ASCII value.";
          lastHighlightMem = "grade";
          terminalOutput = null;
          infoMsg = null;
          errorMsg = null;
          showSidebar = true;
          showQuiz = false;
          showFormatTable = false;
          showRangeOverlay = false;
          showArrows = false;
          break;
        case CharStep.printChar:
          code = ["char grade;", "grade = 'A';", 'printf("Grade: %c\\n", grade);'];
          terminalOutput = "Grade: A";
          annotation = "%c displays a single character.";
          lastHighlightMem = null;
          infoMsg = null;
          errorMsg = null;
          showSidebar = true;
          showQuiz = false;
          showFormatTable = false;
          showRangeOverlay = false;
          showArrows = false;
          break;
        case CharStep.assignAscii:
          code = ["char grade;", "grade = 'A';", 'printf("Grade: %c\\n", grade);', "char letter = 66;"];
          memory["letter"] = String.fromCharCode(66);
          annotation = "Numeric ASCII values can represent characters too.";
          lastHighlightMem = "letter";
          terminalOutput = null;
          infoMsg = null;
          errorMsg = null;
          showSidebar = true;
          showQuiz = false;
          showFormatTable = false;
          showRangeOverlay = false;
          showArrows = false;
          break;
        case CharStep.printAscii:
          code = ["char grade;", "grade = 'A';", 'printf("Grade: %c\\n", grade);', "char letter = 66;", 'printf("%c", letter);'];
          terminalOutput = "B";
          lastHighlightMem = null;
          annotation = null;
          infoMsg = null;
          errorMsg = null;
          showSidebar = true;
          showQuiz = false;
          showFormatTable = false;
          showRangeOverlay = false;
          showArrows = false;
          break;
        case CharStep.wrongMulti:
          code = ["char hello = 'Hello';"];
          errorMsg = "Only one character allowed per char. Use a string!";
          terminalOutput = null;
          annotation = null;
          infoMsg = null;
          showSidebar = false;
          showQuiz = false;
          showFormatTable = false;
          showRangeOverlay = false;
          showArrows = false;
          break;
        case CharStep.stringIntro:
          code = ['char greeting[] = "Hello";'];
          memory["greeting"] = "Hello";
          terminalOutput = null;
          infoMsg = null;
          errorMsg = null;
          annotation = null;
          showSidebar = false;
          showQuiz = false;
          showFormatTable = false;
          showRangeOverlay = false;
          showArrows = false;
          break;
        case CharStep.printString:
          code = ['char greeting[] = "Hello";', 'printf("%s", greeting);'];
          terminalOutput = "Hello";
          annotation = '%s prints strings (arrays of char, ending with \'\\0\').';
          infoMsg = null;
          errorMsg = null;
          showSidebar = false;
          showQuiz = false;
          showFormatTable = false;
          showRangeOverlay = false;
          showArrows = false;
          break;
        case CharStep.charRange:
          code = [];
          showRangeOverlay = true;
          terminalOutput = null;
          infoMsg = null;
          errorMsg = null;
          annotation = null;
          showSidebar = false;
          showQuiz = false;
          showFormatTable = false;
          showArrows = false;
          break;
        case CharStep.formatTable:
          code = [];
          showFormatTable = true;
          terminalOutput = null;
          infoMsg = null;
          errorMsg = null;
          annotation = null;
          showSidebar = false;
          showQuiz = false;
          showRangeOverlay = false;
          showArrows = false;
          break;
        case CharStep.multiPrintf:
          code = ["int day = 21;", 'char month[] = "July";', 'printf("Date: %d %s", day, month);'];
          memory["day"] = 21;
          memory["month"] = "July";
          terminalOutput = "Date: 21 July";
          showArrows = true;
          annotation = null;
          infoMsg = null;
          errorMsg = null;
          showSidebar = false;
          showQuiz = false;
          showFormatTable = false;
          showRangeOverlay = false;
          lastHighlightMem = null;
          break;
        case CharStep.recap:
          code = [];
          annotation = "Char stores a single letter; %c prints it. Use proper specifiers!";
          terminalOutput = null;
          infoMsg = null;
          errorMsg = null;
          showSidebar = false;
          showQuiz = false;
          showFormatTable = false;
          showRangeOverlay = false;
          showArrows = false;
          lastHighlightMem = null;
          break;
        case CharStep.quiz:
          code = [];
          showQuiz = true;
          terminalOutput = null;
          infoMsg = null;
          errorMsg = null;
          annotation = null;
          showSidebar = false;
          showFormatTable = false;
          showRangeOverlay = false;
          showArrows = false;
          lastHighlightMem = null;
          break;
      }
      stepReady = true;
    });
  }

  // THEME-BASED COLOR HELPERS

  Color _getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.greenAccent.shade200
        : Colors.black87;
  }

  Color _getCodeCharColor(BuildContext context, String line) {
    if (Theme.of(context).brightness == Brightness.dark) {
      if (line.contains('char') || line.contains('%c')) {
        return Colors.lightGreenAccent.shade400;
      }
      return Colors.greenAccent.shade100;
    }
    return line.contains('char') || line.contains('%c')
        ? Colors.deepPurple
        : Colors.black87;
  }

  Color _getAnnotationBgColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.amber[600]!;
  }

  Color _getAnnotationTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.greenAccent.shade200
        : Colors.amber[900]!;
  }

  Color _getInfoBoxBgColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.green.shade900.withOpacity(0.45)
        : Colors.blue[50]!;
  }

  Color _getInfoBoxTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.greenAccent.shade200
        : Colors.blue[900]!;
  }

  Color _getErrorBoxBgColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.red.shade900.withOpacity(0.65)
        : Colors.red[50]!;
  }

  Color _getErrorBoxTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.redAccent.shade200
        : Colors.red[800]!;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 500.0;
    final textColor = _getTextColor(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('char & Format Specifiers in C'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: isMobile ? 8.0 : 23.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                          minWidth: constraints.maxWidth),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _codeEditor(isMobile, context),
                            SizedBox(height: 10.0),
                            _memoryGrid(isMobile, context),
                            if (showSidebar) _sidebar(isMobile, context),
                            if (terminalOutput != null)
                              _terminal(isMobile, context),
                            if (annotation != null)
                              _annotBox(annotation!, _getAnnotationBgColor(context), _getAnnotationTextColor(context)),
                            if (errorMsg != null)
                              _errorBox(errorMsg!, _getErrorBoxBgColor(context), _getErrorBoxTextColor(context)),
                            if (infoMsg != null)
                              _annotBox(infoMsg!, _getInfoBoxBgColor(context), _getInfoBoxTextColor(context)),
                            if (showRangeOverlay) _charRangeOverlay(context),
                            if (showFormatTable) _formatTable(isMobile, context),
                            if (showArrows) _arrowsToPrintf(context),
                            if (showQuiz) _quizBox(context),
                            SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: stepReady && step != CharStep.intro ? _onPrevious : null,
                    icon: Icon(Icons.arrow_back),
                    label: Text('Previous Step'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(isMobile ? 120.0 : 140.0, 44.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                      textStyle: TextStyle(fontSize: isMobile ? 14.0 : 17.0),
                    ),
                  ),
                  if (step != CharStep.quiz)
                    ElevatedButton.icon(
                      onPressed: stepReady ? _onNext : null,
                      icon: Icon(Icons.arrow_forward),
                      label: Text(step == CharStep.recap ? "Quiz" : "Next Step"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(isMobile ? 120.0 : 140.0, 44.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                        textStyle: TextStyle(fontSize: isMobile ? 14.0 : 17.0),
                      ),
                    ),
                  if (step == CharStep.quiz)
                    ElevatedButton.icon(
                      onPressed: stepReady ? _onFinish : null,
                      icon: Icon(Icons.check),
                      label: Text("Finish"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(isMobile ? 120.0 : 140.0, 44.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                        textStyle: TextStyle(fontSize: isMobile ? 14.0 : 17.0),
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

  Widget _codeEditor(bool isMobile, BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark ? Colors.black12 : Colors.grey[50],
      border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade700 : Colors.black12, width: 1.2),
      borderRadius: BorderRadius.circular(12.0),
    ),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: code
          .map((l) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: RichText(
          text: TextSpan(
            text: l,
            style: TextStyle(
              fontFamily: "monospace",
              color: _getCodeCharColor(context, l),
              fontSize: 16.0,
            ),
          ),
        ),
      ))
          .toList(),
    ),
  );

  Widget _memoryGrid(bool isMobile, BuildContext context) {
    if (memory.isEmpty) return SizedBox.shrink();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text('Memory:',
              style: TextStyle(fontWeight: FontWeight.bold, color: _getTextColor(context))),
          SizedBox(width: 10.0),
          ...memory.entries.map((e) => _memoryCell(
            label: e.key,
            value: e.value,
            highlight: lastHighlightMem == e.key,
            context: context,
          )),
        ],
      ),
    );
  }

  Widget _memoryCell({
    required String label,
    required dynamic value,
    required bool highlight,
    required BuildContext context,
  }) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 11.0),
      decoration: BoxDecoration(
        color: highlight
            ? (isDark ? Colors.greenAccent.shade100.withOpacity(0.15) : Colors.amber[50])
            : isDark ? Colors.black26 : Colors.white,
        border: Border.all(
            color: highlight ? Colors.greenAccent.shade400 : (isDark ? Colors.greenAccent.shade700 : Colors.blue[100]!),
            width: 2.0),
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: _getTextColor(context))),
          SizedBox(height: 2.0),
          Text(
            value == null
                ? '—'
                : value is String && value.length == 1
                ? "'$value'\n(${value.codeUnitAt(0)})"
                : value.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.0, color: Colors.greenAccent.shade200),
          ),
        ],
      ),
    );
  }

  Widget _sidebar(bool isMobile, BuildContext context) => Container(
    margin: EdgeInsets.only(left: 13.0, top: 7.0, bottom: 7.0),
    padding: EdgeInsets.all(isMobile ? 8.0 : 13.0),
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark ? Colors.green.shade900.withOpacity(0.25) : Colors.indigo[50],
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.green.shade700 : Colors.blue[100]!,
          width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('char type', style: TextStyle(fontWeight: FontWeight.bold, color: _getTextColor(context))),
        Text('• Stores one letter/symbol\n• Needs 1 byte', style: TextStyle(color: _getTextColor(context))),
        SizedBox(height: 5.0),
        Text('String', style: TextStyle(fontWeight: FontWeight.bold, color: _getTextColor(context))),
        Text('• Array of chars\n• Needs enough space for each letter plus \\0', style: TextStyle(color: _getTextColor(context))),
      ],
    ),
  );

  Widget _terminal(bool isMobile, BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 7.0),
    child: Container(
      constraints: BoxConstraints(minHeight: 40.0, maxHeight: 65.0),
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            terminalOutput ?? "",
            style: TextStyle(color: Colors.greenAccent.shade200, fontSize: 15.0),
          ),
        ),
      ),
    ),
  );

  Widget _annotBox(String text, Color bgColor, Color textColor) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 13.0),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(text,
        style: TextStyle(fontSize: 15.0, color: textColor),
        softWrap: true),
  );

  Widget _errorBox(String text, Color bgColor, Color textColor) => Container(
    margin: EdgeInsets.all(13.0),
    padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 15.0),
    decoration: BoxDecoration(
      color: bgColor,
      border: Border.all(color: textColor, width: 1.2),
      borderRadius: BorderRadius.circular(11.0),
    ),
    child: Row(
      children: [
        Icon(Icons.error_outline, color: textColor, size: 20.0),
        SizedBox(width: 7.0),
        Expanded(
            child: Text(text, style: TextStyle(color: textColor, fontSize: 14.0), softWrap: true)),
      ],
    ),
  );

  Widget _charRangeOverlay(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(vertical: 20.0),
    padding: EdgeInsets.all(15.0),
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark ? Colors.green.shade900.withOpacity(0.15) : Colors.teal[50],
      borderRadius: BorderRadius.circular(13.0),
      border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.green.shade700 : Colors.teal[200]!,
          width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('char Range:',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade200 : Colors.teal)),
        SizedBox(height: 4.0),
        Text(
            'Signed: -128 to 127   Unsigned: 0 to 255\nA char stores one byte as either a number or a single character.',
            style: TextStyle(
                fontSize: 13.0,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade100 : Colors.black87)),
      ],
    ),
  );

  Widget _formatTable(bool isMobile, BuildContext context) {
    List<Map<String, String>> data = [
      {"Data Type": "int", "Example": "25", "Format Specifier": "%d / %i"},
      {"Data Type": "char", "Example": "'A'", "Format Specifier": "%c"},
      {"Data Type": "float", "Example": "3.14f", "Format Specifier": "%f"},
      {"Data Type": "double", "Example": "3.1415926", "Format Specifier": "%lf (or %f)"},
      {"Data Type": "string", "Example": '"Hello"', "Format Specifier": "%s"},
    ];
    List<String> headers = data.first.keys.toList();

    Color textColor = _getTextColor(context);
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 13.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.green.shade900.withOpacity(0.18) : Colors.blue[50],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: isDark ? Colors.green.shade700 : Colors.blue[100]!, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Format Specifiers Table",
              style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
          Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: headers
                  .map((h) => DataColumn(
                  label: Text(h,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: textColor))))
                  .toList(),
              rows: data
                  .map((row) => DataRow(
                cells: headers
                    .map((col) => DataCell(Text(row[col]!,
                    style: TextStyle(fontSize: 13.0, color: textColor))))
                    .toList(),
              ))
                  .toList(),
              headingRowHeight: 35.0,
              dataRowHeight: 29.0,
              columnSpacing: 13.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrowsToPrintf(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(vertical: 10.0),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.arrow_downward, color: Colors.greenAccent.shade200, size: 26.0),
      Text("Variables ➔ correct position in format string",
          style: TextStyle(color: Colors.greenAccent.shade200)),
    ]),
  );

  Widget _quizBox(BuildContext context) {
    List<String> options = ["%d", "%c", "%f", "%s", "%lf"];
    return Container(
      margin: EdgeInsets.only(top: 14.0, bottom: 10.0),
      padding: EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.green.shade900.withOpacity(0.15) : Colors.teal[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.green.shade700 : Colors.teal[200]!, width: 1.2),
      ),
      child: Column(
        children: [
          if (quizFeedback != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                quizFeedback!,
                style: TextStyle(
                    color: quizFeedback == "Correct!" ? Colors.greenAccent.shade200 : Colors.redAccent.shade200,
                    fontWeight: FontWeight.bold),
              ),
            ),
          Text(quizQuestion!,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: _getTextColor(context),
              )),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            children: options
                .map(
                  (o) => ElevatedButton(
                onPressed: () {
                  setState(() {
                    quizAnswer = o;
                    quizFeedback =
                    (o == "%c") ? "Correct!" : "Try again!";
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(57.0, 33.0),
                  backgroundColor: quizAnswer == o
                      ? Colors.greenAccent.shade400
                      : (Theme.of(context).brightness == Brightness.dark ? Colors.green.shade700 : Colors.teal[100]),
                  foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black87,
                ),
                child: Text(o),
              ),
            )
                .toList(),
          )
        ],
      ),
    );
  }
}
