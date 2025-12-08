import 'package:flutter/material.dart';

enum FunctionPointerStep {
  whatIs,
  whyUse,
  syntaxDecl,
  assignAddress,
  callViaPointer,
  simplifySyntax,
  exampleAdd,
  exampleVoid,
  multiplePointers,
  exampleArray,
  dynamicCalls,
  passAsArg,
  exampleSort,
  callbacksExplained,
  exampleBehaviors,
  ptrReturnsPointer,
  ptrReturnsVoidptr,
  typedefSyntax,
  exampleTypedef,
  mistakesTips,
  quizDeclaration,
  quizOutput,
  summary,
}

class FunctionPointerPage extends StatefulWidget {
  const FunctionPointerPage({Key? key}) : super(key: key);

  @override
  State<FunctionPointerPage> createState() => _FunctionPointerPageState();
}

class _FunctionPointerPageState extends State<FunctionPointerPage>
    with SingleTickerProviderStateMixin {
  FunctionPointerStep _step = FunctionPointerStep.whatIs;

  late final AnimationController _animController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // Quiz state
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
    _slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    ));
  }

  Future<void> _gotoStep(FunctionPointerStep newStep, {bool forward = true}) async {
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
    if (_step.index < FunctionPointerStep.values.length - 1) {
      _gotoStep(FunctionPointerStep.values[_step.index + 1], forward: true);
    }
  }

  void _previousStep() {
    if (_step.index > 0) {
      _gotoStep(FunctionPointerStep.values[_step.index - 1], forward: false);
    }
  }

  Color _textColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87;

  Color _annotationBgColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.green.withOpacity(0.15)
          : Colors.green.shade100;

  Color _annotationTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade100 : Colors.green.shade900;

  Color _flowChartTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.lightGreenAccent.shade100 : Colors.teal.shade900;

  Color _flowChartBoxColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.teal.shade800.withOpacity(0.35) : Colors.teal.shade50;

  Color _flowChartBorderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.withOpacity(0.9) : Colors.green.shade300;

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

  // Helper to insert spaces before uppercase and uppercase string (for flowchart display)
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

  // Step data including multiple code snippets and more explanatory content for richness.
  // For simplicity, one main code snippet per step.
  static const Map<FunctionPointerStep, Map<String, dynamic>> _stepsData = {
    FunctionPointerStep.whatIs: {
      'title': 'WHAT IS A FUNCTION POINTER?',
      'content':
      'A function pointer stores the address of a function allowing indirect function calls. It is a variable that points to executable code instead of data.',
      'code': null,
      'annotation': 'Function pointers enable dynamic invocation of different functions at runtime.',
    },
    FunctionPointerStep.whyUse: {
      'title': 'WHY USE FUNCTION POINTERS?',
      'content':
      'They enable callbacks, dynamic dispatch, and function tables—fundamental for modular and event-driven programming.',
      'code': null,
      'annotation': 'Function pointers improve code flexibility and reusability.',
    },
    FunctionPointerStep.syntaxDecl: {
      'title': 'SYNTAX: FUNCTION POINTER DECLARATION',
      'content': 'Declare a function pointer specifying the return type and parameters.\nExample:',
      'code': 'int (*funcPtr)(int, int);',
    },
    FunctionPointerStep.assignAddress: {
      'title': 'ASSIGN FUNCTION ADDRESS TO POINTER',
      'content':
      'Assign addresses using the function name or & operator. Both work:\nfuncPtr = add;\nfuncPtr = &add;',
      'code': 'funcPtr = add;\n// or\nfuncPtr = &add;',
    },
    FunctionPointerStep.callViaPointer: {
      'title': 'CALL FUNCTION VIA POINTER',
      'content':
      'Invoke the function indirectly via the pointer:\nresult = funcPtr(2, 3);',
      'code': 'int result = funcPtr(2, 3);',
      'annotation': 'This calls the function stored in funcPtr with arguments 2 and 3.',
    },
    FunctionPointerStep.simplifySyntax: {
      'title': 'SIMPLIFYING SYNTAX',
      'content':
      'The & and * operators are optional when assigning and calling functions via pointers in C.',
      'code': null,
    },
    FunctionPointerStep.exampleAdd: {
      'title': 'EXAMPLE: FUNCTION POINTER TO ADD FUNCTION',
      'content':
      'Define add function and assign it to a function pointer to call later.',
      'code': '''
int add(int a, int b) {
  return a + b;
}

int (*funcPtr)(int, int);
funcPtr = add;

int sum = funcPtr(3, 4); // sum is 7
''',
      'annotation': 'Function pointer stores address of add and is used to call it.',
    },
    FunctionPointerStep.exampleVoid: {
      'title': 'EXAMPLE: VOID FUNCTION POINTER WITH NO PARAMETERS',
      'content': 'Function pointers can also point to void functions with no parameters.',
      'code': '''
void greet() {
  printf("Hello");
}

void (*funcPtrVoid)();
funcPtrVoid = greet;
funcPtrVoid();
''',
    },
    FunctionPointerStep.multiplePointers: {
      'title': 'MULTIPLE FUNCTION POINTERS IN AN ARRAY',
      'content': 'Store pointers in arrays useful for dispatching functions dynamically.',
      'code': '''
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }

int (*operations[2])(int, int) = {add, subtract};

int result = operations[1](5, 3); // Calls subtract(5, 3)
''',
    },
    FunctionPointerStep.exampleArray: {
      'title': 'ARRAY OF FUNCTION POINTERS FOR ARITHMETIC',
      'content':
      'Array can store multiple function pointers to call arithmetic operations dynamically.',
      'code': null,
    },
    FunctionPointerStep.dynamicCalls: {
      'title': 'DYNAMIC FUNCTION CALLS USING POINTER ARRAYS',
      'content':
      'Select which function to call based on input or state by indexing into function pointer arrays.',
      'code': null,
    },
    FunctionPointerStep.passAsArg: {
      'title': 'PASSING FUNCTION POINTERS AS ARGUMENTS (CALLBACKS)',
      'content':
      'Functions can accept function pointers as parameters to perform callbacks.',
      'code': '''
void performOperation(int (*op)(int, int), int a, int b) {
  int result = op(a, b);
  printf("Result: %d\\n", result);
}

// Usage:
performOperation(add, 5, 3);
''',
    },
    FunctionPointerStep.exampleSort: {
      'title': 'EXAMPLE: SORT FUNCTION USING COMPARATOR FUNCTION POINTER',
      'content':
      'Implement sorting by passing comparator functions as pointers to customize ordering.',
      'code': null,
    },
    FunctionPointerStep.callbacksExplained: {
      'title': 'CALLBACK FUNCTIONS WITH FUNCTION POINTERS',
      'content':
      'Callbacks let code execute user-defined functions on events or milestones using pointers.',
      'code': null,
    },
    FunctionPointerStep.exampleBehaviors: {
      'title': 'USING FUNCTION POINTERS TO HANDLE MULTIPLE BEHAVIORS',
      'content':
      'Switch behaviors at runtime by selecting different functions through pointers.',
      'code': null,
    },
    FunctionPointerStep.ptrReturnsPointer: {
      'title': 'FUNCTION POINTERS TO FUNCTIONS RETURNING POINTERS',
      'content':
      'Function pointers can point to functions that return pointers, enabling advanced usage.',
      'code': null,
    },
    FunctionPointerStep.ptrReturnsVoidptr: {
      'title': 'FUNCTION POINTERS RETURNING VOID POINTERS',
      'content': 'Useful for generic programming patterns with void * return types.',
      'code': null,
    },
    FunctionPointerStep.typedefSyntax: {
      'title': 'USING typedef FOR FUNCTION POINTERS',
      'content': 'typedef simplifies function pointer declarations.',
      'code': '''
typedef int (*FuncPtr)(int, int);

FuncPtr fp = add;
''',
    },
    FunctionPointerStep.exampleTypedef: {
      'title': 'EXAMPLE: typedef FOR FUNCTION POINTERS',
      'content': 'Create cleaner code with typedef declarations.',
      'code': null,
    },
    FunctionPointerStep.mistakesTips: {
      'title': 'COMMON MISTAKES AND TIPS',
      'content':
      '- Parenthesis placement is critical.\n- Match signatures exactly.\n- Avoid null or dangling pointers.\n- Use const correctness when applicable.',
      'code': null,
    },
    FunctionPointerStep.quizDeclaration: {
      'title': 'QUIZ: IDENTIFY CORRECT FUNCTION POINTER DECLARATION',
      'content': 'Given a function signature, select the correct declaration.',
      'code': null,
    },
    FunctionPointerStep.quizOutput: {
      'title': 'QUIZ: PREDICT OUTPUT OF FUNCTION POINTER USAGE',
      'content': 'Analyze code using function pointers and predict output.',
      'code': '''int add(int a, int b) {
  return a + b;
}

int subtract(int a, int b) {
  return a - b;
}

int (*funcPtr)(int, int);
funcPtr = add;

int main() {
  printf("%d\\n", funcPtr(5, 3));
  funcPtr = subtract;
  printf("%d\\n", funcPtr(5, 3));
  return 0;
}
// Output?''',
    },
    FunctionPointerStep.summary: {
      'title': 'SUMMARY AND BEST PRACTICES',
      'content':
      'Function pointers allow dynamic and modular programming. Always match function signatures, use typedefs for clarity, and handle pointers carefully.',
      'code': null,
    },
  };

  Widget _extraExplanation(BuildContext context, FunctionPointerStep step) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (step) {
      case FunctionPointerStep.whatIs:
        return Text(
          "Function pointers are variables that hold the address of a function. "
              "They allow you to call functions indirectly, enabling dynamic function calls and callbacks.\n\n"
              "This is crucial in systems programming, event handling, and driver development.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case FunctionPointerStep.exampleAdd:
        return Text(
          "This example illustrates declaring a function pointer `funcPtr` compatible with the `add` function. "
              "Assign it and call it like a normal function. This flexibility lets you swap the actual function at runtime.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case FunctionPointerStep.passAsArg:
        return Text(
          "Passing function pointers as arguments enables higher-order functions. "
              "You can pass behavior as parameters to functions, enabling callbacks and custom operations.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case FunctionPointerStep.quizDeclaration:
        return Text(
          "Think carefully about function signatures and pointer syntax to declare the correct function pointer.",
          style: TextStyle(fontSize: 14, height: 1.4, color: _textColor(context)),
        );
      case FunctionPointerStep.quizOutput:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "The program assigns `funcPtr` to `add` and then `subtract`. Predict the output printed by `main`.",
              style: TextStyle(fontSize: 14, height: 1.4, color: _textColor(context)),
            ),
            const SizedBox(height: 12),
            Text("Select your answer:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly
                      ? null
                      : () {
                    setState(() {
                      _quizFeedback = "Correct! Output is: 8 then 2";
                      _quizAnsweredCorrectly = true;
                    });
                  },
                  child: const Text("8\n2"),
                ),
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly
                      ? null
                      : () {
                    setState(() {
                      _quizFeedback = "Incorrect. Function pointers correctly call add and subtract functions.";
                    });
                  },
                  child: const Text("5\n3"),
                ),
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly
                      ? null
                      : () {
                    setState(() {
                      _quizFeedback = "Incorrect output, try again!";
                    });
                  },
                  child: const Text("Compilation error"),
                ),
              ],
            ),
            if (_quizFeedback != null) ...[
              const SizedBox(height: 12),
              Text(
                _quizFeedback!,
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: _quizAnsweredCorrectly ? Colors.green : Colors.redAccent,
                ),
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
        Text(
          stepData['content'],
          style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
        ),
        const SizedBox(height: 16),
        _extraExplanation(context, _step),
        if (stepData['annotation'] != null)
          _annotationBox(context, stepData['annotation']),
      ],
    );

    final code = stepData['code'];
    final codeWidget = code == null
        ? const SizedBox.shrink()
        : Container(
      constraints: const BoxConstraints(
        minWidth: 200,
        maxWidth: 600,
      ),
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

    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 700;

    if (isWide) {
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
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: _annotationBgColor(context),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: _annotationTextColor(context),
          fontStyle: FontStyle.italic,
          height: 1.3,
        ),
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
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: FunctionPointerStep.values.map((step) {
            final active = step == _step;
            final stepName = _spacedUpperCase(step.name);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if (step != _step) {
                    final forward = step.index > _step.index;
                    _gotoStep(step, forward: forward);
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
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    final isFirst = _step.index == 0;
    final isLast = _step.index == FunctionPointerStep.values.length - 1;
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pointer to Function in C',
          style: TextStyle(
            color: isDark ? Colors.greenAccent : Colors.teal[900],
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: 22,
          ),
        ),
        backgroundColor: isDark ? Colors.black87 : Colors.teal.shade100,
        centerTitle: true,
        iconTheme: IconThemeData(color: isDark ? Colors.greenAccent : Colors.teal[900]),
      ),
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Persistent flowchart at top
            _buildFlowChart(context),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Current step title in uppercase with styling
                          Text(
                            _stepsData[_step]!['title'],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.greenAccent.shade100 : Colors.teal[900],
                              letterSpacing: 1.5,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 28),
                          _buildStepContent(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Navigation buttons at bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: _buildNavigationButtons(context),
            ),
          ],
        ),
      ),
    );
  }
}
