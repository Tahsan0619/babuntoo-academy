import 'package:flutter/material.dart';

class Problem3EvenNumbersPage extends StatefulWidget {
  @override
  State<Problem3EvenNumbersPage> createState() =>
      _Problem3EvenNumbersPageState();
}

class _Problem3EvenNumbersPageState extends State<Problem3EvenNumbersPage> {
  int step = 0;
  List<int> outputNumbers = [];
  int currentI = 2;
  bool loopDone = false;
  String? infoMsg;
  int loopOut = 2;

  final int maxStep = 5;

  void _onNext() {
    setState(() {
      infoMsg = null;
    });
    switch (step) {
      case 0:
        infoMsg = 'Print all even numbers from 1 to 100.';
        step = 1;
        break;
      case 1:
        infoMsg = 'for (i = 2; i <= 100; i += 2);';
        step = 2;
        break;
      case 2:
        infoMsg = 'printf("%d ", i);';
        step = 3;
        break;
      case 3:
        if (loopOut <= 100) {
          outputNumbers.add(loopOut);
          currentI = loopOut;
          loopOut += 2;
          return;
        }
        step = 4;
        break;
      case 4:
        infoMsg = "Notice: i += 2 makes the loop jump by 2 each step!";
        loopDone = true;
        step = 5;
        break;
      case 5:
      // Optionally restart (not required)
        break;
    }
    if (step == 0) {
      outputNumbers.clear();
      currentI = 2;
      loopDone = false;
      loopOut = 2;
      infoMsg = 'Print all even numbers from 1 to 100.';
    }
  }

  void _onPrevious() {
    setState(() {
      if (step == 3 && outputNumbers.isNotEmpty) {
        outputNumbers.removeLast();
        loopOut = outputNumbers.isEmpty ? 2 : outputNumbers.last + 2;
        currentI = (outputNumbers.isEmpty ? 2 : outputNumbers.last);
        return;
      }
      if (step == 5) {
        loopDone = false;
      }
      if (step > 0) {
        step--;
        if (step == 0) {
          outputNumbers.clear();
          currentI = 2;
          loopDone = false;
          loopOut = 2;
        }
      }
    });
  }

