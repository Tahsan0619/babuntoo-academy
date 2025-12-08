import 'package:flutter/material.dart';

enum RecursionStep {
  whatIs,
  whyUse,
  components,
  callStack,
  factorialOverview,
  writingFactorial,
  traceFactorial,
  baseCaseImportance,
  stackOverflow,
  indirectRecursion,
  fibonacci,
  traceFibonacci,
  sumArray,
  binarySearch,
  reverseString,
  linkedListTraversal,
  recursionVsIteration,
  tailRecursion,
  stackLimits,
  memoization,
  whenNotToUse,
  quiz,
}

class RecursionPage extends StatefulWidget {
  const RecursionPage({Key? key}) : super(key: key);

  @override
  State<RecursionPage> createState() => _RecursionPageState();
}

class _RecursionPageState extends State<RecursionPage> with SingleTickerProviderStateMixin {
  RecursionStep _step = RecursionStep.whatIs;

  late final AnimationController _animController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  String? _quizFeedback;
  bool _quizAnsweredCorrectly = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _setupAnimations();
    _animController.forward();
  }

  void _setupAnimations({bool forward = true}) {
    final beginOffset = forward ? const Offset(1, 0) : const Offset(-1, 0);
    _slideAnimation = Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  Future<void> _gotoStep(RecursionStep newStep, {bool forward = true}) async {
    await _animController.reverse();
    setState(() {
      _step = newStep;
      _quizFeedback = null;
      _quizAnsweredCorrectly = false;
      _setupAnimations(forward: forward);
    });
    await _animController.forward();
  }

  void _nextStep() {
    if (_step.index < RecursionStep.values.length - 1) {
      _gotoStep(RecursionStep.values[_step.index + 1], forward: true);
    }
  }

  void _previousStep() {
    if (_step.index > 0) {
      _gotoStep(RecursionStep.values[_step.index - 1], forward: false);
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

  static const Map<RecursionStep, Map<String, dynamic>> _stepsData = {
    RecursionStep.whatIs: {
      'title': 'WHAT IS RECURSION?',
      'content':
      'Recursion is a programming technique where a function calls itself to solve a smaller instance of a problem.',
      'code': null,
    },
    RecursionStep.whyUse: {
      'title': 'WHY USE RECURSION?',
      'content':
      'Recursion simplifies complex problems that involve repetition or nested structure by breaking them into simpler subproblems.',
    },
    RecursionStep.components: {
      'title': 'COMPONENTS OF A RECURSIVE FUNCTION',
      'content':
      'Every recursive function has:\n• A base case (which stops further recursion)\n• A recursive case (where the function calls itself with a simpler problem).',
    },
    RecursionStep.callStack: {
      'title': 'VISUALIZING RECURSION CALL STACK',
      'content':
      'Each recursive call is stacked in memory until a base case is reached, after which the stack unwinds as functions complete.',
      'code': null,
    },
    RecursionStep.factorialOverview: {
      'title': 'SIMPLE EXAMPLE: FACTORIAL FUNCTION OVERVIEW',
      'content':
      'The factorial of n (written as n!) is the product of all positive integers up to n. It\'s a classic recursive problem.',
    },
    RecursionStep.writingFactorial: {
      'title': 'WRITING THE FACTORIAL FUNCTION (CONCEPTUAL)',
      'content':
      '• Base case: factorial(0) = 1\n• Recursive case: factorial(n) = n * factorial(n-1)',
      'code': '''
int factorial(int n) {
  if (n == 0) return 1;         // base case
  else return n * factorial(n-1); // recursive case
}
''',
    },
    RecursionStep.traceFactorial: {
      'title': 'RECURSION IN ACTION: TRACE factorial(3)',
      'content':
      'Step by step:\n- factorial(3) calls factorial(2)\n- factorial(2) calls factorial(1)\n- factorial(1) calls factorial(0)\n- factorial(0) returns 1; then calls unwind:\n- factorial(1) = 1 * 1 = 1\n- factorial(2) = 2 * 1 = 2\n- factorial(3) = 3 * 2 = 6',
    },
    RecursionStep.baseCaseImportance: {
      'title': 'IMPORTANCE OF BASE CASE',
      'content':
      'A missing or unreachable base case causes recursive calls to never stop, leading to stack overflow (infinite recursion).',
    },
    RecursionStep.stackOverflow: {
      'title': 'UNDERSTANDING STACK OVERFLOW',
      'content': 'Stack overflow happens when too many recursive calls consume all available stack memory.',
    },
    RecursionStep.indirectRecursion: {
      'title': 'INDIRECT AND MUTUAL RECURSION',
      'content':
      'Functions can call themselves indirectly, forming a cycle (A → B → A). This is used for alternate behaviors and division of complex logic (optional/advanced).',
    },
    RecursionStep.fibonacci: {
      'title': 'EXAMPLE: FIBONACCI NUMBERS USING RECURSION',
      'content':
      'The nth Fibonacci number is defined as:\n• F(0) = 0, F(1) = 1\n• F(n) = F(n-1) + F(n-2) for n > 1',
      'code': '''
int fibonacci(int n) {
  if (n <= 1) return n;
  return fibonacci(n-1) + fibonacci(n-2);
}
''',
    },
    RecursionStep.traceFibonacci: {
      'title': 'TRACING RECURSIVE FIBONACCI CALLS',
      'content':
      'Tracing fibonacci(4):\n- fibonacci(4) → (3) + (2)\n- fibonacci(3) → (2) + (1)\n- fibonacci(2)...\nObserve the repeated calls for the same values (overlapping subproblems).',
    },
    RecursionStep.sumArray: {
      'title': 'EXAMPLE: RECURSIVE SUM OF ARRAY ELEMENTS',
      'content':
      'Sum array elements recursively by splitting as first element + sum of rest.',
      'code': '''
int sumArray(int arr[], int size) {
  if (size == 0) return 0;
  return arr[0] + sumArray(arr + 1, size - 1);
}
''',
    },
    RecursionStep.binarySearch: {
      'title': 'EXAMPLE: RECURSIVE BINARY SEARCH',
      'content':
      'Recursive binary search divides the array and calls itself with a reduced segment until the item is found or the segment is empty.',
    },
    RecursionStep.reverseString: {
      'title': 'EXAMPLE: PRINTING A STRING IN REVERSE RECURSIVELY',
      'content':
      'Print the string backward by recurring to the end and printing characters while returning.',
      'code': '''
void printReverse(char *str) {
  if (*str == '\\0') return;
  printReverse(str + 1);
  putchar(*str);
}
''',
    },
    RecursionStep.linkedListTraversal: {
      'title': 'TRAVERSING LINKED LIST RECURSIVELY (OPTIONAL)',
      'content':
      'Recursion can be used to traverse nodes in a linked list, processing each node, then calling itself for the next.',
    },
    RecursionStep.recursionVsIteration: {
      'title': 'RECURSION VS ITERATION',
      'content':
      'Some problems are easier to write recursively but run more efficiently with iteration. Recursion can be clearer but may be less performant.',
    },
    RecursionStep.tailRecursion: {
      'title': 'TAIL RECURSION',
      'content':
      'Tail recursion occurs when the last operation of a function is a recursive call. In some languages, tail-recursive functions are optimized, using less stack.',
    },
    RecursionStep.stackLimits: {
      'title': 'RECURSIVE DEPTH AND STACK LIMITS',
      'content':
      'Most systems set a maximum stack size. Deep recursion (too many nested calls) can exceed this limit, causing stack overflow.',
    },
    RecursionStep.memoization: {
      'title': 'AVOIDING EXCESSIVE RECURSION WITH MEMOIZATION',
      'content':
      'Memoization saves previous results, avoiding repeated work and speeding up recursive algorithms like Fibonacci sequence calculation.',
    },
    RecursionStep.whenNotToUse: {
      'title': 'WHEN NOT TO USE RECURSION',
      'content':
      'When an iterative solution is clearer, more efficient, or stack depth is a concern, prefer iteration.',
    },
    RecursionStep.quiz: {
      'title': 'QUIZ: RECURSION BASICS',
      'content':
      'What is the result printed by the following code snippet?\n\nint factorial(int n) {\n  if (n == 0) return 1;\n  else return n * factorial(n - 1);\n}\n\nprintf("%d", factorial(4));',
      'code': '''
int factorial(int n) {
  if (n == 0) return 1;
  else return n * factorial(n - 1);
}

printf("%d", factorial(4));
''',
    },
  };

  Widget _extraExplanation(BuildContext context, RecursionStep step) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (step) {
      case RecursionStep.whatIs:
        return Text(
          'Recursion breaks down problems into smaller versions of themselves, '
              'simplifying complex tasks such as searching, sorting, and mathematical computations.\n\n'
              'It is widely used in algorithms, data structures, and mathematical functions.',
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case RecursionStep.writingFactorial:
        return Text(
          'The factorial function demonstrates the essence of recursion clearly through two parts: a terminating base case and the recursive call that simplifies the problem.',
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case RecursionStep.fibonacci:
        return Text(
          'The recursive Fibonacci function elegantly captures the mathematical definition but is inefficient without memoization due to repeated calculations.\n\n'
              'Later we discuss how to optimize using memoization.',
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case RecursionStep.memoization:
        return Text(
          'Memoization caches results of recursive calls to avoid redundant computation, significantly optimizing recursive algorithms like Fibonacci.',
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case RecursionStep.quiz:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What will the factorial function print for input 4?\n\nSelect your answer below and try to explain why.',
              style: TextStyle(fontSize: 14, height: 1.4, color: _textColor(context)),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                    onPressed: _quizAnsweredCorrectly
                        ? null
                        : () {
                      setState(() {
                        _quizFeedback = 'Correct! 4! = 4 × 3 × 2 × 1 = 24.';
                        _quizAnsweredCorrectly = true;
                      });
                    },
                    child: const Text('24')),
                ElevatedButton(
                    onPressed: _quizAnsweredCorrectly
                        ? null
                        : () {
                      setState(() {
                        _quizFeedback = 'Incorrect. Recall factorial of n is n × factorial(n-1).';
                      });
                    },
                    child: const Text('120')),
                ElevatedButton(
                    onPressed: _quizAnsweredCorrectly
                        ? null
                        : () {
                      setState(() {
                        _quizFeedback = 'Incorrect. The base case is factorial(0), not factorial(4).';
                      });
                    },
                    child: const Text('1')),
              ],
            ),
            if (_quizFeedback != null) ...[
              const SizedBox(height: 16),
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
        if (stepData['annotation'] != null)
          _annotationBox(context, stepData['annotation']),
      ],
    );

    final code = stepData['code'];
    Widget codeWidget;
    if (code != null) {
      codeWidget = Container(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 600),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.green.shade700 : Colors.grey.shade400),
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
    } else {
      codeWidget = const SizedBox.shrink();
    }

    final isWide = MediaQuery.of(context).size.width >= 700;

    if (isWide && code != null) {
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
          if (code != null) ...[
            const SizedBox(height: 24),
            codeWidget,
          ],
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
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, height: 1.3, color: _annotationTextColor(context)),
      ),
    );
  }

  Widget _recursionIntroFlowChart(BuildContext context) {
    final txtClr = _flowChartTextColor(context);
    final boxClr = _flowChartBoxColor(context);
    final brdClr = _flowChartBorderColor(context);

    return Container(
      decoration: BoxDecoration(
        color: boxClr,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: brdClr, width: 1.3),
      ),
      margin: const EdgeInsets.symmetric(vertical: 18),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recursion Concept Flowchart',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: txtClr),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            alignment: WrapAlignment.center,
            children: [
              _flowChartBox('Function Called', txtClr, boxClr, brdClr),
              _flowChartArrow(txtClr),
              _flowChartBox('Base Case?', txtClr, boxClr, brdClr),
              _flowChartArrow(txtClr),
              _flowChartBox('If No: Call Self with Simpler Problem', txtClr, boxClr, brdClr),
              _flowChartArrow(txtClr),
              _flowChartBox('If Yes: Return Result', txtClr, boxClr, brdClr),
              _flowChartArrow(txtClr),
              _flowChartBox('Unwind and Combine Results', txtClr, boxClr, brdClr),
            ],
          ),
        ],
      ),
    );
  }

  Widget _callStackFlowchart(BuildContext context) {
    final txtClr = _flowChartTextColor(context);
    final boxClr = _flowChartBoxColor(context);
    final brdClr = _flowChartBorderColor(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: boxClr,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: brdClr, width: 1.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recursion Call Stack Visualization',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: txtClr),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Wrap(
              spacing: 14,
              children: [
                _flowChartBox('main()', txtClr, boxClr, brdClr),
                _flowChartArrow(txtClr),
                _flowChartBox('factorial(3)', txtClr, boxClr, brdClr),
                _flowChartArrow(txtClr),
                _flowChartBox('factorial(2)', txtClr, boxClr, brdClr),
                _flowChartArrow(txtClr),
                _flowChartBox('factorial(1)', txtClr, boxClr, brdClr),
                _flowChartArrow(txtClr),
                _flowChartBox('factorial(0)', txtClr, boxClr, brdClr),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Each call waits until its inner call returns, then continues. The stack 'unwinds' as each returns.",
            style: TextStyle(color: txtClr, fontSize: 13, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _flowChartBox(String text, Color textColor, Color bgColor, Color borderColor) => Container(
    width: 150,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: borderColor, width: 1.2),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 13),
    ),
  );

  Widget _flowChartArrow(Color color) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Icon(Icons.arrow_forward, color: color, size: 25),
  );

  Widget _buildFlowChart(BuildContext context) {
    // Show intro flowchart on the first step, call stack flowchart on callStack step, else horizontal step bar
    if (_step == RecursionStep.whatIs) return _recursionIntroFlowChart(context);
    if (_step == RecursionStep.callStack) return _callStackFlowchart(context);

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
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: RecursionStep.values.map((s) {
            final active = s == _step;
            final stepName = _spacedUpperCase(s.name);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: InkWell(
                onTap: () {
                  if (s != _step) {
                    final forward = s.index > _step.index;
                    _gotoStep(s, forward: forward);
                  }
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: _flowChartBoxDecoration(context, active),
                  child: Text(
                    stepName,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: _flowChartTextStyle(context, active),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNavigation(bool isDark) {
    final isFirst = _step.index == 0;
    final isLast = _step.index == RecursionStep.values.length - 1;
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
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final horizontalPadding = MediaQuery.of(context).size.width < 600 ? 14.0 : 36.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recursion in C',
          style: TextStyle(color: isDark ? Colors.greenAccent : Colors.teal[900]!),
        ),
        backgroundColor: isDark ? Colors.black87 : Colors.teal.shade100,
        iconTheme: IconThemeData(color: isDark ? Colors.greenAccent : Colors.teal[900]),
        centerTitle: true,
      ),
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 14),
          child: Column(
            children: [
              _buildFlowChart(context),
              const SizedBox(height: 12),
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
              const SizedBox(height: 14),
              _buildNavigation(isDark),
            ],
          ),
        ),
      ),
    );
  }
}
