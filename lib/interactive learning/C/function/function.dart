import 'package:flutter/material.dart';

enum CFunctionStep {
  intro,
  syntaxBasics,
  exampleAdd,
  parametersArguments,
  returnValues,
  callByValue,
  callByValueExample,
  animationValueCopy,
  whyCallByValueSafe,
  commonUsesCallByValue,
  callByReference,
  pointerParams,
  incrementReference,
  animationPassingAddress,
  syntaxRefOperators,
  risksCallByReference,
  whenToUseCallByReference,
  swapCallByValueFails,
  swapCallByReferenceWorks,
  summaryTable,
  quiz,
}

class CFunctionsPage extends StatefulWidget {
  @override
  State<CFunctionsPage> createState() => _CFunctionsPageState();
}

class _CFunctionsPageState extends State<CFunctionsPage> with TickerProviderStateMixin {
  int _currentStepIndex = 0;
  final List<CFunctionStep> _steps = CFunctionStep.values;

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int? _selectedQuizChoice;
  String? _quizFeedback;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(duration: const Duration(milliseconds: 450), vsync: this);
    _fadeAnimation = CurvedAnimation(parent: _animController, curve: Curves.easeInOutCubic);
    _slideAnimation = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(_fadeAnimation);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  CFunctionStep get _currentStep => _steps[_currentStepIndex];

  Future<void> _goToStep(int index) async {
    if (index < 0 || index >= _steps.length) return;
    await _animController.reverse();
    setState(() {
      _currentStepIndex = index;
      _selectedQuizChoice = null;
      _quizFeedback = null;
    });
    _animController.forward();
  }

  void _nextStep() {
    if (_currentStepIndex < _steps.length - 1) _goToStep(_currentStepIndex + 1);
  }

  void _previousStep() {
    if (_currentStepIndex > 0) _goToStep(_currentStepIndex - 1);
  }

  // Titles uppercase and descriptive
  String _stepTitle(CFunctionStep step) {
    switch (step) {
      case CFunctionStep.intro:
        return 'INTRODUCTION TO FUNCTIONS IN C';
      case CFunctionStep.syntaxBasics:
        return 'FUNCTION SYNTAX BASICS';
      case CFunctionStep.exampleAdd:
        return 'EXAMPLE: SIMPLE ADD FUNCTION';
      case CFunctionStep.parametersArguments:
        return 'FUNCTION PARAMETERS & ARGUMENTS';
      case CFunctionStep.returnValues:
        return 'RETURN VALUES IN FUNCTIONS';
      case CFunctionStep.callByValue:
        return 'WHAT IS CALL BY VALUE?';
      case CFunctionStep.callByValueExample:
        return 'EXAMPLE: CALL BY VALUE MODIFICATION';
      case CFunctionStep.animationValueCopy:
        return 'ANIMATION: VALUE COPY IN MEMORY';
      case CFunctionStep.whyCallByValueSafe:
        return 'WHY CALL BY VALUE IS SAFE BUT LIMITED';
      case CFunctionStep.commonUsesCallByValue:
        return 'COMMON USES OF CALL BY VALUE';
      case CFunctionStep.callByReference:
        return 'WHAT IS CALL BY REFERENCE?';
      case CFunctionStep.pointerParams:
        return 'POINTERS IN FUNCTION PARAMETERS';
      case CFunctionStep.incrementReference:
        return 'EXAMPLE: INCREMENT USING CALL BY REFERENCE';
      case CFunctionStep.animationPassingAddress:
        return 'ANIMATION: PASSING ADDRESS AND MEMORY ACCESS';
      case CFunctionStep.syntaxRefOperators:
        return 'SYNTAX: USING & AND * IN CALL BY REFERENCE';
      case CFunctionStep.risksCallByReference:
        return 'RISKS OF CALL BY REFERENCE';
      case CFunctionStep.whenToUseCallByReference:
        return 'WHEN TO USE CALL BY REFERENCE';
      case CFunctionStep.swapCallByValueFails:
        return 'EXAMPLE: SWAP USING CALL BY VALUE (FAILS)';
      case CFunctionStep.swapCallByReferenceWorks:
        return 'EXAMPLE: SWAP USING CALL BY REFERENCE (WORKS)';
      case CFunctionStep.summaryTable:
        return 'SUMMARY TABLE: CALL BY VALUE VS CALL BY REFERENCE';
      case CFunctionStep.quiz:
        return 'QUIZ: TEST YOUR KNOWLEDGE';
    }
  }