  void _onFinish() => Navigator.of(context).maybePop();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 420.0;
    final isRecap = step >= 5;
    final mainColor = isDark ? Colors.tealAccent : Colors.black87;
    bool showNext = step < maxStep;
    return Scaffold(
      appBar: AppBar(
        title: Text('Problem 3: Even Numbers 1–100',
            style:
            TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900])),
        backgroundColor: isDark ? Colors.black : Colors.teal[50],
        centerTitle: true,
        iconTheme: IconThemeData(color: isDark ? Colors.tealAccent : Colors.teal[900]),
      ),
      backgroundColor: isDark ? Color(0xFF11161D) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ListView(
                  padding: EdgeInsets.all(isMobile ? 12.0 : 20.0),
                  children: [
                    if (step == 0)
                      Container(
                        padding: EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.teal[900]!.withOpacity(.13) : Colors.teal[50],
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        child: Text('Print all even numbers from 1 to 100.',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17.0,
                                color: isDark ? Colors.tealAccent : Colors.teal[900])),
                      ),
                    SizedBox(height: 18.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _codeBox(isDark),
                    ),
                    SizedBox(height: 18.0),
                    Row(children: [
                      Text('Memory:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.yellowAccent
                                  : Colors.teal[900])),
                      _memCell('i', currentI, step >= 2, isDark),
                    ]),
                    SizedBox(height: 18.0),
                    _outputBox(isDark),
                    if (infoMsg != null)
                      _infoPopup(infoMsg!, isDark),
                    SizedBox(height: 26.0),
                    if (loopDone) _recap(isDark)
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              child: Wrap(
                spacing: 10,
                children: [
                  if (step > 0 && !isRecap)
                    ElevatedButton.icon(
                      icon: Icon(Icons.arrow_back, color: isDark ? Colors.tealAccent : Colors.teal),
                      label: Text('Previous Step', style: TextStyle(color: mainColor)),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(isMobile ? 96 : 110, 44),
                        backgroundColor: isDark ? Colors.teal[800] : Colors.teal[100],
                        foregroundColor: mainColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                      ),
                      onPressed: _onPrevious,
                    ),
                  if (showNext)
                    ElevatedButton.icon(
                      icon: Icon(Icons.arrow_forward, color: isDark ? Colors.tealAccent : Colors.teal),
                      label: Text('Next Step', style: TextStyle(color: mainColor)),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(isMobile ? 96 : 110, 44),
                        backgroundColor: isDark ? Colors.teal[900] : Colors.teal[300],
                        foregroundColor: mainColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        textStyle: TextStyle(fontSize: isMobile ? 15.0 : 17.0),
                      ),
                      onPressed: _onFinish,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoPopup(String msg, bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 7.0),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.teal[800]!.withOpacity(.13) : Colors.blue[50],
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(msg, style: TextStyle(fontSize: 16.0, color: isDark ? Colors.tealAccent : Colors.black87)),
  );

  Widget _codeBox(bool isDark) {
    List<String> lines = [
      'int i;',
      'for (i = 2; i <= 100; i += 2) {',
      '  printf("%d ", i);',
      '}'
    ];
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[50],
        border: Border.all(color: isDark ? Colors.tealAccent.withOpacity(.13) : Colors.teal[100]!, width: 1.2),
        borderRadius: BorderRadius.circular(11.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines.map((l) {
          bool isLoopHeader = step >= 1 && l.startsWith('for');
          bool isBody = step >= 2 && l.trim().startsWith('printf');
          bool isClosing = step >= 1 && l.trim() == '}';
          bool isActive =
              (isLoopHeader && step < 3) ||
                  (isBody && step >= 2 && step <= 3) ||
                  (isClosing && step >= 1 && step <= 3);
          return Container(
            margin: EdgeInsets.symmetric(vertical: 1.0),
            child: Text(
              l,
              style: TextStyle(
                fontFamily: "monospace",
                color: isActive
                    ? (isDark ? Colors.tealAccent : Colors.teal[800])
                    : (isDark ? Colors.tealAccent[100] : Colors.black87),
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 16.0,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _memCell(String label, int val, bool highlight, bool isDark) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 11.0),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
      decoration: BoxDecoration(
        color: isDark
            ? (highlight ? Colors.yellowAccent.withOpacity(.08) : Colors.grey[900])
            : (highlight ? Colors.amber[50] : Colors.white),
        border: Border.all(
            color: highlight
                ? (isDark
                ? Colors.yellowAccent.withOpacity(.11)
                : Colors.amber)
                : (isDark
                ? Colors.tealAccent.withOpacity(.11)
                : Colors.grey[300]!),
            width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(children: [
        Text(label,
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.tealAccent : Colors.teal[900])),
        Text(val.toString(),
            style: TextStyle(
                fontSize: 17.0,
                color: isDark ? Colors.greenAccent : Colors.teal,
                fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget _outputBox(bool isDark) => Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(15.0),
    decoration: BoxDecoration(
      color: isDark ? Colors.black.withOpacity(.92) : Colors.black,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        children: outputNumbers
            .map((n) => Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 2.0, vertical: 2.0),
          child: Text(
            '$n',
            style: TextStyle(
                color: isDark ? Colors.greenAccent : Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
        ))
            .toList(),
      ),
    ),
  );

  Widget _recap(bool isDark) => Container(
      margin: EdgeInsets.only(top: 15.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.teal[900]!.withOpacity(.11) : Colors.teal[50],
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
            color: isDark ? Colors.tealAccent.withOpacity(.11) : Colors.teal[100]!,
            width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: isDark ? Colors.yellowAccent : Colors.teal[900])),
          SizedBox(height: 7.0),
          Text(
              '• The for loop header `for (i = 2; i <= 100; i += 2)` uses a step increment of 2, so i jumps to every even number.',
              style: TextStyle(
                  fontSize: 15.0,
                  color: isDark ? Colors.tealAccent[100] : Colors.black87)),
          SizedBox(height: 6.0),
          Text(
              '• Inside the loop, printf("%d ", i); prints each even number on the same line.',
              style: TextStyle(
                  fontSize: 15.0,
                  color: isDark ? Colors.tealAccent[100] : Colors.black87)),
          SizedBox(height: 6.0),
          Text(
              '• The loop automatically stops when i becomes greater than 100.',
              style: TextStyle(
                  fontSize: 15.0,
                  color: isDark ? Colors.tealAccent[100] : Colors.black87)),
        ],
      ));
}
