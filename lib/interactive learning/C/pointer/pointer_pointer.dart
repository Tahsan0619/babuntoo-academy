import 'package:flutter/material.dart';

enum PointerToPointerStep {
  recapPointer,
  introPointerToPointer,
  whyUse,
  syntaxDeclaration,
  assigningAccess,
  exampleDecl,
  dereference,
  printfDisplay,
  changeValueDoubleDereference,
  changePointerVariable,
  passToFunctions,
  modifyPointerInFunc,
  ptrToPtrAndArrays,
  iterateArrayPtrs,
  multilevelIndirection,
  swapPointers,
  commonMistake,
  nullPointerChecks,
  memoryManagement,
  quizExample,
  summary,
}

class PointerToPointerPage extends StatefulWidget {
  const PointerToPointerPage({Key? key}) : super(key: key);

  @override
  State<PointerToPointerPage> createState() => _PointerToPointerPageState();
}

class _PointerToPointerPageState extends State<PointerToPointerPage> with SingleTickerProviderStateMixin {
  PointerToPointerStep _step = PointerToPointerStep.recapPointer;

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

  Future<void> _goToStep(PointerToPointerStep newStep, {bool forward = true}) async {
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
    if (_step.index < PointerToPointerStep.values.length - 1) {
      _goToStep(PointerToPointerStep.values[_step.index + 1], forward: true);
    }
  }

