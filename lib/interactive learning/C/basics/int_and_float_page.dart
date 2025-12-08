import 'package:flutter/material.dart';

enum NumberStep {
  intro,
  declareInt,
  showIntMem,
  intTable,
  unsignedPopup,
  declareFloat,
  showFloatMem,
  floatTable,
  floatPrecision,
  doublePrecision,
  typeConversion,
  invalidAssign,
  sizeofDemo,
  recap,
  quiz,
}

class IntAndFloatPage extends StatefulWidget {
  @override
  State<IntAndFloatPage> createState() => _IntAndFloatPageState();
}

class _IntAndFloatPageState extends State<IntAndFloatPage> {
  NumberStep step = NumberStep.intro;
  List<String> code = [];
  Map<String, dynamic> memory = {};
  String? infoMsg;
  String? errorMsg;
  String? annotation;
  bool showSidebar = false;
  bool showIntTable = false;
  bool showUnsigPopup = false;
  bool showFloatTable = false;
  bool showQuiz = false;
  bool showFloatPrecision = false;
  bool showDoublePrecision = false;
  bool showSizeofDemo = false;
  String? terminalOutput;
  String? quizAnswer;
  String? quizFeedback;
  String? quizQuestion = "Which data type would you use for a student's grade point (e.g., 3.67)?";
  bool stepReady = true;

  List<Map<String, dynamic>> intTypes = [
    {
      "Type": "int",
      "Example": "int n;",
      "Range": "-32,768 to 32,767",
      "Size": "2 or 4 bytes"
    },
    {
      "Type": "short",
      "Example": "short s;",
      "Range": "-32,768 to 32,767",
      "Size": "2 bytes"
    },
    {
      "Type": "long",
      "Example": "long l;",
      "Range": "-2,147,483,648 to 2,147,483,647",
      "Size": "4 bytes"
    },
    {
      "Type": "unsigned int",
      "Example": "unsigned int u;",
      "Range": "0 to 65,535",
      "Size": "same as int"
    },
  ];
  List<Map<String, dynamic>> floatTypes = [
    {
      "Type": "float",
      "Example": "float f;",
      "Precision": "~6-7 digits",
      "Size": "4 bytes"
    },
    {
      "Type": "double",
      "Example": "double d;",
      "Precision": "~15 digits",
      "Size": "8 bytes"
    },
    {
      "Type": "long double",
      "Example": "long double ld;",
      "Precision": "~19 digits",
      "Size": "10-16 bytes"
    },
  ];

  @override
  void initState() {
    super.initState();
    code.clear();
    _prepareStep();
  }

  void _onNext() {
    setState(() {
      infoMsg = null;
      errorMsg = null;
      annotation = null;
      terminalOutput = null;
    });
    switch (step) {
      case NumberStep.intro:
        step = NumberStep.declareInt;
        break;
      case NumberStep.declareInt:
        step = NumberStep.showIntMem;
        break;
      case NumberStep.showIntMem:
        step = NumberStep.intTable;
        break;
      case NumberStep.intTable:
        step = NumberStep.unsignedPopup;
        break;
      case NumberStep.unsignedPopup:
        step = NumberStep.declareFloat;
        break;
      case NumberStep.declareFloat:
        step = NumberStep.showFloatMem;
        break;
      case NumberStep.showFloatMem:
        step = NumberStep.floatTable;
        break;
      case NumberStep.floatTable:
        step = NumberStep.floatPrecision;
        break;
      case NumberStep.floatPrecision:
        step = NumberStep.doublePrecision;
        break;
      case NumberStep.doublePrecision:
        step = NumberStep.typeConversion;
        break;
      case NumberStep.typeConversion:
        step = NumberStep.invalidAssign;
        break;
      case NumberStep.invalidAssign:
        step = NumberStep.sizeofDemo;
        break;
      case NumberStep.sizeofDemo:
        step = NumberStep.recap;
        break;
      case NumberStep.recap:
        step = NumberStep.quiz;
        break;
      case NumberStep.quiz:
        break;
    }
    _prepareStep();
  }