  // Extended explanations + multiple examples
  String _infoTextForStep(CFunctionStep step) {
    switch (step) {
      case CFunctionStep.intro:
        return '''
Functions are fundamental building blocks in C programming. They allow you to modularize your code by grouping related instructions into reusable parts called functions.

This modularity reduces code repetition, improves readability, and eases debugging and maintenance.

Functions have declarations (or prototypes), which describe their interface, and definitions, which provide the actual code.

Calling a function executes its code with specific input parameters, possibly returning results.
''';
      case CFunctionStep.syntaxBasics:
        return '''
The basic syntax of a C function includes the return type, function name, parameter list, and body.

Example:

int add(int a, int b); // Declaration

int add(int a, int b) {  // Definition
  return a + b;
}

Functions must be declared before use or defined before use.
''';
      case CFunctionStep.exampleAdd:
        return '''
A simple function `add` takes two integers and returns their sum.

int add(int a, int b) {
  return a + b;
}

Use it like: `int result = add(3, 5);` which results in `result` being 8.
''';
      case CFunctionStep.parametersArguments:
        return '''
Parameters are variables listed in a function's definition that receive values when the function is called. Arguments are the actual values passed to the function.

Example:

void greet(char *name) {
  printf("Hello, %s!\\n", name);
}

Call it with: greet("Alice"); — where `"Alice"` is the argument passed to parameter `name`.
''';
      case CFunctionStep.returnValues:
        return '''
Functions can return values to the caller using the `return` statement with a specific return type.

For example:

int square(int x) {
  return x * x;
}

void printHello() {
  printf("Hello");
  // returns void — no return value
}
''';
      case CFunctionStep.callByValue:
        return '''
In call by value, arguments are passed to functions as copies. This means the function receives its own copy of the data to work with.

Any changes made to parameters inside the function do NOT affect the original arguments outside.

Example use: simple input parameters where no modification is intended.
''';
      case CFunctionStep.callByValueExample:
        return '''
Example:

void modify(int a) {
  a = 10; // modifies only local copy
}

int main() {
  int x = 5;
  modify(x);
  printf("%d", x); // prints 5, not 10
}
''';
      case CFunctionStep.animationValueCopy:
        return '''
Imagine a variable's value is copied into the function's local memory space. The original variable outside remains untouched.

This protects your data from unintended side effects from the function.
''';
      case CFunctionStep.whyCallByValueSafe:
        return 'Because the function works on copies, the caller\'s original variables are safe from unintended modification. This also simplifies reasoning about your code.';
      case CFunctionStep.commonUsesCallByValue:
        return 'Call by value is ideal for passing simple atomic data types like int, float, char, or structs when you want to avoid side effects during function calls.';
      case CFunctionStep.callByReference:
        return '''
Call by reference passes the memory address of variables to a function instead of copies.

This allows the function to directly access and modify the original variable's content.

It's done through pointers in C.
''';
      case CFunctionStep.pointerParams:
        return '''
Example of a function taking pointer parameters:

void increment(int *p) {
  (*p)++;  // dereference pointer and increment
}

Call: 
int x = 5;
increment(&x);
// x is now 6
''';
      case CFunctionStep.incrementReference:
        return '''
Using call by reference is efficient for modifying variables in place, especially for large data structures.

This avoids copying entire objects and allows multiple return values through pointer parameters.
''';
      case CFunctionStep.animationPassingAddress:
        return 'Visualize that instead of copying the variable\'s value, the function receives its address (like a pointer pointing to the variable\'s memory). It accesses the variable\'s data directly at this address.';
      case CFunctionStep.syntaxRefOperators:
        return '''
In C:

- `&` operator gets the address of a variable.
- `*` operator accesses the value stored at the address (dereferencing).

Example:

void func(int *p) { *p = 10; }

int x;

func(&x);  // x becomes 10
''';
      case CFunctionStep.risksCallByReference:
        return '''
While powerful, call by reference risks include:

- Dangling pointers (pointing to invalid memory).
- Uninitialized pointers causing undefined behavior.
- Potential security issues due to direct memory access.

Always ensure pointers are valid and initialized before use.
''';
      case CFunctionStep.whenToUseCallByReference:
        return 'Use call by reference when you need functions to modify the caller\'s variables, return multiple values, or avoid costly copies for large data structures.';
      case CFunctionStep.swapCallByValueFails:
        return '''
A swap function passing variables by value won\'t swap originals because copies are swapped locally.

void swap(int a, int b) {
  int temp = a; 
  a = b; 
  b = temp; 
}
// This does NOT swap caller variables.
''';
      case CFunctionStep.swapCallByReferenceWorks:
        return '''
Passing addresses allows swap to work properly:

void swap(int *a, int *b) {
  int temp = *a; 
  *a = *b; 
  *b = temp; 
}

int x = 3, y = 5;
swap(&x, &y);
// x is 5, y is 3
''';
      case CFunctionStep.summaryTable:
        return '''
| Aspect           | Call by Value             | Call by Reference         |
|------------------|--------------------------|--------------------------|
| Data Passed      | Copies of values         | Addresses (pointers)       |
| Effect on Caller | No changes              | Changes original vars      |
| Syntax          | `func(type param)`        | `func(type *param)`        |
| Use Cases        | Simple inputs             | Modify multiple/large data |
| Safety          | Safer, no side effects    | Risk of pointer misuse     |
''';
      case CFunctionStep.quiz:
        return 'Quiz yourself! Select the correct answer for the following C function code behavior.';

      default:
        return '';
    }
  }