  void _previousStep() {
    if (_step.index > 0) {
      _goToStep(PointerToPointerStep.values[_step.index - 1], forward: false);
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

  // Step content data with expanded explanations & examples
  static const Map<PointerToPointerStep, Map<String, dynamic>> _stepsData = {
    PointerToPointerStep.recapPointer: {
      'title': 'RECAP: WHAT IS A POINTER?',
      'content':
      'A pointer stores the memory address of another variable, enabling indirect memory access. It\'s fundamental for dynamic programming in C.',
    },
    PointerToPointerStep.introPointerToPointer: {
      'title': 'INTRODUCING POINTER TO POINTER',
      'content':
      'A pointer to pointer stores the address of another pointer. This adds an additional layer of indirection.',
    },
    PointerToPointerStep.whyUse: {
      'title': 'WHY USE POINTER TO POINTER?',
      'content':
      'Useful for dynamic memory management, altering pointers in functions, and implementing advanced data structures.',
    },
    PointerToPointerStep.syntaxDeclaration: {
      'title': 'SYNTAX OF POINTER TO POINTER DECLARATION',
      'content': 'Example declaration:\n\nint **pptr; // pptr points to a pointer to int',
      'code': 'int **pptr;',
    },
    PointerToPointerStep.assigningAccess: {
      'title': 'ASSIGNING AND ACCESSING POINTER TO POINTER',
      'content':
      'Example creating an int, pointer, and pointer to pointer:\n\nint x = 10;\nint *ptr = &x;\nint **pptr = &ptr;',
      'code': '''int x = 10;
int *ptr = &x;
int **pptr = &ptr;
''',
    },
    PointerToPointerStep.exampleDecl: {
      'title': 'EXAMPLE: VARIABLE, POINTER, AND POINTER TO POINTER',
      'content':
      'Refer to the previous example for declarations and assignments. Understanding this sets foundation for pointer indirection.',
    },
    PointerToPointerStep.dereference: {
      'title': 'DEREFERENCING POINTER TO POINTER',
      'content':
      '*pptr gives the pointer stored in ptr, and **pptr reaches the actual int value pointed to.',
      'code': '''
*pptr == ptr
**pptr == x
''',
    },
    PointerToPointerStep.printfDisplay: {
      'title': 'USING printf TO DISPLAY ADDRESSES AND VALUES',
      'content':
      'Print addresses and values using %p for pointers and %d for integers.',
      'code': '''printf("x = %d\\n", x);
printf("&x = %p\\n", &x);
printf("ptr = %p\\n", ptr);
printf("pptr = %p\\n", pptr);
printf("*pptr = %p\\n", *pptr);
printf("**pptr = %d\\n", **pptr);
''',
    },
    PointerToPointerStep.changeValueDoubleDereference: {
      'title': 'CHANGING VALUE VIA POINTER TO POINTER',
      'content':
      'Double dereferencing allows changing the value pointed to by the original pointer.\n\nExample:\n\n**pptr = 20; // changes x to 20',
      'code': '''**pptr = 20;
// now x is 20
''',
    },
    PointerToPointerStep.changePointerVariable: {
      'title': 'CHANGING POINTER VARIABLE VIA POINTER TO POINTER',
      'content':
      'Modify which variable the pointer points to by changing *pptr.',
      'code': '''int y = 30;
*pptr = &y;
// ptr now points to y
''',
    },
    PointerToPointerStep.passToFunctions: {
      'title': 'PASSING POINTER TO POINTER TO FUNCTIONS',
      'content':
      'Allows functions to modify the pointer itself, e.g. dynamic memory allocation modifying passed pointer.',
      'code': '''void allocate(int **p) {
  *p = malloc(sizeof(int));
}
''',
    },
    PointerToPointerStep.modifyPointerInFunc: {
      'title': 'EXAMPLE: MODIFYING POINTER INSIDE FUNCTION',
      'content':
      'By passing pointer to pointer, functions can change pointer targets safely.',
    },
    PointerToPointerStep.ptrToPtrAndArrays: {
      'title': 'POINTER TO POINTER AND ARRAYS',
      'content':
      'Double pointers can represent arrays of pointers or dynamic 2D array structures.',
    },
    PointerToPointerStep.iterateArrayPtrs: {
      'title': 'ITERATING OVER ARRAY OF POINTERS',
      'content':
      'Use pointer to pointer to iterate pointer arrays using pointer arithmetic.',
      'code': '''int *arr[3];
int **pp = arr;
for (int i = 0; i < 3; i++) {
  printf("%p\\n", *(pp + i));
}
''',
    },
    PointerToPointerStep.multilevelIndirection: {
      'title': 'MULTILEVEL INDIRECTION',
      'content':
      'Triple pointers (***ppptr) and beyond add even deeper levels of indirection for complex cases.',
    },
    PointerToPointerStep.swapPointers: {
      'title': 'EXAMPLE: SWAP POINTERS USING POINTER TO POINTER',
      'content': 'Swap two pointers via their addresses.',
      'code': '''void swap(int **a, int **b) {
  int *temp = *a;
  *a = *b;
  *b = temp;
}
''',
    },
    PointerToPointerStep.commonMistake: {
      'title': 'COMMON MISTAKE: NOT PASSING & FOR POINTER TO POINTER',
      'content':
      'Always pass the reference (&ptr) of the pointer if function expects a pointer to pointer.',
      'annotation': 'Incorrect usage leads to unexpected behavior or crashes.',
    },
    PointerToPointerStep.nullPointerChecks: {
      'title': 'NULL POINTER CHECKS AT MULTIPLE LEVELS',
      'content':
      'Validate pointers at every indirection level before dereferencing to avoid segmentation faults.',
    },
    PointerToPointerStep.memoryManagement: {
      'title': 'MEMORY MANAGEMENT',
      'content':
      'Properly free dynamically allocated memory and update pointers through pointer to pointer to keep integrity.',
      'annotation': 'Memory leaks can occur if pointers are overwritten without freeing.',
    },
    PointerToPointerStep.quizExample: {
      'title': 'QUIZ: PREDICT VALUES AFTER POINTER TO POINTER OPERATIONS',
      'content':
      'Consider below code. Predict output of printf for x, *ptr, **pptr.',
      'code': '''int x = 5;
int y = 10;
int *ptr = &x;
int **pptr = &ptr;
**pptr = 20;
*pptr = &y;
printf("%d %d %d", x, *ptr, **pptr);
''',
    },
    PointerToPointerStep.summary: {
      'title': 'SUMMARY AND RECAP',
      'content':
      'Pointer to pointer adds another indirection level. Essential for dynamic memory, pointer-modifying functions, and complex data structures.',
    },
  };

  Widget _extraExplanation(BuildContext context, PointerToPointerStep step) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (step) {
      case PointerToPointerStep.recapPointer:
        return Text(
          "Pointers are a core feature of C, enabling indirect memory access and manipulation. "
              "Understanding pointers well is crucial before diving into pointer to pointer concepts.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case PointerToPointerStep.introPointerToPointer:
        return Text(
          "Pointer to pointer is a pointer holding the address of another pointer. "
              "This layering enables manipulation of pointers themselves, which is key in advanced programming such as dynamic memory or multi-dimensional arrays.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case PointerToPointerStep.changeValueDoubleDereference:
        return Text(
          "Using **pptr lets you directly access and modify the original variable’s value through two indirection levels.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case PointerToPointerStep.changePointerVariable:
        return Text(
          "Changing *pptr modifies the pointer it points to, effectively changing where that pointer points.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case PointerToPointerStep.passToFunctions:
        return Text(
          "Passing a pointer to pointer lets a function change the original pointer’s value, for example dynamically allocating memory inside the function.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case PointerToPointerStep.iterateArrayPtrs:
        return Text(
          "Pointer arithmetic on pointers to pointers lets you traverse arrays of pointers, enabling dynamic and flexible data handling.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case PointerToPointerStep.swapPointers:
        return Text(
          "Swapping pointers via pointer to pointer parameters allows exchanging pointer values outside the calling context.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case PointerToPointerStep.quizExample:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Explanation: The code first sets **pptr = 20 altering x’s value, then *pptr changes ptr to point to y. "
                  "The print outputs x=20, *ptr=10 (ptr now points to y), and **pptr=10.",
              style: TextStyle(fontSize: 14, height: 1.4, color: _textColor(context)),
            ),
            const SizedBox(height: 12),
            Text("Choose your answer:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly
                      ? null
                      : () {
                    setState(() {
                      _quizFeedback = "Correct! Output: 20 10 10";
                      _quizAnsweredCorrectly = true;
                    });
                  },
                  child: const Text("20 10 10"),
                ),
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly
                      ? null
                      : () {
                    setState(() {
                      _quizFeedback = "Incorrect. Review pointer assignments carefully.";
                    });
                  },
                  child: const Text("5 20 10"),
                ),
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly
                      ? null
                      : () {
                    setState(() {
                      _quizFeedback = "Incorrect. Check double dereferencing effects.";
                    });
                  },
                  child: const Text("20 5 10"),
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
    final data = _stepsData[_step]!;

    final explanation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(data['content'], style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context))),
        const SizedBox(height: 16),
        _extraExplanation(context, _step),
        if (data['annotation'] != null) _annotationBox(context, data['annotation']),
      ],
    );

    final code = data['code'];
    final codeWidget = code == null
        ? const SizedBox.shrink()
        : Container(
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

    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 700;

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

  Widget _pointerToPointerFlowChart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final txtClr = _flowChartTextColor(context);
    final boxClr = _flowChartBoxColor(context);
    final brdClr = _flowChartBorderColor(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: boxClr,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: brdClr, width: 1.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pointer to Pointer Concept Flowchart',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: txtClr),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 14,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _flowChartBox('Variable x declared', txtClr, boxClr, brdClr),
              _flowChartArrow(txtClr),
              _flowChartBox('Pointer ptr holds address of x', txtClr, boxClr, brdClr),
              _flowChartArrow(txtClr),
              _flowChartBox('Pointer to pointer pptr holds address of ptr', txtClr, boxClr, brdClr),
              _flowChartArrow(txtClr),
              _flowChartBox('Dereferencing pptr twice accesses value of x', txtClr, boxClr, brdClr),
            ],
          )
        ],
      ),
    );
  }

