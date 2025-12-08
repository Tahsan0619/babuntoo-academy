import 'package:flutter/material.dart';

enum PointerStep {
  declaration,
  assignAddress,
  dereference,
  pointersAndMemory,
  syntaxVariations,
  commonUses,
  pointerArithmetic,
  pointerTypes,
  nullPointer,
  functionArguments,
  quiz,
}

class PointerPage extends StatefulWidget {
  const PointerPage({Key? key}) : super(key: key);

  @override
  State<PointerPage> createState() => _PointerPageState();
}

class _PointerPageState extends State<PointerPage> with SingleTickerProviderStateMixin {
  PointerStep _step = PointerStep.declaration;

  late final AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // Quiz state
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

  Future<void> _goToStep(PointerStep newStep, {bool forward = true}) async {
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
    if (_step.index < PointerStep.values.length - 1) {
      _goToStep(PointerStep.values[_step.index + 1], forward: true);
    }
  }

  void _previousStep() {
    if (_step.index > 0) {
      _goToStep(PointerStep.values[_step.index - 1], forward: false);
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
      Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.withOpacity(0.65) : Colors.green.shade200;

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

  // Detailed step contents with expanded explanations and code.

  static const Map<PointerStep, Map<String, dynamic>> _stepsData = {
    PointerStep.declaration: {
      'title': 'POINTER DECLARATION',
      'content':
      'Use an asterisk (*) to declare a pointer of a specific data type. '
          'Pointers hold memory addresses and must be declared with the proper type.\n\nExample:\nint *ptr; // ptr is a pointer to an int',
      'code': 'int *ptr; // ptr points to an int',
    },
    PointerStep.assignAddress: {
      'title': 'ASSIGNING ADDRESS TO POINTER',
      'content':
      'Assign the address of a variable to a pointer with the & operator. The pointer then stores where the variable is located in memory.\n\nExample:\nint x = 10;\nint *ptr = &x; // ptr now holds the address of x',
      'code': '''int x = 10;
int *ptr = &x;  // ptr holds address of x
''',
    },
    PointerStep.dereference: {
      'title': 'DEREFERENCING A POINTER',
      'content':
      'Use the * operator to access or modify the content at the pointer\'s address. Dereferencing gives the value stored at that address.\n\nExample:\nprintf("%d", *ptr); // prints value pointed to by ptr\n*ptr = 20;          // changes value at ptr to 20',
      'code': '''printf("%d", *ptr); // prints value at ptr
*ptr = 20;          // changes value at ptr
''',
    },
    PointerStep.pointersAndMemory: {
      'title': 'POINTERS AND MEMORY',
      'content':
      'A pointer variable stores a memory address, which can be displayed with %p in printf. Dereferencing accesses data at that memory location.\n\nPointers are the bridge between variables and memory in C programming.',
    },
    PointerStep.syntaxVariations: {
      'title': 'POINTER SYNTAX VARIATIONS',
      'content': 'Multiple valid ways to declare pointers:\n\nint* p1; // Pointer to int p1\nint *p2; // Pointer to int p2\nint * p3; // Pointer to int p3',
      'code': '''int* p1;
int *p2;
int * p3;
''',
    },
    PointerStep.commonUses: {
      'title': 'COMMON USES OF POINTERS',
      'content':
      'Pointers are essential for:\n\n• Indirectly accessing and modifying variables.\n• Efficiently passing arrays or large data structures to functions.\n• Dynamic memory allocation and management.\n• Implementing complex data structures such as linked lists and trees.',
    },
    PointerStep.pointerArithmetic: {
      'title': 'POINTER ARITHMETIC',
      'content':
      'Pointer arithmetic moves the pointer through memory relative to the size of the type it points to.\nFor example, if ptr points to an int, ptr++ advances it to the next int in memory.\n\nThe pointer arithmetic respects data size, avoiding byte offsets that could cause errors.',
    },
    PointerStep.pointerTypes: {
      'title': 'POINTERS TO DIFFERENT DATA TYPES',
      'content':
      'Pointers must point to compatible types:\n\nint *  → pointer to int\nchar * → pointer to char\nfloat * → pointer to float\n\nThis type information helps the compiler manage memory access correctly.',
    },
    PointerStep.nullPointer: {
      'title': 'NULL POINTER',
      'content':
      'A null pointer points to nothing — a sentinel to indicate it is not initialized or currently pointing anywhere valid.\n\nAlways initialize pointers to NULL if they do not immediately point to valid data to avoid undefined behavior.',
      'code': '''int *ptr = NULL;  // Ptr points to nothing
''',
    },
    PointerStep.functionArguments: {
      'title': 'POINTERS AS FUNCTION ARGUMENTS',
      'content':
      'Passing pointers as arguments lets functions modify variables defined in the caller, enabling pass-by-reference behavior.\n\nExample:\nvoid increment(int *p) {\n  (*p)++;\n}\n\nint x = 5;\nincrement(&x);\n// x is now 6',
      'code': '''void increment(int *p) {
  (*p)++;
}

int x = 5;
increment(&x);
// x is now 6
''',
    },
    PointerStep.quiz: {
      'title': 'QUIZ: POINTERS BASICS',
      'content':
      'What will be the output of this code snippet? Select the correct answer.\n\nExample snippet:\n\nint x = 7;\nint *p = &x;\n*p = 14;\nprintf("%d", x);',
      'code': '''int x = 7;
int *p = &x;
*p = 14;
printf("%d", x);
''',
    },
  };

  Widget _extraExplanation(BuildContext context, PointerStep step) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (step) {
      case PointerStep.declaration:
        return Text(
          "Declaring a pointer does not allocate space for the data it will point to; it only creates a variable to store an address. "
              "Pointers allow you to indirectly access and manipulate data stored elsewhere in memory, which is fundamental in C programming.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case PointerStep.assignAddress:
        return Text(
          "Assigning a pointer the address of a variable means the pointer now \"points\" to that variable's location in memory. "
              "Any dereference operator on this pointer accesses or changes the actual variable.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case PointerStep.dereference:
        return Text(
          "Dereferencing is how you *follow* the pointer to get or set the pointed data. It allows you to work with the value at the memory location rather than the pointer itself.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case PointerStep.quiz:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Explanation: Since *p = 14 changes the value at the address p points to (which is x), printing x afterwards will show 14, not 7.",
              style: TextStyle(fontSize: 14, height: 1.4, color: _textColor(context)),
            ),
            const SizedBox(height: 12),
            Text("Select your answer:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 6,
              children: [
                ElevatedButton(
                    onPressed: _quizAnsweredCorrectly
                        ? null
                        : () {
                      setState(() {
                        _quizFeedback = "Correct! The output will be 14.";
                        _quizAnsweredCorrectly = true;
                      });
                    },
                    child: const Text("14")),
                ElevatedButton(
                    onPressed: _quizAnsweredCorrectly
                        ? null
                        : () {
                      setState(() {
                        _quizFeedback = "Incorrect. Remember, *p = 14 modifies x.";
                      });
                    },
                    child: const Text("7")),
                ElevatedButton(
                    onPressed: _quizAnsweredCorrectly
                        ? null
                        : () {
                      setState(() {
                        _quizFeedback = "Incorrect. Dereferencing modifies the value pointed to.";
                      });
                    },
                    child: const Text("Compilation error")),
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

    final explanation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stepData['content'],
          style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
        ),
        const SizedBox(height: 16),
        _extraExplanation(context, _step),
        if (stepData['annotation'] != null) _annotationBox(context, stepData['annotation']),
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
            color: Theme.of(context).brightness == Brightness.dark ? Colors.green.shade700 : Colors.grey.shade400,
          ),
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
          Expanded(flex: 6, child: explanation),
          const SizedBox(width: 24),
          Expanded(flex: 4, child: codeWidget),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          explanation,
          if (code != null) ...[
            const SizedBox(height: 24),
            codeWidget,
          ],
        ],
      );
    }
  }

  Widget _annotationBox(BuildContext context, String text) => Container(
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

  Widget _buildFlowChart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: isDark ? Colors.black54 : Colors.teal.shade50,
        boxShadow: [
          BoxShadow(color: isDark ? Colors.black87 : Colors.grey.withOpacity(0.2), blurRadius: 3, offset: const Offset(0, 1.5)),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: PointerStep.values.map((step) {
            final isActive = step == _step;
            final stepName = _spacedUpperCase(step.name);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if (step != _step) {
                    final forward = step.index > _step.index;
                    _goToStep(step, forward: forward);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: _flowChartBoxDecoration(context, isActive),
                  child: Text(
                    stepName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: _flowChartTextStyle(context, isActive),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    final bool isFirst = _step.index == 0;
    final bool isLast = _step.index == PointerStep.values.length - 1;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonBgColor = _buttonBgColor(context);
    final buttonFgColor = _buttonFgColor(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.arrow_back),
          label: const Text("Previous"),
          onPressed: isFirst ? null : _previousStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: isFirst ? buttonBgColor.withOpacity(0.5) : buttonBgColor,
            foregroundColor: buttonFgColor,
          ),
        ),
        if (!isLast)
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Next"),
            onPressed: _nextStep,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonBgColor,
              foregroundColor: buttonFgColor,
            ),
          ),
        if (isLast)
          ElevatedButton.icon(
            icon: const Icon(Icons.check),
            label: const Text("Finish"),
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonBgColor,
              foregroundColor: buttonFgColor,
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isDark ? Colors.black87 : Colors.teal.shade100,
        iconTheme: IconThemeData(color: isDark ? Colors.greenAccent : Colors.teal[900]),
        title: Text(
          'Pointers in C - Interactive',
          style: TextStyle(
            color: isDark ? Colors.greenAccent : Colors.teal[900],
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.2,
          ),
        ),
      ),
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 30, vertical: 12),
          child: Column(
            children: [
              // Flowchart persistent at top
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

              const SizedBox(height: 14),
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
