import 'package:flutter/material.dart';

class Problem5DayNamePage extends StatefulWidget {
  @override
  State<Problem5DayNamePage> createState() => _Problem5DayNamePageState();
}

class _Problem5DayNamePageState extends State<Problem5DayNamePage> {
  int userInput = 3;
  int step = 0;
  int activeCase = -1;
  String? terminalMsg, annotation;
  bool animatingCases = false;
  bool defaultCase = false;

  final List<Map<String, dynamic>> _cases = [
    {'case': 1, 'day': 'Monday', 'color': Colors.red[100]},
    {'case': 2, 'day': 'Tuesday', 'color': Colors.orange[100]},
    {'case': 3, 'day': 'Wednesday', 'color': Colors.yellow[100]},
    {'case': 4, 'day': 'Thursday', 'color': Colors.green[100]},
    {'case': 5, 'day': 'Friday', 'color': Colors.blue[100]},
    {'case': 6, 'day': 'Saturday', 'color': Colors.indigo[100]},
    {'case': 7, 'day': 'Sunday', 'color': Colors.purple[100]},
  ];

  TextStyle get _monostyle => TextStyle(fontFamily: "monospace", fontSize: 16);

  int animationCaseIdx = 0;

  final int finalStep = 6;

  @override
  void initState() {
    super.initState();
    _prepareStep();
  }

  void _onNext() {
    setState(() {
      annotation = null;
      terminalMsg = null;
    });
    switch (step) {
      case 0:
        annotation = "Get day name by its number (1–7)!";
        step = 1;
        break;
      case 1:
        annotation = "User enters day = $userInput";
        step = 2;
        break;
      case 2:
        annotation = "switch(day) { ... }";
        step = 3;
        break;
      case 3:
        animatingCases = true;
        if (animationCaseIdx < _cases.length) {
          setState(() {
            activeCase = animationCaseIdx;
          });
          if (_cases[animationCaseIdx]['case'] == userInput) {
            step = 4;
            animatingCases = false;
            return;
          }
          animationCaseIdx++;
          return;
        } else {
          animatingCases = false;
          defaultCase = true;
          step = 5;
          return;
        }
      case 4:
        String day = _cases.firstWhere((c) => c['case'] == userInput)['day'];
        terminalMsg = day;
        annotation = 'Terminal Output: $day';
        step = 6;
        break;
      case 5:
        defaultCase = true;
        terminalMsg = "Invalid day number";
        annotation = "Default runs if no case matches.";
        step = 6;
        break;
      case 6:
        annotation = null;
        break;
    }
    _prepareStep();
  }

  void _onPrevious() {
    setState(() {
      if (step == 3 && animationCaseIdx > 0) {
        animationCaseIdx--;
        activeCase = animationCaseIdx == 0 ? -1 : animationCaseIdx;
        return;
      }
      if (step > 0) {
        step--;
        if (step == 0) {
          activeCase = -1;
          animationCaseIdx = 0;
          defaultCase = false;
          animatingCases = false;
          terminalMsg = null;
        }
        if (step == 1) {
          activeCase = -1;
          animationCaseIdx = 0;
          defaultCase = false;
          animatingCases = false;
          terminalMsg = null;
        }
        if (step < 3) annotation = null;
      }
    });
  }

  void _onFinish() => Navigator.of(context).maybePop();

  void _prepareStep() {
    setState(() {
      if (step == 0 || step == 1) {
        activeCase = -1;
        animationCaseIdx = 0;
        defaultCase = false;
        animatingCases = false;
        terminalMsg = null;
      }
      if (step < 3) {
        annotation = null;
      }
    });
  }