  void _onPrevious() {
    setState(() {
      infoMsg = null;
      errorMsg = null;
      annotation = null;
      terminalOutput = null;
    });
    switch (step) {
      case NumberStep.intro:
        break;
      case NumberStep.declareInt:
        step = NumberStep.intro;
        break;
      case NumberStep.showIntMem:
        step = NumberStep.declareInt;
        break;
      case NumberStep.intTable:
        step = NumberStep.showIntMem;
        break;
      case NumberStep.unsignedPopup:
        step = NumberStep.intTable;
        break;
      case NumberStep.declareFloat:
        step = NumberStep.unsignedPopup;
        break;
      case NumberStep.showFloatMem:
        step = NumberStep.declareFloat;
        break;
      case NumberStep.floatTable:
        step = NumberStep.showFloatMem;
        break;
      case NumberStep.floatPrecision:
        step = NumberStep.floatTable;
        break;
      case NumberStep.doublePrecision:
        step = NumberStep.floatPrecision;
        break;
      case NumberStep.typeConversion:
        step = NumberStep.doublePrecision;
        break;
      case NumberStep.invalidAssign:
        step = NumberStep.typeConversion;
        break;
      case NumberStep.sizeofDemo:
        step = NumberStep.invalidAssign;
        break;
      case NumberStep.recap:
        step = NumberStep.sizeofDemo;
        break;
      case NumberStep.quiz:
        step = NumberStep.recap;
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
      infoMsg = null;
      errorMsg = null;
      annotation = null;
      terminalOutput = null;
      showSidebar = false;
      showIntTable = false;
      showUnsigPopup = false;
      showFloatTable = false;
      showQuiz = false;
      showFloatPrecision = false;
      showDoublePrecision = false;
      showSizeofDemo = false;
    });
    switch (step) {
      case NumberStep.intro:
        code = [];
        memory = {};
        infoMsg = "Let’s explore different number types in C!";
        break;
      case NumberStep.declareInt:
        code = ['int age = 21;'];
        infoMsg = "int stores whole numbers (no decimals), typically 2 or 4 bytes.";
        break;
      case NumberStep.showIntMem:
        memory.clear();
        memory['age'] = 21;
        showSidebar = true;
        break;
      case NumberStep.intTable:
        showIntTable = true;
        break;
      case NumberStep.unsignedPopup:
        showUnsigPopup = true;
        break;
      case NumberStep.declareFloat:
        code = ['float gpa = 3.85;'];
        infoMsg = "float stores decimal numbers, typically using 4 bytes.";
        break;
      case NumberStep.showFloatMem:
        memory['gpa'] = 3.85;
        break;
      case NumberStep.floatTable:
        showFloatTable = true;
        break;
      case NumberStep.floatPrecision:
        code = ['float gpa = 3.85;', 'float pi = 3.1415926535;'];
        terminalOutput = "pi = 3.141593";
        annotation = "Floats only keep about 6-7 digits accurately.";
        showFloatPrecision = true;
        break;
      case NumberStep.doublePrecision:
        code = ['float gpa = 3.85;', 'float pi = 3.1415926535;', 'double pi = 3.1415926535;'];
        terminalOutput = "pi = 3.1415926535";
        annotation = "Double stores more digits (15+).";
        showDoublePrecision = true;
        break;
      case NumberStep.typeConversion:
        code = ['int x = 5;', 'float y = x;'];
        memory['x'] = 5;
        memory['y'] = 5.0;
        annotation =
        "C allows conversion from int to float. Precision can be lost when converting float to int!";
        break;
      case NumberStep.invalidAssign:
        code = ['int a = 3.8;'];
        memory['a'] = 3;
        errorMsg = "Assigning a float to int truncates the decimal: a = 3.";
        break;
      case NumberStep.sizeofDemo:
        code = ['printf("%zu", sizeof(double));'];
        terminalOutput = "8";
        infoMsg = "sizeof reveals how much memory a type uses in bytes.";
        showSizeofDemo = true;
        break;
      case NumberStep.recap:
        showQuiz = true;
        break;
      case NumberStep.quiz:
        showQuiz = true;
        break;
    }
    setState(() {
      stepReady = true;
    });
  }

  // THEME COLOR HELPERS

  Color _getTextColorDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.greenAccent.shade100
          : Colors.black87;

  Color _getSubtleTextColorDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.green[200]!
          : Colors.blueGrey[600]!;

  Color _getCodeColor(BuildContext context, String l) {
    if (Theme.of(context).brightness == Brightness.dark) {
      if (l.contains('float') || l.contains('double')) {
        return Colors.lightGreenAccent.shade400;
      }
      if (l.contains('int')) return Colors.greenAccent.shade200;
      return Colors.greenAccent.shade100;
    }
    return l.contains('float')
        ? Colors.teal[700]!
        : (l.contains('double') ? Colors.blue[800]! : Colors.black87);
  }

  Color _getInfoBg(BuildContext context) => Theme.of(context).brightness == Brightness.dark
      ? Colors.green.shade900.withOpacity(0.30)
      : Colors.blue[100]!;

  Color _getInfoText(BuildContext context) => Theme.of(context).brightness == Brightness.dark
      ? Colors.greenAccent.shade100
      : Colors.blue[900]!;

  Color _getAnnoBg(BuildContext context) => Theme.of(context).brightness == Brightness.dark
      ? Colors.black87
      : Colors.amber[700]!;

  Color _getAnnoText(BuildContext context) => Theme.of(context).brightness == Brightness.dark
      ? Colors.greenAccent.shade100
      : Colors.amber[50]!;

  Color _getErrorBg(BuildContext context) => Theme.of(context).brightness == Brightness.dark
      ? Colors.red.shade900.withOpacity(.75)
      : Colors.red[50]!;

  Color _getErrorText(BuildContext context) => Theme.of(context).brightness == Brightness.dark
      ? Colors.redAccent.shade100
      : Colors.red[800]!;

  Color _getMemBg(BuildContext context) => Theme.of(context).brightness == Brightness.dark
      ? Colors.black38
      : Colors.white;

  Color _getMemBorder(BuildContext context, String type) =>
      type == 'int'
          ? Theme.of(context).brightness == Brightness.dark
          ? Colors.tealAccent.shade100
          : Colors.blue[200]!
          : Theme.of(context).brightness == Brightness.dark
          ? Colors.greenAccent.shade100
          : Colors.green[200]!;

  Color _getMemValueColor(BuildContext context, String type) => type == 'int'
      ? Theme.of(context).brightness == Brightness.dark
      ? Colors.greenAccent.shade200
      : Colors.blue
      : Theme.of(context).brightness == Brightness.dark
      ? Colors.lightGreenAccent
      : Colors.teal[700]!;

  Color _getQuizBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withOpacity(.35)
          : Colors.white;

  Color _getQuizBtnBg(BuildContext context, String o) => Theme.of(context).brightness == Brightness.dark
      ? Colors.green.shade700
      : Colors.teal[100]!;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 500.0;
    final textColor = _getTextColorDark(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('int, float, and Types in C'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _codeEditor(isMobile, context),
                      SizedBox(height: 10.0),
                      _memoryGrid(isMobile, context),
                      if (showSidebar)
                        Align(
                          alignment: Alignment.centerRight,
                          child: _sidebar(isMobile, context),
                        ),
                      if (annotation != null)
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: _labelBox(
                              annotation!,
                              _getAnnoBg(context),
                              _getAnnoText(context)),
                        ),
                      if (terminalOutput != null ||
                          showFloatPrecision ||
                          showDoublePrecision ||
                          showSizeofDemo)
                        _terminal(isMobile, context),
                      if (showIntTable)
                        _typeTable(isMobile, intTypes, "Integer Types", context),
                      if (showFloatTable)
                        _typeTable(isMobile, floatTypes, "Floating-Point Types", context),
                      if (showUnsigPopup)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: _labelBox(
                              "Unsigned types cannot store negative numbers.",
                              _getInfoBg(context),
                              _getInfoText(context)),
                        ),
                      if (infoMsg != null)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          child: _labelBox(
                              infoMsg!,
                              _getInfoBg(context),
                              _getInfoText(context)),
                        ),
                      if (errorMsg != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: _errorBox(errorMsg!, context),
                        ),
                      if (showQuiz) _recapBox(isMobile, context),
                      SizedBox(height: 18.0),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: step != NumberStep.intro && stepReady ? _onPrevious : null,
                      icon: Icon(Icons.arrow_back),
                      label: Text('Previous Step'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(isMobile ? 95.0 : 120.0, 44.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                        textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                      ),
                    ),
                    if (step != NumberStep.quiz)
                      ElevatedButton.icon(
                        onPressed: stepReady ? _onNext : null,
                        icon: Icon(Icons.arrow_forward),
                        label: Text('Next Step'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(isMobile ? 95.0 : 120.0, 44.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                          textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                        ),
                      ),
                    if (step == NumberStep.quiz)
                      ElevatedButton.icon(
                        onPressed: _onFinish,
                        icon: Icon(Icons.check),
                        label: Text('Finish'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(isMobile ? 95.0 : 120.0, 44.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                          textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _codeEditor(bool isMobile, BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: isMobile ? 6.0 : 24.0),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.black12 : Colors.grey[50],
        border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.tealAccent.shade700 : Colors.black12,
            width: 1.4),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: code
            .map((l) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: RichText(
              text: TextSpan(
                text: l,
                style: TextStyle(
                  fontFamily: "monospace",
                  color: _getCodeColor(context, l),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ))
            .toList(),
      ),
    ),
  );

  Widget _memoryGrid(bool isMobile, BuildContext context) {
    if (memory.isEmpty) return SizedBox.shrink();
    final memList = memory.entries.toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.0 : 22.0, vertical: 2),
      child: Row(
        children: [
          Text('Memory:',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: _getTextColorDark(context))),
          SizedBox(width: 12.0),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var e in memList)
                    _memoryCell(
                      label: e.key,
                      value: e.value,
                      type: _guessType(e.key),
                      context: context,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _guessType(String key) {
    if (key == 'age' || key == 'x' || key == 'a') return 'int';
    if (key == 'gpa' || key == 'y' || key == 'pi') return 'float/double';
    return 'var';
  }

  Widget _memoryCell({
    required String label,
    dynamic value,
    required String type,
    required BuildContext context,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 10.0, bottom: 6.0, top: 2.0),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: _getMemBg(context),
        border: Border.all(
            color: _getMemBorder(context, type), width: 2.0),
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: Column(
        children: [
          Text('$label',
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _getTextColorDark(context))),
          Text(type,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                color: _getSubtleTextColorDark(context),
              )),
          SizedBox(height: 3.0),
          Text(value == null ? '—' : value.toString(),
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: _getMemValueColor(context, type))),
        ],
      ),
    );
  }

  Widget _sidebar(bool isMobile, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: isMobile ? 8.0 : 22.0, top: 9.0, bottom: 10),
      padding: EdgeInsets.all(isMobile ? 9.0 : 16.0),
      width: isMobile ? 180.0 : 240.0,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.green.shade900.withOpacity(0.25)
            : Colors.blue[50],
        borderRadius: BorderRadius.circular(13.0),
        border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.green.shade700
                : Colors.blue[100]!,
            width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Number Types',
              style: TextStyle(fontWeight: FontWeight.bold, color: _getTextColorDark(context))),
          SizedBox(height: 8.0),
          Text('int — integer (whole numbers)', style: TextStyle(fontSize: 13.0, color: _getTextColorDark(context))),
          Text('float — decimals (e.g. 3.14)', style: TextStyle(fontSize: 13.0, color: _getTextColorDark(context))),
          Text('double — more digits/precision', style: TextStyle(fontSize: 13.0, color: _getTextColorDark(context))),
          Text('unsigned — no negative', style: TextStyle(fontSize: 13.0, color: _getTextColorDark(context))),
        ],
      ),
    );
  }

  Widget _typeTable(
      bool isMobile, List<Map<String, dynamic>> types, String title, BuildContext context) {
    List<String> headers = types.first.keys.toList();
    final darkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 9.0 : 24.0, vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: darkMode ? Colors.green.shade900.withOpacity(.12) : Colors.blue[50],
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
              color: darkMode ? Colors.green.shade700 : Colors.blue[100]!,
              width: 1.2),
        ),
        padding: EdgeInsets.all(isMobile ? 7.0 : 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getTextColorDark(context))),
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
                            color: _getTextColorDark(context)))))
                    .toList(),
                rows: types
                    .map((row) => DataRow(
                  cells: headers
                      .map((col) => DataCell(
                      Text(row[col].toString(),
                          style: TextStyle(fontSize: 13.0, color: _getTextColorDark(context)))))
                      .toList(),
                ))
                    .toList(),
                headingRowHeight: 33.0,
                dataRowHeight: 26.0,
                columnSpacing: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _terminal(bool isMobile, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.0 : 20.0, vertical: 5.0),
      child: Container(
        constraints: BoxConstraints(minHeight: 40.0, maxHeight: 60.0),
        width: double.infinity,
        padding: EdgeInsets.all(9.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              terminalOutput ?? "",
              style: TextStyle(color: Colors.greenAccent.shade100, fontSize: 15.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _labelBox(String text, Color color, Color textColor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.0)],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: textColor, fontSize: 15.0, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _errorBox(String text, BuildContext context) {
    final errorBg = _getErrorBg(context);
    final errorColor = _getErrorText(context);
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 14.0),
      decoration: BoxDecoration(
        color: errorBg,
        border: Border.all(color: errorColor, width: 1.3),
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: errorColor, size: 19.0),
          SizedBox(width: 8.0),
          Expanded(
              child: Text(text,
                  style: TextStyle(color: errorColor, fontSize: 14.0))),
        ],
      ),
    );
  }

  Widget _recapBox(bool isMobile, BuildContext context) {
    List<String> options = [
      "int",
      "float",
      "double",
      "char",
    ];
    final quizBg = _getQuizBg(context);
    final quizBorder = Theme.of(context).brightness == Brightness.dark
        ? Colors.green[200]!
        : Colors.teal[200]!;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 9.0),
      padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 13.0),
      decoration: BoxDecoration(
        color: quizBg,
        border: Border.all(color: quizBorder, width: 1.2),
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.green[900]!.withOpacity(.05)
                  : Colors.teal[100]!,
              blurRadius: 7.0)
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Quick Recap & Use Cases',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: _getTextColorDark(context))),
          SizedBox(height: 8.0),
          _summaryRow("Use int", "for counting and indexing.", context),
          _summaryRow("Use float/double", "for measurements and precise values.", context),
          Divider(),
          Text("Quiz:", style: TextStyle(color: _getTextColorDark(context))),
          SizedBox(height: 9.0),
          if (quizFeedback != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                quizFeedback!,
                style: TextStyle(
                    color: quizFeedback == "Correct!"
                        ? Colors.greenAccent.shade100
                        : Colors.redAccent.shade200,
                    fontWeight: FontWeight.bold),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            child: Text(quizQuestion!, style: TextStyle(color: _getTextColorDark(context))),
          ),
          for (var o in options)
            Container(
              margin: EdgeInsets.symmetric(vertical: isMobile ? 3.0 : 2.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100.0, 38.0),
                  backgroundColor: quizAnswer == o
                      ? Colors.greenAccent.shade400
                      : _getQuizBtnBg(context, o),
                  foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black87,
                ),
                onPressed: () {
                  setState(() {
                    quizAnswer = o;
                    quizFeedback =
                    (o == "float" || o == "double") ? "Correct!" : "Try again!";
                  });
                },
                child: Text(o, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _summaryRow(String head, String desc, BuildContext context) {
    final headColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.greenAccent.shade100
        : Colors.teal;
    final descColor = _getTextColorDark(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(head,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: headColor,
                  fontSize: 13.0)),
          SizedBox(width: 6.0),
          Expanded(
              child: Text(desc, style: TextStyle(color: descColor, fontSize: 13.0))),
        ],
      ),
    );
  }
}
