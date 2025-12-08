import 'package:flutter/material.dart';

enum ArraysToFunctionsStep {
  intro,
  howPassed,
  paramSyntax,
  exampleDeclaration,
  exampleCall,
  iterateElements,
  modifyElements,
  exampleIncrement,
  passSize,
  sumElements,
  pointerEquiv,
  multiDimArrays,
  example2DParam,
  commonMistake,
  passConst,
  exampleConst,
  pointerVsIndex,
  dynamicArrays,
  returnArray,
  quiz,
  summary,
}

class ArraysToFunctionsPage extends StatefulWidget {
  const ArraysToFunctionsPage({Key? key}) : super(key: key);

  @override
  State<ArraysToFunctionsPage> createState() => _ArraysToFunctionsPageState();
}

class _ArraysToFunctionsPageState extends State<ArraysToFunctionsPage>
    with SingleTickerProviderStateMixin {
  ArraysToFunctionsStep _step = ArraysToFunctionsStep.intro;

  // Animation controller and animations for slide + fade effect
  late AnimationController _animController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // Quiz related state
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
    // Start animation initially
    _animController.forward();
  }

  void _setupAnimations({bool forward = true}) {
    // slide from right if forward else from left
    final beginOffset = forward ? const Offset(1, 0) : const Offset(-1, 0);
    _slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  void _gotoStep(ArraysToFunctionsStep newStep, {bool forward = true}) async {
    // Animate slide/fade out old content, then update state, then animate in new content
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
    if (_step.index < ArraysToFunctionsStep.values.length - 1) {
      _gotoStep(ArraysToFunctionsStep.values[_step.index + 1], forward: true);
    }
  }

  void _previousStep() {
    if (_step.index > 0) {
      _gotoStep(ArraysToFunctionsStep.values[_step.index - 1], forward: false);
    }
  }

  Color _textColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black87;

  Color _annotationBgColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.green.withOpacity(0.15)
          : Colors.green.shade100;

  Color _annotationTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.greenAccent.shade100
          : Colors.green.shade900;

  Color _flowChartTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.lightGreenAccent.shade100
          : Colors.teal.shade900;

  Color _flowChartBoxColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.teal.shade800.withOpacity(0.5)
          : Colors.teal.shade50;

  Color _flowChartBorderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.greenAccent.withOpacity(0.8)
          : Colors.green.shade300;

  Color _buttonBgColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.teal[700]! : Colors.teal.shade300;

  Color _buttonFgColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent : Colors.teal.shade900;

  // Used for flowchart active and inactive steps
  TextStyle _flowChartTextStyle(BuildContext context, bool active) => TextStyle(
    fontWeight: active ? FontWeight.bold : FontWeight.normal,
    color: active
        ? (Theme.of(context).brightness == Brightness.dark
        ? Colors.amberAccent.shade200
        : Colors.teal.shade900)
        : _flowChartTextColor(context).withOpacity(0.7),
    fontSize: 12,
  );

  BoxDecoration _flowChartBoxDecoration(BuildContext context, bool active) =>
      BoxDecoration(
        color: active
            ? (Theme.of(context).brightness == Brightness.dark
            ? Colors.amber.withOpacity(0.3)
            : Colors.teal.shade100)
            : _flowChartBoxColor(context),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: active
                ? (Theme.of(context).brightness == Brightness.dark
                ? Colors.amberAccent.shade200
                : Colors.teal.shade400)
                : _flowChartBorderColor(context),
            width: active ? 2 : 1),
        boxShadow: active
            ? [
          BoxShadow(
            color: (Theme.of(context).brightness == Brightness.dark
                ? Colors.amberAccent.shade100
                : Colors.teal.shade200)
                .withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ]
            : [],
      );

  // Data for all steps: title, explanation content, code snippet, annotation (optional)
  // For the quiz step we implement interaction separately
  static const Map<ArraysToFunctionsStep, Map<String, dynamic>> _stepsData = {
    ArraysToFunctionsStep.intro: {
      'title': 'INTRODUCTION: WHY PASS ARRAYS TO FUNCTIONS?',
      'content':
      'Passing arrays to functions enables modularity and code reuse. Arrays represent collections of items, allowing functions to operate on groups of data efficiently.',
      'code': null,
      'annotation': null,
    },
    ArraysToFunctionsStep.howPassed: {
      'title': 'HOW ARRAYS ARE PASSED TO FUNCTIONS IN C',
      'content':
      'Arrays are passed as pointers — the function actually receives the address of the first element, not a full copy of the array.',
      'code': null,
      'annotation': null,
    },
    ArraysToFunctionsStep.paramSyntax: {
      'title': 'FUNCTION PARAMETER SYNTAX FOR ARRAYS',
      'content':
      'You can declare parameters as array (void func(int arr[])) or pointer (void func(int *arr)); both are equivalent in function parameters.',
      'code': null,
      'annotation': null,
    },
    ArraysToFunctionsStep.exampleDeclaration: {
      'title': 'EXAMPLE FUNCTION DECLARATION ACCEPTING AN ARRAY',
      'content':
      'Here is a function declaration that accepts an array and its size:',
      'code': 'void printArray(int arr[], int size);',
      'annotation': null,
    },
    ArraysToFunctionsStep.exampleCall: {
      'title': 'CALLING THE FUNCTION WITH AN ARRAY ARGUMENT',
      'content': 'Example call passing an array and size:',
      'code': '''int myArray[5] = {1, 2, 3, 4, 5};
printArray(myArray, 5);''',
      'annotation': null,
    },
    ArraysToFunctionsStep.iterateElements: {
      'title': 'ITERATING INSIDE THE FUNCTION OVER THE ARRAY ELEMENTS',
      'content': 'Use a for loop to access and process each element in the array.',
      'code': '''void printArray(int arr[], int size) {
  for (int i = 0; i < size; i++) {
    printf("%d ", arr[i]);
  }
}''',
      'annotation': null,
    },
    ArraysToFunctionsStep.modifyElements: {
      'title': 'MODIFYING ARRAY ELEMENTS INSIDE THE FUNCTION',
      'content':
      'Since the array is passed by reference (pointer), modifying elements affects the original array outside the function.',
      'code': '''void incrementArray(int arr[], int size) {
  for (int i = 0; i < size; i++) {
    arr[i] += 1;
  }
}''',
      'annotation': null,
    },
    ArraysToFunctionsStep.exampleIncrement: {
      'title': 'EXAMPLE: INCREMENT ALL ARRAY ELEMENTS BY 1 INSIDE A FUNCTION',
      'content': 'A simple function that adds 1 to all elements in the passed array.',
      'code': '''void incrementArray(int arr[], int size) {
  for (int i = 0; i < size; i++) {
    arr[i] = arr[i] + 1;
  }
}''',
      'annotation': null,
    },
    ArraysToFunctionsStep.passSize: {
      'title': 'IMPORTANCE OF PASSING ARRAY SIZE SEPARATELY',
      'content':
      'C does not track array sizes when passed to functions, so the size must be passed explicitly to avoid undefined behavior.',
      'code': null,
      'annotation':
      'Always ensure to pass correct array size; misuse can cause out-of-bounds access and bugs.',
    },
    ArraysToFunctionsStep.sumElements: {
      'title': 'EXAMPLE: SUM ELEMENTS IN FUNCTION',
      'content':
      'Function can compute and return the sum of all elements in the passed array.',
      'code': '''int sumArray(int arr[], int size) {
  int sum = 0;
  for (int i = 0; i < size; i++) {
    sum += arr[i];
  }
  return sum;
}''',
      'annotation': null,
    },
    ArraysToFunctionsStep.pointerEquiv: {
      'title': 'ARRAYS AND POINTERS - CLARIFY EQUIVALENCE',
      'content':
      'When used as function parameters, array notation (arr[]) and pointer notation (int *arr) behave identically.',
      'code': null,
      'annotation': null,
    },
    ArraysToFunctionsStep.multiDimArrays: {
      'title': 'MULTIDIMENSIONAL ARRAYS AS FUNCTION PARAMETERS (BRIEF INTRO)',
      'content':
      'You can pass 2D arrays to functions, but the number of columns must be specified.',
      'code': null,
      'annotation': null,
    },
    ArraysToFunctionsStep.example2DParam: {
      'title': 'EXAMPLE: FUNCTION ACCEPTING 2D ARRAY WITH FIXED COLUMN SIZE',
      'content': 'Example declaration:',
      'code': 'void print2DArray(int arr[][4], int rows);',
      'annotation': null,
    },
    ArraysToFunctionsStep.commonMistake: {
      'title': 'COMMON MISTAKE: OMITTING SIZE LEADS TO UNDEFINED BEHAVIOR',
      'content':
      'Not passing size or passing incorrect sizes can cause incorrect processing and crashes.',
      'code': null,
      'annotation': null,
    },
    ArraysToFunctionsStep.passConst: {
      'title': 'PASSING CONSTANT ARRAYS (USING CONST MODIFIER)',
      'content':
      'Declaring the array parameter as const ensures the function does not modify the array.',
      'code': 'void printArray(const int arr[], int size);',
      'annotation': null,
    },
    ArraysToFunctionsStep.exampleConst: {
      'title': 'EXAMPLE: READ-ONLY ARRAY PARAMETER USING CONST',
      'content':
      'A function can safely read data from the array without modifying it when declared const.',
      'code': '''void printArray(const int arr[], int size) {
  // Read only access
}''',
      'annotation': null,
    },
    ArraysToFunctionsStep.pointerVsIndex: {
      'title': 'POINTER ARITHMETIC VS ARRAY INDEXING IN FUNCTION',
      'content':
      'You can use pointer arithmetic (e.g., *(arr + i)) instead of arr[i] for accessing array elements.',
      'code': '''void printArray(int *arr, int size) {
  for (int i = 0; i < size; i++) {
    printf("%d ", *(arr + i));
  }
}''',
      'annotation': null,
    },
    ArraysToFunctionsStep.dynamicArrays: {
      'title': 'DYNAMIC ARRAYS AND PASSING TO FUNCTIONS',
      'content':
      'Even dynamically allocated arrays are passed as pointers to functions similarly to static arrays.',
      'code': null,
      'annotation': null,
    },
    ArraysToFunctionsStep.returnArray: {
      'title': 'RETURNING AN ARRAY FROM A FUNCTION (BRIEF CAUTION)',
      'content':
      'Functions cannot return arrays directly; instead, they return pointers or use out parameters to pass arrays.',
      'code': null,
      'annotation': null,
    },
    ArraysToFunctionsStep.quiz: {
      'title': 'QUIZ: PREDICT OUTPUT WHEN MODIFYING ARRAY INSIDE FUNCTION',
      'content':
      'What will be the output of this code snippet? Explain the effect of modifying array elements inside the called function.',
      'code': '''void func(int arr[], int size) {
  for (int i = 0; i < size; i++) {
    arr[i] += 2;
  }
}

int main() {
  int a[3] = {1, 2, 3};
  func(a, 3);
  for (int i=0; i<3; i++) printf("%d ", a[i]);
  return 0;
}
// Output?''',
      'annotation': null,
    },
    ArraysToFunctionsStep.summary: {
      'title': 'SUMMARY & BEST PRACTICES',
      'content':
      'Arrays are passed to functions as pointers to the first element. Always pass array sizes to keep functions safe and robust. Use const modifier for read-only parameters and be cautious when modifying arrays inside functions.',
      'code': null,
      'annotation': null,
    },
  };

  // Contents that require more explanation or multiple examples - we can add in _extraExplanation method
  Widget _extraExplanation(BuildContext context, ArraysToFunctionsStep step) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (step) {
      case ArraysToFunctionsStep.intro:
        return Text(
          "Passing arrays to functions lets you write modular, reusable code that can handle collections efficiently. "
              "Instead of writing repetitive code for each element, you pass the whole array to a function that operates on it.\n\n"
              "This approach increases maintainability and makes your programs cleaner. Functions can work on various arrays by just changing arguments.",
          style: TextStyle(
            fontSize: 14,
            height: 1.4,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        );
      case ArraysToFunctionsStep.exampleDeclaration:
        return Text(
          "Passing the size of the array alongside the array pointer is essential because C does not automatically provide the array length. "
              "Always define the size parameter as an int to indicate how many elements the function can safely access.\n\n"
              "This pattern is very common and you'll see it in many C standard library functions.",
          style: TextStyle(
            fontSize: 14,
            height: 1.4,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        );
      case ArraysToFunctionsStep.quiz:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Think carefully: The function adds 2 to each element. Since arrays are passed by pointer, changes affect the original array which is printed afterwards.",
              style: TextStyle(fontSize: 14, height: 1.4, color: _textColor(context)),
            ),
            const SizedBox(height: 12),
            Text(
              "Select your answer:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly
                      ? null
                      : () {
                    setState(() {
                      _quizFeedback = "Correct! Each element is incremented by 2, so the output is: 3 4 5";
                      _quizAnsweredCorrectly = true;
                    });
                  },
                  child: const Text("3 4 5"),
                ),
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly
                      ? null
                      : () {
                    setState(() {
                      _quizFeedback = "Incorrect. Try again!";
                    });
                  },
                  child: const Text("1 2 3"),
                ),
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly
                      ? null
                      : () {
                    setState(() {
                      _quizFeedback = "Incorrect. Changes do affect the original array.";
                    });
                  },
                  child: const Text("Undefined behavior"),
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

  // Widget to build explanation + code side-by-side or stacked depending on screen width
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
        if (stepData['annotation'] != null) _annotationBox(context, stepData['annotation']),
      ],
    );

    final code = stepData['code'];
    Widget codeWidget;
    if (code != null) {
      codeWidget = Container(
        constraints: const BoxConstraints(
          minWidth: 200,
          maxWidth: 600,
        ),
        decoration: BoxDecoration(
          color:
          Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color:
              Theme.of(context).brightness == Brightness.dark ? Colors.green.shade700 : Colors.grey.shade400),
        ),
        padding: const EdgeInsets.all(12),
        child: SelectableText(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14,
            height: 1.3,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.lightGreenAccent.shade100
                : Colors.green.shade900,
          ),
        ),
      );
    } else {
      // No code content
      codeWidget = const SizedBox.shrink();
    }

    final isWide = MediaQuery.of(context).size.width >= 700;

    // Layout side by side or stacked based on width
    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Explanation takes 60%
          Expanded(flex: 6, child: explanationWidget),
          const SizedBox(width: 24),
          // Code takes 40%
          Expanded(flex: 4, child: codeWidget),
        ],
      );
    } else {
      // Stacked vertically on narrow/mobile
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

  // Flowchart bar widget: horizontally scrollable with all steps names
  Widget _buildFlowChart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    String spacedUpperCase(String input) {
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
          children: ArraysToFunctionsStep.values.map((step) {
            final active = step == _step;
            final stepName = spacedUpperCase(step.name);
            return
              Padding(
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration:
                  _flowChartBoxDecoration(context, active),
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

  // Navigation buttons row: Previous, Next and Finish on last step
  Widget _buildNavigationButtons(BuildContext context) {
    final isFirst = _step.index == 0;
    final isLast = _step.index == ArraysToFunctionsStep.values.length - 1;
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
          'Arrays to Functions in C',
          style: TextStyle(
            color: isDark ? Colors.greenAccent : Colors.teal[900],
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: 22,
          ),
        ),
        backgroundColor: isDark ? Colors.black87 : Colors.teal.shade100,
        centerTitle: true,
        iconTheme:
        IconThemeData(color: isDark ? Colors.greenAccent : Colors.teal[900]),
      ),
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Flowchart persistent at top
            _buildFlowChart(context),

            // Content area with animation
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Step title uppercase large
                          Text(
                            _stepsData[_step]!['title'],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color:
                              isDark ? Colors.greenAccent.shade100 : Colors.teal[900],
                              letterSpacing: 1.5,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 24),

                          _buildStepContent(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Navigation buttons
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: _buildNavigationButtons(context),
            ),
          ],
        ),
      ),
    );
  }
}