  // Progressive evolving code snippets for step by step incremental teaching
  String _codeForStep(CFunctionStep step) {
    switch (step) {
      case CFunctionStep.syntaxBasics:
        return '''
// Declaration (prototype)
int add(int a, int b);

// Definition
int add(int a, int b) {
  return a + b;
}

// Usage
int result = add(3, 5);
''';
      case CFunctionStep.exampleAdd:
        return '''
int add(int a, int b) {
  return a + b;
}
''';
      case CFunctionStep.returnValues:
        return '''
int add(int a, int b) {
  return a + b;
}

void printHello() {
  printf("Hello");
}
''';
      case CFunctionStep.callByValueExample:
        return '''
void modify(int a) {
  a = 10; // only modifies local copy
}
''';
      case CFunctionStep.pointerParams:
        return '''
void increment(int *p) {
  (*p)++;
}
''';
      case CFunctionStep.incrementReference:
        return '''
int x = 5;
increment(&x);
// x is now 6
''';
      case CFunctionStep.syntaxRefOperators:
        return '''
void func(int *p) {
  *p = 10;
}

int x;

func(&x); // x becomes 10
''';
      case CFunctionStep.swapCallByValueFails:
        return '''
void swap(int a, int b) {
  int temp = a;
  a = b;
  b = temp;
}
// Swapping failed since args are copies
''';
      case CFunctionStep.swapCallByReferenceWorks:
        return '''
void swap(int *a, int *b) {
  int temp = *a;
  *a = *b;
  *b = temp;
}
// Successful swap of original variables
''';
      case CFunctionStep.summaryTable:
        return '''
| Aspect           | Call by Value             | Call by Reference         |
|------------------|--------------------------|--------------------------|
| Data Passed      | Copies of values         | Addresses (pointers)       |
| Effect on Caller | No changes              | Changes original vars      |
| Syntax          | `func(type param)`        | `func(type *param)`        |
| Use Cases        | Simple inputs             | Modify multiple/large data |
| Safety          | Safer, no side effects    | Risk of pointer misuse     |
''';
      default:
        return '';
    }
  }

