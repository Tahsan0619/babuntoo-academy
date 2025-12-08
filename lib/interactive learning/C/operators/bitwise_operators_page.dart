import 'package:flutter/material.dart';

enum BitwiseStep {
  intro,
  showTable,
  showBinary,
  andOp,
  orOp,
  xorOp,
  notOp,
  leftShift,
  rightShift,
  combineDemo,
  applications,
  edgeError,
  recapQuiz,
}

class BitwiseOperatorsPage extends StatefulWidget {
  @override
  State<BitwiseOperatorsPage> createState() => _BitwiseOperatorsPageState();
}

class _BitwiseOperatorsPageState extends State<BitwiseOperatorsPage> {
  BitwiseStep step = BitwiseStep.intro;
  int a = 12, b = 25;
  int? andResult, orResult, xorResult, notResult, lsResult, rsResult;
  String? infoMsg;
  String? annotation;
  String? terminal;
  bool showTable = false;
  bool showEdgeError = false;
  bool showQuiz = false;
  bool showApps = false;
  bool showQuizFeedback = false;
  String? quizFeedback;
  String? quizAnswer;
  List<String> appNotes = [
    "Turn on/off features with AND/OR (bit masking)",
    "Swap two numbers using XOR (a ^= b; b ^= a; a ^= b;)",
    "Encode/decode data efficiently"
  ];

  final List<BitwiseStep> _orderedSteps = BitwiseStep.values;

  @override
  void initState() {
    super.initState();
    _prepareStep();
  }

  void _onNext() {
    setState(() {
      infoMsg = null;
      annotation = null;
      terminal = null;
    });
    switch (step) {
      case BitwiseStep.intro:
        step = BitwiseStep.showTable;
        break;
      case BitwiseStep.showTable:
        step = BitwiseStep.showBinary;
        break;
      case BitwiseStep.showBinary:
        step = BitwiseStep.andOp;
        break;
      case BitwiseStep.andOp:
        step = BitwiseStep.orOp;
        break;
      case BitwiseStep.orOp:
        step = BitwiseStep.xorOp;
        break;
      case BitwiseStep.xorOp:
        step = BitwiseStep.notOp;
        break;
      case BitwiseStep.notOp:
        step = BitwiseStep.leftShift;
        break;
      case BitwiseStep.leftShift:
        step = BitwiseStep.rightShift;
        break;
      case BitwiseStep.rightShift:
        step = BitwiseStep.combineDemo;
        break;
      case BitwiseStep.combineDemo:
        step = BitwiseStep.applications;
        break;
      case BitwiseStep.applications:
        step = BitwiseStep.edgeError;
        break;
      case BitwiseStep.edgeError:
        step = BitwiseStep.recapQuiz;
        break;
      case BitwiseStep.recapQuiz:
        return;
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
      showTable = false;
      showApps = false;
      showQuiz = false;
      showEdgeError = false;
      annotation = null;
      terminal = null;
      switch (step) {
        case BitwiseStep.intro:
          infoMsg = 'Bitwise operators let you manipulate each bit directly. They\'re fast and powerful in C.';
          break;
        case BitwiseStep.showTable:
          showTable = true;
          break;
        case BitwiseStep.showBinary:
          annotation = "a = 12 ⟶ 00001100,   b = 25 ⟶ 00011001";
          break;
        case BitwiseStep.andOp:
          andResult = a & b;
          annotation = "AND (&): Only 1 when *both* bits are 1.";
          terminal = _bitOpResult(a, b, andResult!, "&");
          break;
        case BitwiseStep.orOp:
          orResult = a | b;
          annotation = "OR (|): 1 if *either* bit is 1.";
          terminal = _bitOpResult(a, b, orResult!, "|");
          break;
        case BitwiseStep.xorOp:
          xorResult = a ^ b;
          annotation = "XOR (^): 1 if bits differ.";
          terminal = _bitOpResult(a, b, xorResult!, "^");
          break;
        case BitwiseStep.notOp:
          notResult = ~a & 0xFF;
          annotation = "NOT (~): Flips all bits.";
          terminal = "${_bin(a)}  ➔  ${_bin(notResult!)}";
          break;
        case BitwiseStep.leftShift:
          lsResult = a << 2;
          annotation = "Left shift (<<): multiplies by 2².";
          terminal = "${_bin(a)} << 2 = ${_bin(lsResult!)}";
          break;
        case BitwiseStep.rightShift:
          rsResult = b >> 2;
          annotation = "Right shift (>>): divides by 2².";
          terminal = "${_bin(b)} >> 2 = ${_bin(rsResult!)}";
          break;
        case BitwiseStep.combineDemo:
          annotation = "Here's what you get from AND, OR, XOR:";
          terminal = "a & b = $andResult,  a | b = $orResult,  a ^ b = $xorResult";
          break;
        case BitwiseStep.applications:
          showApps = true;
          break;
        case BitwiseStep.edgeError:
          showEdgeError = true;
          annotation = "⚠️ Shifting bits too far will erase all data!\n(Example: 00001100 << 6 = 00000000)";
          break;
        case BitwiseStep.recapQuiz:
          showQuiz = true;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 470.0;
    final mainColor = isDark ? Colors.tealAccent : Colors.black87;
    final isLastStep = step == BitwiseStep.recapQuiz;
    bool showNext = (step != BitwiseStep.recapQuiz);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bitwise Operators in C', style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
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
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: isMobile ? 8.0 : 22.0),
                children: [
                  if (infoMsg != null)
                    _popup(infoMsg!, isDark: isDark, color: isDark ? Color(0xFF1B2B2E) : Colors.blue[50]!),
                  _chipIntro(isDark),
                  _codeMemoryBitDisplay(isDark),
                  if (showTable)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: 320),
                        child: _bitwiseTable(isDark),
                      ),
                    ),
                  if (annotation != null)
                    _popup(annotation!, isDark: isDark, color: isDark ? Color(0xFF2F2222) : Colors.amber[200]!),
                  if (terminal != null) _terminalOutput(terminal!, isDark),
                  if (showApps) _appsDemo(isDark),
                  if (showEdgeError)
                    _popup("Warning: Shifting bits beyond variable width erases data!",
                        isDark: isDark,
                        color: isDark ? Colors.red[900]!.withOpacity(.19) : Colors.red[100]!),
                  if (showQuiz) _recapQuizBox(isDark),
                  SizedBox(height: 8.0)
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