  Widget _flowChartBox(String text, Color textColor, Color bgColor, Color borderColor) => Container(
    width: 160,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: borderColor, width: 1.3),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 13),
    ),
  );

  Widget _flowChartArrow(Color color) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Icon(Icons.arrow_forward, color: color, size: 26),
  );

  Widget _buildFlowChart(BuildContext context) {
    // Always show the pointer-to-pointer flowchart only on intro step (recapPointer) for focus
    if (_step == PointerToPointerStep.recapPointer || _step == PointerToPointerStep.introPointerToPointer) {
      return _pointerToPointerFlowChart(context);
    }

    // For other steps, show a horizontal scrollable flowchart bar with all steps names, highlight current
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
          children: PointerToPointerStep.values.map((step) {
            final active = step == _step;
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

  Widget _buildNavigationButtons() {
    final isFirst = _step.index == 0;
    final isLast = _step.index == PointerToPointerStep.values.length - 1;
    final bgColor = _buttonBgColor(context);
    final fgColor = _buttonFgColor(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.arrow_back),
          label: const Text('Previous'),
          onPressed: isFirst ? null : _previousStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: isFirst ? bgColor.withOpacity(0.5) : bgColor,
            foregroundColor: fgColor,
          ),
        ),
        if (!isLast)
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Next'),
            onPressed: _nextStep,
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              foregroundColor: fgColor,
            ),
          ),
        if (isLast)
          ElevatedButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Finish'),
            onPressed: () => Navigator.of(context).pop(),
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
          'Pointer to Pointer in C',
          style: TextStyle(color: isDark ? Colors.greenAccent : Colors.teal[900]),
        ),
        backgroundColor: isDark ? Colors.black87 : Colors.teal.shade100,
        iconTheme: IconThemeData(color: isDark ? Colors.greenAccent : Colors.teal[900]),
        centerTitle: true,
      ),
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 32, vertical: 16),
          child: Column(
            children: [
              // Persistent flowchart or special first step flowchart
              _buildFlowChart(context),
              const SizedBox(height: 12),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
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