  // Horizontal scrollable flowchart with responsive boxes and dark mode friendly colors
  Widget _buildStepFlowchart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark ? Colors.lightGreenAccent.shade200 : Colors.teal[900]!;

    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: List.generate(_steps.length * 2 -1, (i) {
            if (i.isOdd) return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(Icons.arrow_forward_ios, size: 14, color: isDark ? Colors.lightGreenAccent.shade100 : Colors.teal[700]),
            );
            final idx = i ~/ 2;
            final step = _steps[idx];
            final isActive = step == _currentStep;
            return GestureDetector(
              onTap: () => _goToStep(idx),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                margin: EdgeInsets.symmetric(horizontal: 6, vertical: 7),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isActive ? accentColor : (isDark ? Colors.grey[800] : Colors.grey[300]),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: isActive
                      ? [
                    BoxShadow(
                      color: accentColor.withOpacity(0.6),
                      blurRadius: 12,
                      offset: Offset(0, 3),
                    )
                  ]
                      : null,
                ),
                child: Text(
                  _stepTitle(step),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: isActive ? Colors.black : (isDark ? Colors.lightGreenAccent.shade100 : Colors.black87),
                    letterSpacing: 0.7,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // Text + code visible side by side or stacked (responsive)
  Widget _buildStepContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final step = _currentStep;
    final content = _infoTextForStep(step);
    final code = _codeForStep(step);

    final explanationWidget = Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark ? Colors.green.shade900.withOpacity(0.1) : Colors.green.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? Colors.greenAccent.shade100 : Colors.green.shade300),
      ),
      child: SelectableText(
        content,
        style: TextStyle(
          fontSize: 16,
          height: 1.4,
          color: isDark ? Colors.greenAccent.shade100 : Colors.green.shade900,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    final codeWidget = code == null
        ? const SizedBox.shrink()
        : Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121212) : const Color(0xFFF7F9FA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.greenAccent.shade700 : Colors.teal.shade300,
          width: 1.2,
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SelectableText(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14,
            height: 1.3,
            color: isDark ? Colors.greenAccent.shade200 : Colors.green.shade900,
          ),
        ),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 720;
        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: explanationWidget),
              SizedBox(width: 28),
              Expanded(child: codeWidget),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              explanationWidget,
              codeWidget,
            ],
          );
        }
      },
    );
  }

  Widget _buildAnimatedStepContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      transitionBuilder: (child, animation) {
        final inAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation);
        final outAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(-1, 0)).animate(animation);

        return SlideTransition(
          position: child.key == ValueKey(_currentStepIndex) ? inAnimation : outAnimation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: Container(
        key: ValueKey<int>(_currentStepIndex),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: _buildStepContent(context),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    final isFirst = _currentStepIndex == 0;
    final isLast = _currentStepIndex == _steps.length - 1;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor = isDark ? Colors.greenAccent : Colors.teal[900];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: isFirst ? null : _previousStep,
            icon: Icon(Icons.arrow_back, color: isFirst ? Colors.grey : mainColor),
            label: const Text('Back'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 45),
              backgroundColor: isDark ? Colors.teal[800] : Colors.teal[200],
              foregroundColor: mainColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          if (!isLast)
            ElevatedButton.icon(
              onPressed: _nextStep,
              label: const Text('Next'),
              icon: Icon(Icons.arrow_forward, color: mainColor),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(110, 45),
                backgroundColor: isDark ? Colors.teal[900] : Colors.teal[400],
                foregroundColor: mainColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            )
          else
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: Icon(Icons.check_circle_outline, color: Colors.black87),
              label: const Text('Finish'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(110, 45),
                backgroundColor: isDark ? Colors.greenAccent : Colors.teal[700],
                foregroundColor: isDark ? Colors.black : Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }

  // --- Quiz Step ---

  final List<_QuizChoice> _quizChoices = [
    _QuizChoice('In call by value, the function can modify the original variable.', false),
    _QuizChoice('In call by reference, the function receives a pointer to the variable\'s address.', true),
    _QuizChoice('Call by value is used to modify multiple outputs from a function.', false),
    _QuizChoice('& operator is used for dereferencing a pointer inside function.', false),
  ];

  Widget _buildQuiz() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.green.shade900.withOpacity(0.15) : Colors.teal.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? Colors.greenAccent.shade100 : Colors.teal.shade300, width: 1.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUIZ: TEST YOUR KNOWLEDGE',
            style: TextStyle(
              color: Colors.amber.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(_quizChoices.length, (index) {
            final choice = _quizChoices[index];
            final isSelected = _selectedQuizChoice == index;
            Color bgColor;
            Color fgColor;

            if (_quizFeedback != null) {
              if (choice.isCorrect) {
                bgColor = Colors.greenAccent.shade400;
                fgColor = Colors.black;
              } else if (isSelected) {
                bgColor = Colors.redAccent.shade400;
                fgColor = Colors.white;
              } else {
                bgColor = isDark ? Colors.teal[900]! : Colors.teal[50]!;
                fgColor = isDark ? Colors.greenAccent.shade100 : Colors.teal[900]!;
              }
            } else {
              bgColor = isSelected
                  ? (isDark ? Colors.teal[800]! : Colors.teal[200]!)
                  : (isDark ? Colors.teal[900]! : Colors.teal[50]!);
              fgColor = isSelected
                  ? (isDark ? Colors.greenAccent.shade100! : Colors.teal[900]!)
                  : (isDark ? Colors.greenAccent.shade100! : Colors.teal[900]!);
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: _quizFeedback == null
                    ? () => setState(() {
                  _selectedQuizChoice = index;
                  _quizFeedback = choice.isCorrect ? 'Correct! Well done.' : 'Incorrect. Try again.';
                })
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: bgColor,
                  foregroundColor: fgColor,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  elevation: 0,
                ),
                child: Text(choice.text),
              ),
            );
          }),
          if (_quizFeedback != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                _quizFeedback!,
                style: TextStyle(
                    color:
                    _quizFeedback == 'Correct! Well done.' ? Colors.greenAccent : Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }

  // Replace _buildStepContent to integrate quiz step UI
  Widget _buildDetailedStepContent() {
    if (_currentStep == CFunctionStep.quiz) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStepContent(context),
          _buildQuiz(),
          const SizedBox(height: 20),
        ],
      );
    }
    return _buildStepContent(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double horizontalPadding = MediaQuery.of(context).size.width < 600 ? 12.0 : 32.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Functions in C - Interactive',
          style: TextStyle(color: isDark ? Colors.greenAccent : Colors.teal[900]),
        ),
        backgroundColor: isDark ? Colors.black87 : Colors.teal.shade100,
        iconTheme: IconThemeData(color: isDark ? Colors.greenAccent : Colors.teal[900]),
        centerTitle: true,
      ),
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 14.0),
          child: Column(
            children: [
              _buildStepFlowchart(context),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 450),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: Container(
                    key: ValueKey<int>(_currentStepIndex),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 720) {
                          // Wide: show side by side (including quiz if last step)
                          return _buildDetailedStepContent();
                        }
                        // Narrow/mobile: stack vertically
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: _buildDetailedStepContent(),
                        );
                      },
                    ),
                  ),
                ),
              ),
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuizChoice {
  final String text;
  final bool isCorrect;
  _QuizChoice(this.text, this.isCorrect);
}