  Widget _popup(String text, {required bool isDark, required Color color}) => Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 19.0),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(11)),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 15.0,
        color: isDark ? Colors.tealAccent : Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  Widget _chipIntro(bool isDark) {
    if (step != BitwiseStep.intro) return SizedBox.shrink();
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.memory, color: isDark ? Colors.tealAccent : Colors.teal, size: 31),
          SizedBox(width: 14),
          Text(" 12 25",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: isDark ? Colors.yellowAccent : Colors.teal[900],
              )),
        ],
      ),
    );
  }

  Widget _codeMemoryBitDisplay(bool isDark) {
    if (step.index < BitwiseStep.showBinary.index) return SizedBox.shrink();
    int aVal = a, bVal = b;
    int? opResult =
    [andResult, orResult, xorResult, notResult, lsResult, rsResult].firstWhere((v) => v != null, orElse: () => null);
    String? opName = step == BitwiseStep.andOp
        ? "&"
        : step == BitwiseStep.orOp
        ? "|"
        : step == BitwiseStep.xorOp
        ? "^"
        : step == BitwiseStep.notOp
        ? "~"
        : step == BitwiseStep.leftShift
        ? "<<"
        : step == BitwiseStep.rightShift
        ? ">>"
        : null;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _bitRow(_bin(aVal), label: "a (dec $aVal)", highlight: (step.index > 2), isDark: isDark),
          SizedBox(width: 19),
          _bitRow(_bin(bVal), label: "b (dec $bVal)", highlight: (step.index > 2), isDark: isDark),
          if (opResult != null && opName != null)
            ...[
              SizedBox(width: 14),
              Icon(Icons.arrow_right_alt, color: isDark ? Colors.tealAccent : Colors.teal, size: 24),
              _bitRow(_bin(opResult), label: "result $opName", result: true, op: opName, a: aVal, b: bVal, isDark: isDark)
            ]
        ],
      ),
    );
  }

  Widget _bitRow(String binStr, {String? label, bool highlight = false, bool result = false, String? op, int? a, int? b, required bool isDark}) {
    List<Widget> bits = [];
    for (int i = 0; i < 8; i++) {
      Color color = isDark ? Color(0xFF232B2F) : Colors.grey[200]!;
      if (result && op != null && a != null && b != null) {
        int ai = ((a >> (7 - i)) & 1);
        int bi = ((b >> (7 - i)) & 1);
        int ri = int.parse(binStr[i]);
        if (op == "&")
          color = (ai == 1 && bi == 1)
              ? (isDark ? Colors.greenAccent : Colors.green[700]!)
              : (isDark ? Colors.redAccent.withOpacity(.13)! : Colors.red[200]!);
        else if (op == "|")
          color = (ai == 1 || bi == 1)
              ? (isDark ? Colors.greenAccent : Colors.green[700]!)
              : (isDark ? Colors.redAccent.withOpacity(.13)! : Colors.red[200]!);
        else if (op == "^")
          color = (ai != bi)
              ? (isDark ? Colors.yellowAccent : Colors.yellow[700]!)
              : (isDark ? Colors.redAccent.withOpacity(.13)! : Colors.red[200]!);
        else if (op == "~")
          color = (ri == 1)
              ? (isDark ? Colors.greenAccent : Colors.green[700]!)
              : (isDark ? Colors.redAccent.withOpacity(.13)! : Colors.red[200]!);
        else if (op == "<<" || op == ">>")
          color = (ri == 1)
              ? (isDark ? Colors.tealAccent : Colors.teal[800]!)
              : (isDark ? Colors.redAccent.withOpacity(.13)! : Colors.red[200]!);
      } else if (highlight) {
        color = isDark ? Colors.tealAccent.withOpacity(0.25) : Colors.teal[100]!;
      }
      bits.add(Container(
        margin: EdgeInsets.symmetric(horizontal: 1.0, vertical: 2.0),
        child: CircleAvatar(
          radius: 12,
          backgroundColor: color,
          child: Text(
            "${binStr[i]}",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: color.computeLuminance() < 0.35 ? Colors.white : Colors.black),
          ),
        ),
      ));
    }
    return Column(
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: bits),
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 2),
            child: Text(label,
                style: TextStyle(fontSize: 13,
                    color: isDark ? Colors.tealAccent : Colors.teal[900],
                    fontWeight: FontWeight.w600)),
          )
      ],
    );
  }

  Widget _bitwiseTable(bool isDark) {
    List<Map<String, String>> ops = [
      {"Operator": "AND", "Symbol": "&", "Description": "Bitwise AND"},
      {"Operator": "OR", "Symbol": "|", "Description": "Bitwise OR"},
      {"Operator": "XOR", "Symbol": "^", "Description": "Bitwise XOR"},
      {"Operator": "NOT", "Symbol": "~", "Description": "Bitwise NOT"},
      {"Operator": "Left Shift", "Symbol": "<<", "Description": "Shift bits left"},
      {"Operator": "Right Shift", "Symbol": ">>", "Description": "Shift bits right"}
    ];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: isDark ? Colors.blueGrey[900]!.withOpacity(.18) : Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.17) : Colors.teal[100]!, width: 1.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Bitwise Operators Table",
              style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900], fontSize: 15)),
          Divider(),
          DataTable(
            columns: [
              DataColumn(label: Text("Operator", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
              DataColumn(label: Text("Symbol", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
              DataColumn(label: Text("Description", style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black))),
            ],
            rows: ops.map((row) => DataRow(
              cells: [
                DataCell(Text(row["Operator"]!, style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black, fontWeight: FontWeight.bold))),
                DataCell(Text(row["Symbol"]!, style: TextStyle(color: isDark ? Colors.tealAccent : Colors.black, fontWeight: FontWeight.bold))),
                DataCell(Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: Text(row["Description"]!, style: TextStyle(color: isDark ? Colors.white : Colors.black87), maxLines: 2, overflow: TextOverflow.ellipsis),
                )),
              ],
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _terminalOutput(String text, bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: isDark ? Colors.black.withOpacity(.97) : Colors.black,
      borderRadius: BorderRadius.circular(8),
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        text,
        style: TextStyle(color: isDark ? Colors.greenAccent : Colors.greenAccent[400], fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
  );

  Widget _appsDemo(bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 11, horizontal: 1),
    padding: EdgeInsets.all(11),
    decoration: BoxDecoration(
      color: isDark ? Colors.orange[900]!.withOpacity(.19) : Colors.orange[50],
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: isDark ? Colors.orangeAccent.withOpacity(.23) : Colors.orange[100]!, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Practical Applications:",
            style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
        Divider(),
        ...appNotes.map((s) => Padding(
          padding: const EdgeInsets.only(top: 5, left: 6),
          child: Row(
            children: [
              Icon(Icons.check_circle_outline, color: isDark ? Colors.tealAccent : Colors.teal, size: 18),
              SizedBox(width: 7),
              Expanded(child: Text(s, style: TextStyle(color: isDark ? Colors.white : Colors.black))),
            ],
          ),
        )),
        SizedBox(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lightbulb, color: isDark ? Colors.yellowAccent : Colors.teal, size: 29),
            SizedBox(width: 10),
            Flexible(
                child: Text("Bit masking: turn ON/OFF bits!",
                    style: TextStyle(color: isDark ? Colors.yellowAccent : Colors.teal, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis)
            ),
          ],
        )
      ],
    ),
  );

  Widget _recapQuizBox(bool isDark) {
    List<Map<String, String>> quizList = [
      {"Q": "Flips all bits in a value", "A": "~"},
      {"Q": "Returns 1 if both bits are 1", "A": "&"},
      {"Q": "Returns 1 if bits differ", "A": "^"},
      {"Q": "Shifts bits left", "A": "<<"},
      {"Q": "Shifts bits right", "A": ">>"},
    ];
    List<String> options = ['~', '&', '^', '<<', '>>'];
    return Container(
      margin: EdgeInsets.only(top: 14, bottom: 12),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: isDark ? Colors.teal[900]!.withOpacity(.16) : Colors.teal[50],
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.19) : Colors.teal[100]!, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Quiz: Match the operator to the effect",
              style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
          SizedBox(height: 6),
          ...quizList.map((item) => Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    item['Q']!,
                    style: TextStyle(
                      fontSize: 15,
                      color: isDark ? Colors.tealAccent : Colors.teal[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 2,
                    children: options.map((val) =>
                        SizedBox(
                          width: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: (quizAnswer == "${item['Q']}:$val")
                                  ? (val == item['A']
                                  ? (isDark ? Colors.greenAccent : Colors.green[400])
                                  : (isDark ? Colors.redAccent : Colors.red[200]))
                                  : (isDark ? Colors.teal[800] : Colors.teal[100]),
                              minimumSize: Size(38, 36),
                            ),
                            onPressed: () {
                              setState(() {
                                quizAnswer = "${item['Q']}:$val";
                                showQuizFeedback = true;
                                quizFeedback = (val == item['A'])
                                    ? "Correct!"
                                    : "Try again for: '${item['Q']}'";
                              });
                              Future.delayed(const Duration(seconds: 1), () {
                                setState(() => showQuizFeedback = false);
                              });
                            },
                            child: FittedBox(
                              child: Text(
                                val,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: (quizAnswer == "${item['Q']}:$val" && val == item['A'])
                                      ? Colors.black
                                      : isDark ? Colors.tealAccent : Colors.teal[900],
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ).toList(),
                  ),
                ),
              ],
            ),
          )),
          if (showQuizFeedback && quizFeedback != null)
            Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Text(
                  quizFeedback!,
                  style: TextStyle(
                      color: quizFeedback == "Correct!" ? (isDark ? Colors.greenAccent : Colors.green) : (isDark ? Colors.redAccent : Colors.red),
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
          SizedBox(height: 10),
          _popup('Bitwise operators are fast and used in hardware, cryptography, and more.',
              isDark: isDark, color: isDark ? Color(0xFF153439) : Colors.blue[50]!),
        ],
      ),
    );
  }

  String _bin(int n) => n.toRadixString(2).padLeft(8, '0');
  String _bitOpResult(int a, int b, int result, String op) => "${_bin(a)}\n$op ${_bin(b)}\n= ${_bin(result)}   ($result)";
}