  void _onSliderChange(double v) {
    setState(() {
      userInput = v.round();
      terminalMsg = null;
      defaultCase = false;
      activeCase = -1;
      animatingCases = false;
      annotation = null;
      step = 1;
      animationCaseIdx = 0;
    });
    _prepareStep();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 450.0;
    final isFinish = step >= finalStep;
    final mainColor = isDark ? Colors.tealAccent : Colors.black87;
    bool showNext = step < finalStep;
    return Scaffold(
      appBar: AppBar(
        title: Text('Day Name by Number (Switch)', style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
        backgroundColor: isDark ? Colors.black : Colors.teal[50],
        centerTitle: true,
        iconTheme: IconThemeData(color: isDark ? Colors.tealAccent : Colors.teal[900]),
      ),
      backgroundColor: isDark ? Color(0xFF11161D) : Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 10.0 : 32.0,
                  vertical: isMobile ? 10.0 : 22.0),
              children: [
                _inputRow(isDark),
                SizedBox(height: 13.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _switchCode(isDark),
                ),
                SizedBox(height: 10.0),
                _memoryRow(isDark),
                SizedBox(height: 8.0),
                _terminalBox(isDark),
                if (annotation != null)
                  _annotationBox(annotation!, isDark),
                if (step >= 2) _flowchartOverlay(isDark),
                SizedBox(height: 8.0),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 15.0),
            child: Row(
              children: [
                if (step > 0 && !isFinish)
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.arrow_back, color: isDark ? Colors.tealAccent : Colors.teal),
                      label: Text('Previous Step', style: TextStyle(color: mainColor)),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(isMobile ? 90.0 : 110.0, 44.0),
                        backgroundColor: isDark ? Colors.teal[800] : Colors.teal[100],
                        foregroundColor: mainColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                      ),
                      onPressed: _onPrevious,
                    ),
                  ),
                if (showNext)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.arrow_forward, color: isDark ? Colors.tealAccent : Colors.teal),
                        label: Text('Next Step', style: TextStyle(color: mainColor)),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(isMobile ? 90.0 : 110.0, 44.0),
                          backgroundColor: isDark ? Colors.teal[900] : Colors.teal[300],
                          foregroundColor: mainColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                        ),
                        onPressed: _onNext,
                      ),
                    ),
                  ),
                if (isFinish)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.check_circle_outlined, color: isDark ? Colors.greenAccent : Colors.teal),
                        label: Text('Finish', style: TextStyle(color: isDark ? Colors.black : Colors.black)),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(isMobile ? 90.0 : 110.0, 44.0),
                          backgroundColor: isDark ? Colors.greenAccent : Colors.tealAccent[700],
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                        ),
                        onPressed: _onFinish,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputRow(bool isDark) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text("Enter day number: ", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
      SizedBox(width: 8.0),
      Expanded(
        child: Slider(
          value: userInput.toDouble(),
          min: 0,
          max: 8,
          divisions: 8,
          label: userInput.toString(),
          activeColor: isDark ? Colors.tealAccent : Colors.teal,
          inactiveColor: isDark ? Colors.teal[900]!.withOpacity(0.6) : Colors.teal[100],
          onChanged: _onSliderChange,
        ),
      ),
      Text('$userInput',
          style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.tealAccent : Colors.teal)),
    ],
  );

  Widget _memoryRow(bool isDark) => Row(
    children: [
      Text('Memory:',
          style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
      SizedBox(width: 10.0),
      _memoryCell('day', userInput, isDark),
    ],
  );

  Widget _memoryCell(String label, int value, bool isDark) => Container(
    margin: EdgeInsets.only(right: 8.0),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[900] : Colors.white,
      border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.10) : Colors.blue[100]!, width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      children: [
        Text(label,
            style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: isDark ? Colors.tealAccent : Colors.teal[900])),
        Text(value.toString(),
            style: TextStyle(fontSize: 17.0, color: isDark ? Colors.greenAccent : Colors.teal, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  Widget _switchCode(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[50],
        border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.17) : Colors.indigo[100]!, width: 1.2),
        borderRadius: BorderRadius.circular(13.0),
      ),
      padding: EdgeInsets.all(13.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('switch(day) {', style: _monostyle.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.tealAccent : Colors.teal[900])),
          ..._cases.asMap().entries.map((entry) {
            int idx = entry.key;
            Map<String, dynamic> c = entry.value;
            bool highlight = (animatingCases && activeCase == idx) ||
                (!animatingCases && userInput == c['case'] && step >= 4);
            Color? hlBg = highlight
                ? (isDark
                ? Colors.tealAccent.withOpacity(.14)
                : c['color'])
                : null;
            return AnimatedContainer(
              duration: Duration(milliseconds: 340),
              child: Container(
                margin: EdgeInsets.only(left: 15.0, top: 2.0, bottom: 2.0),
                padding: EdgeInsets.symmetric(
                    vertical: highlight ? 6.0 : 2.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  color: hlBg,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: RichText(
                  text: TextSpan(
                    style: _monostyle.copyWith(
                        color: isDark
                            ? Colors.tealAccent
                            : Colors.black87),
                    children: [
                      TextSpan(
                          text: "case ${c['case']}:  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.tealAccent : Colors.teal[800])),
                      TextSpan(
                          text: 'printf("${c['day']}\\n"); break;',
                          style: TextStyle(
                              color: isDark ? Colors.yellowAccent : Colors.black87,
                              fontWeight: highlight
                                  ? FontWeight.bold
                                  : FontWeight.normal)),
                    ],
                  ),
                ),
              ),
            );
          }),
          _defaultCaseLine(isDark),
          Text('}', style: _monostyle.copyWith(color: isDark ? Colors.tealAccent : Colors.teal[900])),
        ],
      ),
    );
  }

  Widget _defaultCaseLine(bool isDark) {
    bool highlight = defaultCase;
    return AnimatedContainer(
      duration: Duration(milliseconds: 340),
      child: Container(
        margin: EdgeInsets.only(left: 15.0, top: 2.0, bottom: 2.0),
        padding:
        EdgeInsets.symmetric(vertical: highlight ? 6.0 : 2.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: highlight
              ? (isDark ? Colors.amberAccent.withOpacity(.18) : Colors.orange[100])
              : null,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RichText(
          text: TextSpan(
            style: _monostyle.copyWith(color: isDark ? Colors.tealAccent : Colors.black87),
            children: [
              TextSpan(
                  text: "default:  ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.amberAccent : Colors.orange[700])),
              TextSpan(
                  text: 'printf("Invalid day number\\n"); break;',
                  style: TextStyle(
                      color: isDark ? Colors.yellowAccent : Colors.black87,
                      fontWeight:
                      highlight ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _terminalBox(bool isDark) => Container(
    constraints: BoxConstraints(minHeight: 40.0, maxHeight: 65.0),
    width: double.infinity,
    padding: EdgeInsets.all(11.0),
    margin: EdgeInsets.only(top: 10.0, bottom: 6.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.black87 : Colors.black,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        terminalMsg != null ? terminalMsg! : "",
        style: TextStyle(color: isDark ? Colors.greenAccent : Colors.greenAccent, fontSize: 17.0, fontWeight: FontWeight.w600),
      ),
    ),
  );

  Widget _annotationBox(String text, bool isDark) => Container(
    padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
    margin: EdgeInsets.symmetric(vertical: 7.0),
    decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.amber[100],
        borderRadius: BorderRadius.circular(11)),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 15.0,
          color: isDark ? Colors.yellowAccent : Colors.amber[900],
          fontWeight: FontWeight.w700),
    ),
  );

  Widget _flowchartOverlay(bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 15.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.blue[900]!.withOpacity(.18) : Colors.blue[50],
      borderRadius: BorderRadius.circular(13.0),
      border: Border.all(color: isDark ? Colors.blueAccent.withOpacity(.14) : Colors.blue[100]!, width: 1.1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Flowchart:', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.yellowAccent : Colors.blue[900])),
        SizedBox(height: 7.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Icon(Icons.circle, color: isDark ? Colors.tealAccent : Colors.teal, size: 18.0),
              SizedBox(width: 5.0),
              _arrow(isDark),
              _diamond("switch(day)", isDark),
              _arrow(isDark),
              ..._cases.map((c) {
                bool highlight = (userInput == c['case'] && step >= 4);
                return Container(
                    margin: EdgeInsets.only(right: 5.0),
                    child: Row(
                      children: [
                        _rectFlow(c['case'], c['day'], highlight: highlight, isDark: isDark),
                        _arrow(isDark),
                      ],
                    ));
              }).toList(),
              _rectFlow('default', "Default", highlight: defaultCase, isDark: isDark),
              SizedBox(width: 8.0),
              Icon(Icons.terminal, color: isDark ? Colors.greenAccent : Colors.green, size: 24.0),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        Text(
            "Arrows show checks from top (case 1) to bottom; first match or default block runs.",
            style: TextStyle(fontSize: 12.0, color: isDark ? Colors.tealAccent : Colors.blue[900])),
      ],
    ),
  );

  Widget _arrow(bool isDark) => Icon(Icons.arrow_forward, color: isDark ? Colors.tealAccent : Colors.teal, size: 18.0);

  Widget _diamond(String cond, bool isDark) => Container(
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    child: CustomPaint(
      size: Size(44.0, 26.0),
      painter: _DiamondPainterC(isDark: isDark),
      child: Container(
          height: 26.0,
          width: 44.0,
          alignment: Alignment.center,
          child: Text(cond,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.5, color: isDark ? Colors.yellowAccent : Colors.blueGrey, fontWeight: FontWeight.w600))),
    ),
  );

  Widget _rectFlow(dynamic val, String text, {bool highlight = false, required bool isDark}) => Container(
    margin: EdgeInsets.symmetric(horizontal: 3.0),
    padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 7.0),
    decoration: BoxDecoration(
      color: highlight
          ? (isDark ? Colors.tealAccent.withOpacity(.18) : Colors.teal[100])
          : (isDark ? Colors.grey[900] : Colors.white),
      borderRadius: BorderRadius.circular(7.0),
      border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.2) : Colors.teal[200]!, width: 1.0),
    ),
    child: Row(
      children: [
        Text(val.toString(),
            style: TextStyle(
              color: isDark ? Colors.tealAccent : Colors.teal,
              fontWeight: FontWeight.w600,
              fontSize: 11.0,
            )),
        SizedBox(width: 2.0),
        Text(text, style: TextStyle(fontSize: 11.0, color: isDark ? Colors.yellowAccent : Colors.teal[900])),
      ],
    ),
  );
}

class _DiamondPainterC extends CustomPainter {
  final bool isDark;
  _DiamondPainterC({required this.isDark});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark ? Colors.yellowAccent.withOpacity(.32) : Colors.blue[100]!
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke;
    Path path = Path();
    path.moveTo(size.width / 2, 0.0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0.0, size.height / 2);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _DiamondPainterC oldDelegate) => false;
}
