import 'package:flutter/material.dart';

enum CStringStep {
  intro,
  declareInit,
  print,
  input,
  accessChar,
  changeChar,
  lengthLoop,
  copyManual,
  compareManual,
  concatManual,
  conditionalUse,
  fgetsInput,
  detectEnd,
  reverseString,
  searchChar,
  quiz,
}

class CStringPage extends StatefulWidget {
  const CStringPage({Key? key}) : super(key: key);

  @override
  State<CStringPage> createState() => _CStringPageState();
}

class _CStringPageState extends State<CStringPage> with SingleTickerProviderStateMixin {
  CStringStep _step = CStringStep.intro;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  String? _quizFeedback;
  bool _quizAnsweredCorrectly = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _setupAnimations();
    _animationController.forward();
  }

  void _setupAnimations({bool forward = true}) {
    final beginOffset = forward ? const Offset(1, 0) : const Offset(-1, 0);

    _slideAnimation = Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  Future<void> _gotoStep(CStringStep newStep, {bool forward = true}) async {
    await _animationController.reverse();
    setState(() {
      _step = newStep;
      _quizFeedback = null;
      _quizAnsweredCorrectly = false;
      _setupAnimations(forward: forward);
    });
    await _animationController.forward();
  }

  void _nextStep() {
    if (_step.index < CStringStep.values.length - 1) {
      _gotoStep(CStringStep.values[_step.index + 1], forward: true);
    }
  }

  void _previousStep() {
    if (_step.index > 0) {
      _gotoStep(CStringStep.values[_step.index - 1], forward: false);
    }
  }

  Color _textColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? const Color(0xFF7FFFD4) : Colors.black87;

  Color _annotationBgColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.green.withOpacity(0.15) : Colors.green.shade100;

  Color _annotationTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade100 : Colors.green.shade900;

  Color _flowChartTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.lightGreenAccent.shade100 : Colors.teal.shade900;

  Color _flowChartBoxColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.teal.shade800.withOpacity(0.3) : Colors.teal.shade50;

  Color _flowChartBorderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.withOpacity(0.7) : Colors.green.shade200;

  Color _buttonBgColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.teal[700]! : Colors.teal.shade300;

  Color _buttonFgColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent : Colors.teal.shade900;

  TextStyle _flowChartTextStyle(BuildContext context, bool active) => TextStyle(
    fontWeight: active ? FontWeight.bold : FontWeight.normal,
    fontSize: 12,
    color: active
        ? (Theme.of(context).brightness == Brightness.dark ? Colors.amberAccent.shade200 : Colors.teal.shade900)
        : _flowChartTextColor(context).withOpacity(0.7),
  );

  BoxDecoration _flowChartBoxDecoration(BuildContext context, bool active) => BoxDecoration(
    color: active
        ? (Theme.of(context).brightness == Brightness.dark ? Colors.amber.withOpacity(0.3) : Colors.teal.shade100)
        : _flowChartBoxColor(context),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: active
          ? (Theme.of(context).brightness == Brightness.dark ? Colors.amberAccent.shade200 : Colors.teal.shade400)
          : _flowChartBorderColor(context),
      width: active ? 2 : 1,
    ),
    boxShadow: active
        ? [
      BoxShadow(
        color: (Theme.of(context).brightness == Brightness.dark ? Colors.amberAccent.shade100 : Colors.teal.shade200)
            .withOpacity(0.4),
        blurRadius: 6,
        offset: const Offset(0, 2),
      ),
    ]
        : [],
  );

  String _spacedUpperCase(String input) {
    final buffer = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      if (i > 0 && char.toUpperCase() == char && char != char.toLowerCase()) {
        buffer.write(' ');
      }
      buffer.write(char);
    }
    return buffer.toString().toUpperCase();
  }

  static const Map<CStringStep, Map<String, dynamic>> _stepsData = {
    CStringStep.intro: {
      'title': 'INTRODUCTION: WHAT IS A C STRING?',
      'content':
      'A C string is an array of characters terminated by a null character \'\\0\'. It stores text as a sequence of characters ending with this special marker.',
      'code': null,
    },
    CStringStep.declareInit: {
      'title': 'DECLARING AND INITIALIZING A STRING',
      'content':
      'Declare a C string as a character array initialized with a string literal. Example:\nchar name[] = "Alice"; creates a character array including the null terminator.',
      'code': 'char name[] = "Alice";',
    },
    CStringStep.print: {
      'title': 'PRINTING A STRING USING printf',
      'content': 'Use printf with %s format specifier to display C strings.',
      'code': 'printf("%s", name);',
    },
    CStringStep.input: {
      'title': 'READING INPUT STRING USING scanf',
      'content':
      'Use scanf("%s", str) to input a string. Note: scanf stops reading at first whitespace.',
      'code': 'char str[100];\nscanf("%s", str);',
    },
    CStringStep.accessChar: {
      'title': 'ACCESSING INDIVIDUAL CHARACTERS IN A STRING',
      'content': 'Access characters by index. Example: name[0] accesses first character.',
      'code': 'char firstChar = name[0]; // \'A\'',
    },
    CStringStep.changeChar: {
      'title': 'CHANGING CHARACTERS IN A STRING',
      'content': 'Modify characters by assigning a new value at a specific index.',
      'code': 'name[0] = \'M\'; // changes "Alice" to "Mlice"',
    },
    CStringStep.lengthLoop: {
      'title': 'STRING LENGTH DETERMINATION BY LOOPING',
      'content': 'Use a loop to count characters until null terminator \'\\0\' is encountered.',
      'code': 'int length = 0;\nwhile(name[length] != \'\\0\') {\n  length++;\n}',
    },
    CStringStep.copyManual: {
      'title': 'COPYING A STRING MANUALLY',
      'content': 'Copy character-by-character until the null character is found.',
      'code':
      'int i = 0;\nwhile(src[i] != \'\\0\') {\n  dest[i] = src[i];\n  i++;\n}\ndest[i] = \'\\0\';',
    },
    CStringStep.compareManual: {
      'title': 'COMPARING TWO STRINGS MANUALLY',
      'content':
      'Compare strings one character at a time until a difference or the null terminator.',
      'code': '''int strcmp_manual(char *s1, char *s2) {
  int i = 0;
  while(s1[i] == s2[i]) {
    if(s1[i] == '\\0') return 0;
    i++;
  }
  return s1[i] - s2[i];
}
''',
    },
    CStringStep.concatManual: {
      'title': 'CONCATENATING TWO STRINGS MANUALLY',
      'content':
      'Find end of destination string, then append characters from source until null terminator.',
      'code': '''int i = 0, j = 0;
while(dest[i] != '\\0') i++;
while(src[j] != '\\0') {
  dest[i++] = src[j++];
}
dest[i] = '\\0';
''',
    },
    CStringStep.conditionalUse: {
      'title': 'USING STRINGS IN CONDITIONAL STATEMENTS',
      'content':
      'Use manual string comparison (like strcmp_manual) in conditions to check equality.',
      'code': '''if(strcmp_manual(str1, str2) == 0) {
  // strings are equal
}''',
    },
    CStringStep.fgetsInput: {
      'title': 'READING A SENTENCE WITH SPACES (USING fgets)',
      'content':
      'fgets reads an entire line including spaces until newline or limit is reached.',
      'code': '''char line[100];
fgets(line, sizeof(line), stdin);
''',
    },
    CStringStep.detectEnd: {
      'title': 'DETECTING END OF STRING IN LOOPS',
      'content': 'Check for null terminator \'\\0\' to process each character until string end.',
      'code': '''int i = 0;
while(str[i] != '\\0') {
  // process str[i]
  i++;
}
''',
    },
    CStringStep.reverseString: {
      'title': 'EXAMPLE: REVERSE A STRING MANUALLY',
      'content':
      'Swap characters starting from the ends moving to the center to reverse string in place.',
      'code': '''int len = 0;
while(str[len] != '\\0') len++;
for(int i = 0; i < len / 2; i++) {
  char tmp = str[i];
  str[i] = str[len - 1 - i];
  str[len - 1 - i] = tmp;
}
''',
    },
    CStringStep.searchChar: {
      'title': 'EXAMPLE: SEARCHING A CHARACTER IN A STRING',
      'content':
      'Return the position of the first occurrence of a character, or -1 if not found.',
      'code': '''int findChar(char *str, char c) {
  int i = 0;
  while(str[i] != '\\0') {
    if(str[i] == c) return i;
    i++;
  }
  return -1;
}
''',
    },
    CStringStep.quiz: {
      'title': 'QUIZ: STRING MANIPULATION',
      'content':
      'What will be the output of this code snippet?\n\nchar s[] = "Hello";\ns[0] = \'J\';\nprintf("%s", s);',
      'code': '''char s[] = "Hello";
s[0] = 'J';
printf("%s", s);
''',
    },
  };

  Widget _extraExplanation(BuildContext context, CStringStep step) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (step) {
      case CStringStep.intro:
        return Text(
          "In C, strings are not a built-in type but are represented as arrays of characters ending with a special null character '\\0'. "
              "This '\0' character tells functions where the string ends, since arrays don't store their length.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case CStringStep.declareInit:
        return Text(
          "When you initialize a string as a character array, the compiler adds the terminating '\\0' automatically. "
              "Strings declared as pointers to literals should be treated as read-only.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case CStringStep.lengthLoop:
        return Text(
          "Since C strings don't store their length, you must manually determine it by iterating until you hit the terminating null character '\\0'. "
              "This is the principle behind the standard strlen() function.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case CStringStep.copyManual:
        return Text(
          "Manual string copy involves iterating character-by-character until the null terminator and copying each to the destination. "
              "Always ensure the dest array is large enough to accommodate the source string.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case CStringStep.compareManual:
        return Text(
          "String comparison works by scanning corresponding characters and returning zero if all match, else a positive or negative difference of differing characters.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case CStringStep.quiz:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Think about what happens to the string 'Hello' when the first character is changed to 'J'.",
              style: TextStyle(fontSize: 14, height: 1.4, color: _textColor(context)),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly
                      ? null
                      : () {
                    setState(() {
                      _quizFeedback = "Correct! The modified string is 'Jello'.";
                      _quizAnsweredCorrectly = true;
                    });
                  },
                  child: const Text("Jello"),
                ),
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly
                      ? null
                      : () {
                    setState(() {
                      _quizFeedback = "Incorrect. The modification affects the first character.";
                    });
                  },
                  child: const Text("Hello"),
                ),
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly
                      ? null
                      : () {
                    setState(() {
                      _quizFeedback = "Incorrect. The string won't be empty or unchanged.";
                    });
                  },
                  child: const Text("Error / Undefined behavior"),
                ),
              ],
            ),
            if (_quizFeedback != null) ...[
              const SizedBox(height: 14),
              Text(
                _quizFeedback!,
                style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: _quizAnsweredCorrectly ? Colors.green : Colors.redAccent),
              ),
            ],
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStepContent(BuildContext context) {
    final stepData = _stepsData[_step]!;

    final explanationWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(stepData['content'], style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context))),
        const SizedBox(height: 16),
        _extraExplanation(context, _step),
      ],
    );

    final code = stepData['code'];

    Widget codeWidget = const SizedBox.shrink();
    if (code != null) {
      codeWidget = Container(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 600),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.green.shade700 : Colors.grey.shade400),
        ),
        padding: const EdgeInsets.all(12),
        child: SelectableText(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14,
            height: 1.3,
            color: Theme.of(context).brightness == Brightness.dark ? Colors.lightGreenAccent.shade100 : Colors.green.shade900,
          ),
        ),
      );
    }

    final isWideScreen = MediaQuery.of(context).size.width >= 700;

    if (isWideScreen && code != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 6, child: explanationWidget),
          const SizedBox(width: 24),
          Expanded(flex: 4, child: codeWidget),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          explanationWidget,
          if (code != null) const SizedBox(height: 24),
          if (code != null) codeWidget,
        ],
      );
    }
  }

  Widget _annotationBox(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _annotationBgColor(context),
        borderRadius: BorderRadius.circular(11),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, height: 1.3, color: _annotationTextColor(context)),
      ),
    );
  }

  Widget _buildFlowChart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: isDark ? Colors.black54 : Colors.teal.shade50,
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black87 : Colors.grey.withOpacity(0.2),
            blurRadius: 3,
            offset: const Offset(0, 1.5),
          )
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: CStringStep.values.map((s) {
            final active = s == _step;
            final stepName = _spacedUpperCase(s.name);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if (s != _step) {
                    final forward = s.index > _step.index;
                    _gotoStep(s, forward: forward);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: _flowChartBoxDecoration(context, active),
                  child: Text(
                    stepName,
                    style: _flowChartTextStyle(context, active),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    final isFirst = _step.index == 0;
    final isLast = _step.index == CStringStep.values.length - 1;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = _buttonBgColor(context);
    final fgColor = _buttonFgColor(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: isFirst ? null : _previousStep,
          icon: const Icon(Icons.arrow_back),
          label: const Text('Previous'),
          style: ElevatedButton.styleFrom(
            backgroundColor: isFirst ? bgColor.withOpacity(0.5) : bgColor,
            foregroundColor: fgColor,
          ),
        ),
        if (!isLast)
          ElevatedButton.icon(
            onPressed: _nextStep,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Next'),
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              foregroundColor: fgColor,
            ),
          ),
        if (isLast)
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.check),
            label: const Text('Finish'),
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              foregroundColor: fgColor,
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'C Strings - Interactive Tutorial',
          style: TextStyle(color: isDark ? Colors.greenAccent : Colors.teal[900]),
        ),
        backgroundColor: isDark ? Colors.black87 : Colors.teal.shade100,
        iconTheme: IconThemeData(color: isDark ? Colors.greenAccent : Colors.teal[900]),
        centerTitle: true,
      ),
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 30, vertical: 12),
          child: Column(
            children: [
              _buildFlowChart(context),
              const SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: _buildStepContent(context),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
