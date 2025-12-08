import 'package:flutter/material.dart';

enum VariableStep {
  intro,
  declaration,
  memoryAlloc,
  assignment,
  usage,
  changeValue,
  scopeIntro,
  scopeBox,
  dataTypes,
  badNaming,
  uninitialized,
  typeSafety,
  comment,
  summary,
}

class VariableJourneyPage extends StatefulWidget {
  @override
  State<VariableJourneyPage> createState() => _VariableJourneyPageState();
}

class _VariableJourneyPageState extends State<VariableJourneyPage> {
  VariableStep step = VariableStep.intro;
  List<String> code = [];
  Map<String, dynamic> memory = {};
  String? infoMsg;
  String? annotation;
  String? terminalOutput;
  bool showScopeBox = false;
  bool showSidebar = false;
  bool badNamingError = false;
  bool uninitializedWarn = false;
  bool typeError = false;
  bool stepReady = true;

  @override
  void initState() {
    super.initState();
    code = [];
    _prepareStep();
  }

  Color _codeColor(BuildContext context, {bool isComment = false}) =>
      Theme.of(context).brightness == Brightness.dark
          ? isComment ? Colors.greenAccent.shade200 : Colors.greenAccent.shade100
          : isComment ? Colors.green[800]! : Colors.black87;

  Color _memValue(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.lightGreenAccent : Colors.teal[700]!;

  Color _labelBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.green.shade900.withOpacity(.32) : Colors.amber.shade700;
  Color _labelText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.greenAccent.shade100 : Colors.black87;

  Color _infoBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.green.shade900.withOpacity(.23) : Colors.blue[50]!;
  Color _infoText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.greenAccent.shade100 : Colors.blue[900]!;

  Color _errBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.red.shade900.withOpacity(.91) : Colors.red[50]!;
  Color _errText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.redAccent.shade100 : Colors.red[800]!;

  Color _memBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.white;

  Color _summaryBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.black.withOpacity(0.79) : Colors.white;
  Color _summaryShadow(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.green.shade900.withOpacity(.1) : Colors.teal[100]!;

  void _prepareStep() {
    setState(() {
      stepReady = false;
    });
    switch (step) {
      case VariableStep.intro:
        code = [];
        memory = {};
        terminalOutput = null;
        infoMsg = "Let's understand variables in C!";
        annotation = null;
        break;
      case VariableStep.declaration:
        code = ['int age;'];
        infoMsg = "int declares an integer variable named 'age'.";
        showSidebar = true;
        break;
      case VariableStep.memoryAlloc:
        memory['age'] = null;
        annotation = "Compiler reserves space in memory.";
        break;
      case VariableStep.assignment:
        code.add('age = 20;');
        memory['age'] = 20;
        annotation = "Assign a value to the variable.";
        break;
      case VariableStep.usage:
        code.add('printf("Age is %d", age);');
        terminalOutput = "Age is 20";
        annotation = "Use variable in output.";
        break;
      case VariableStep.changeValue:
        code.add('age = 25;');
        memory['age'] = 25;
        infoMsg = "Variables can be updated anytime.";
        break;
      case VariableStep.scopeIntro:
        annotation = "Variable exists only inside the block it's declared.";
        showScopeBox = true;
        break;
      case VariableStep.scopeBox:
        code.insert(0, '{');
        code.add('}');
        showScopeBox = false;
        break;
      case VariableStep.dataTypes:
        code.insert(code.length - 1, 'float salary;');
        code.insert(code.length - 1, 'char grade;');
        memory['salary'] = null;
        memory['grade'] = null;
        annotation = "Variables of different types need different memory.";
        break;
      case VariableStep.badNaming:
        badNamingError = true;
        break;
      case VariableStep.uninitialized:
        badNamingError = false;
        uninitializedWarn = true;
        break;
      case VariableStep.typeSafety:
        uninitializedWarn = false;
        typeError = true;
        break;
      case VariableStep.comment:
        typeError = false;
        code.insert(code.length - 1, '// This variable stores user age');
        infoMsg = "Comments make code readable.";
        break;
      case VariableStep.summary:
        infoMsg = null;
        break;
    }
    setState(() {
      stepReady = true;
    });
  }

  void _onNext() {
    if (!stepReady) return;
    setState(() {
      infoMsg = null;
      annotation = null;
      terminalOutput = null;
      badNamingError = false;
      uninitializedWarn = false;
      typeError = false;
      showSidebar = (step == VariableStep.declaration);
    });
    switch (step) {
      case VariableStep.intro:
        step = VariableStep.declaration; break;
      case VariableStep.declaration:
        step = VariableStep.memoryAlloc; break;
      case VariableStep.memoryAlloc:
        step = VariableStep.assignment; break;
      case VariableStep.assignment:
        step = VariableStep.usage; break;
      case VariableStep.usage:
        step = VariableStep.changeValue; break;
      case VariableStep.changeValue:
        step = VariableStep.scopeIntro; break;
      case VariableStep.scopeIntro:
        step = VariableStep.scopeBox; break;
      case VariableStep.scopeBox:
        step = VariableStep.dataTypes; break;
      case VariableStep.dataTypes:
        step = VariableStep.badNaming; break;
      case VariableStep.badNaming:
        step = VariableStep.uninitialized; break;
      case VariableStep.uninitialized:
        step = VariableStep.typeSafety; break;
      case VariableStep.typeSafety:
        step = VariableStep.comment; break;
      case VariableStep.comment:
        step = VariableStep.summary; break;
      case VariableStep.summary:
        Navigator.of(context).pop();
        return;
    }
    _prepareStep();
  }

  void _onPrevious() {
    setState(() {
      infoMsg = null;
      annotation = null;
      terminalOutput = null;
      badNamingError = false;
      uninitializedWarn = false;
      typeError = false;
    });
    switch (step) {
      case VariableStep.intro: break;
      case VariableStep.declaration:
        step = VariableStep.intro; break;
      case VariableStep.memoryAlloc:
        step = VariableStep.declaration; break;
      case VariableStep.assignment:
        step = VariableStep.memoryAlloc; break;
      case VariableStep.usage:
        step = VariableStep.assignment; break;
      case VariableStep.changeValue:
        step = VariableStep.usage; break;
      case VariableStep.scopeIntro:
        step = VariableStep.changeValue; break;
      case VariableStep.scopeBox:
        step = VariableStep.scopeIntro; break;
      case VariableStep.dataTypes:
        step = VariableStep.scopeBox; break;
      case VariableStep.badNaming:
        step = VariableStep.dataTypes; break;
      case VariableStep.uninitialized:
        step = VariableStep.badNaming; break;
      case VariableStep.typeSafety:
        step = VariableStep.uninitialized; break;
      case VariableStep.comment:
        step = VariableStep.typeSafety; break;
      case VariableStep.summary:
        step = VariableStep.comment; break;
    }
    _prepareStep();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 500;
    final fontSize = isMobile ? 14.0 : 16.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Journey of a Variable'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: isMobile ? 8.0 : 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _codeEditorArea(isMobile, fontSize, context),
              SizedBox(height: isMobile ? 9.0 : 18.0),
              _memoryGrid(isMobile, fontSize, context),
              if (terminalOutput != null || step == VariableStep.usage)
                _terminalArea(isMobile, fontSize, context),
              if (showSidebar)
                Align(
                  alignment: Alignment.centerRight,
                  child: _sidebar(isMobile, fontSize, context),
                ),
              if (annotation != null)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _animatedLabel(annotation!, _labelBg(context), _labelText(context), fontSize),
                ),
              if (badNamingError)
                _errorBox("Variable names cannot start with a number!", fontSize, context),
              if (uninitializedWarn)
                _errorBox("Using variables without initialization can cause bugs.", fontSize, context),
              if (typeError)
                _errorBox("Can't assign string to integer variable.", fontSize, context),
              if (infoMsg != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 6.0),
                  child: _animatedLabel(infoMsg!, _infoBg(context), _infoText(context), fontSize),
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 7 : 26, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: step != VariableStep.intro ? _onPrevious : null,
                      icon: Icon(Icons.arrow_back_ios, size: 18.0),
                      label: Text('Previous Step'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(isMobile ? 95 : 116, isMobile ? 32 : 44),
                        textStyle: TextStyle(fontSize: fontSize - 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      ),
                    ),
                    if (step != VariableStep.summary)
                      ElevatedButton.icon(
                        onPressed: stepReady ? _onNext : null,
                        label: Text('Next Step'),
                        icon: Icon(Icons.arrow_forward_ios, size: 18.0),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(isMobile ? 95 : 116, isMobile ? 32 : 44),
                          textStyle: TextStyle(fontSize: fontSize),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                        ),
                      ),
                    if (step == VariableStep.summary)
                      ElevatedButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.done),
                        label: Text('Finish'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(isMobile ? 95 : 120, isMobile ? 32 : 44),
                          textStyle: TextStyle(fontSize: fontSize),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                        ),
                      ),
                  ],
                ),
              ),
              if (step == VariableStep.summary)
                _summaryBox(isMobile, fontSize, context),
              SizedBox(height: 11.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _codeEditorArea(bool isMobile, double fontSize, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.0 : 24.0, vertical: isMobile ? 5.0 : 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.black26 : Colors.grey[50],
          border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade700 : Colors.black12, width: 1.4),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: isMobile ? 6.0 : 16.0),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 7.0,
                children: code
                    .asMap()
                    .map((i, l) => MapEntry(
                    i,
                    _codeLine(
                      l,
                      (step == VariableStep.declaration && l == 'int age;') ||
                          (step == VariableStep.assignment && l == 'age = 20;') ||
                          (step == VariableStep.changeValue && l == 'age = 25;'),
                      fontSize,
                      context,
                    )))
                    .values
                    .toList(),
              ),
            ),
            if (showScopeBox)
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2.5),
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _codeLine(String line, bool highlight, double fontSize, BuildContext context) {
    final bool isComment = line.trim().startsWith('//');
    return AnimatedContainer(
      duration: Duration(milliseconds: 230),
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      padding: EdgeInsets.only(left: isComment ? 8.0 : 0.0),
      decoration: highlight ? BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.yellow.shade700.withOpacity(0.09)
            : Colors.yellow.withOpacity(0.16),
        borderRadius: BorderRadius.circular(5.0),
      ) : null,
      child: RichText(
        text: TextSpan(
          text: line,
          style: TextStyle(
            fontFamily: "monospace",
            color: _codeColor(context, isComment: isComment),
            fontSize: fontSize,
            fontWeight: isComment ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _memoryGrid(bool isMobile, double fontSize, BuildContext context) {
    final memList = memory.entries.toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.0 : 24.0),
      child: Row(
        children: [
          Text('Memory:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize - 1.0,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.greenAccent.shade200
                      : null)),
          SizedBox(width: isMobile ? 7.0 : 16.0),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  for (var e in memList)
                    _memoryCell(
                      label: e.key,
                      value: e.value,
                      highlighted: (step == VariableStep.memoryAlloc && e.key == 'age') ||
                          (step == VariableStep.assignment && e.key == 'age') ||
                          (step == VariableStep.changeValue && e.key == 'age'),
                      type: e.key == 'age'
                          ? 'int'
                          : (e.key == 'salary' ? 'float' : 'char'),
                      fontSize: fontSize,
                      isMobile: isMobile,
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

  Widget _memoryCell({
    required String label,
    dynamic value,
    required bool highlighted,
    required String type,
    required double fontSize,
    required bool isMobile,
    required BuildContext context,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 4.0 : 6.0, vertical: 3.0),
      padding: EdgeInsets.symmetric(vertical: isMobile ? 11.0 : 15.0, horizontal: isMobile ? 8.0 : 11.0),
      decoration: BoxDecoration(
        color: highlighted
            ? (Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade100.withOpacity(.10) : Colors.amber[100])
            : _memBg(context),
        border: Border.all(
            color: highlighted
                ? (Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade400 : Colors.amber)
                : (Theme.of(context).brightness == Brightness.dark ? Colors.green.shade800 : Colors.grey[400]!),
            width: 2.0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label ($type)', style: TextStyle(fontSize: fontSize - 2.0,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.greenAccent.shade100 : null)),
          SizedBox(height: 3.0),
          Text(
            value == null ? '—' : value.toString(),
            style: TextStyle(
                fontSize: fontSize + 2.0,
                fontWeight: FontWeight.bold,
                color: _memValue(context)),
          ),
        ],
      ),
    );
  }

  Widget _terminalArea(bool isMobile, double fontSize, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.0 : 24.0, vertical: 3.0),
      child: Container(
        constraints: BoxConstraints(minHeight: 40.0, maxHeight: 60.0),
        width: double.infinity,
        padding: EdgeInsets.all(isMobile ? 7.0 : 10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              terminalOutput ?? "",
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.greenAccent.shade100
                      : Colors.greenAccent, fontSize: fontSize),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sidebar(bool isMobile, double fontSize, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: isMobile ? 8.0 : 36.0, top: 16.0),
      padding: EdgeInsets.all(isMobile ? 8.0 : 17.0),
      width: isMobile ? 162.0 : 210.0,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.green.shade900.withOpacity(.15)
            : Colors.blue[50],
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.greenAccent.shade100
                : Colors.blue[100]!, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Data Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize - 1.0, color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade100 : null)),
          SizedBox(height: 8.0),
          Text('int — integer number', style: TextStyle(fontSize: fontSize - 2.0, color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade100 : null)),
          Text('float — decimal number', style: TextStyle(fontSize: fontSize - 2.0, color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade100 : null)),
          Text('char — single character', style: TextStyle(fontSize: fontSize - 2.0, color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade100 : null)),
        ],
      ),
    );
  }

  Widget _animatedLabel(String text, Color bg, Color fg, double fontSize) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 17.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6.0)],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: fg, fontSize: fontSize, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _errorBox(String text, double fontSize, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(11.0),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: _errBg(context),
        border: Border.all(color: _errText(context), width: 1.3),
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: _errText(context), size: fontSize + 4.0),
          SizedBox(width: 8.0),
          Expanded(
              child: Text(text, style: TextStyle(color: _errText(context), fontSize: fontSize))),
        ],
      ),
    );
  }

  Widget _summaryBox(bool isMobile, double fontSize, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 8.0 : 32.0, vertical: 6.0),
      padding: EdgeInsets.all(isMobile ? 13.0 : 19.0),
      decoration: BoxDecoration(
        color: _summaryBg(context),
        border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade400 : Colors.teal[200]!, width: 1.5),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [BoxShadow(color: _summaryShadow(context), blurRadius: 7.0)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Summary', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize + 2.0,
              color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade100 : Colors.teal[900])),
          SizedBox(height: 7.0),
          _summaryRow('Declaration', "Lets the compiler allocate memory (e.g., int age;)", fontSize, context),
          _summaryRow("Assignment", "Sets a value to a variable (age = 20;)", fontSize, context),
          _summaryRow("Usage", "Use variables in expressions/output", fontSize, context),
          _summaryRow("Scope", "Variables exist within their block", fontSize, context),
          _summaryRow("Data Type", "Each variable has a specific type", fontSize, context),
          _summaryRow("Naming", "Must start with a letter/underscore, not digit", fontSize, context),
          _summaryRow("Initialization", "Always initialize before use!", fontSize, context),
          _summaryRow("Type Safety", "Don’t mix variable types", fontSize, context),
          _summaryRow("Comments", "Use // to annotate, improve code readability", fontSize, context),
        ],
      ),
    );
  }

  Widget _summaryRow(String head, String desc, double fontSize, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.4, horizontal: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$head:',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade100 : Colors.teal,
                  fontSize: fontSize - 2.0)),
          SizedBox(width: 4.0),
          Expanded(
              child: Text(desc, style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade100 : Colors.black87, fontSize: fontSize - 2.0))),
        ],
      ),
    );
  }
}
