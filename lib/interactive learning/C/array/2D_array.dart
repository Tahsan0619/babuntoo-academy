import 'package:flutter/material.dart';

enum TwoDArrayStep {
  intro,
  motivation,
  definition,
  syntax,
  memoryLayout,
  accessingElements,
  initialization,
  partialInit,
  nestedLoops,
  printExample,
  dynamicChange,
  passingArrayToFunc,
  commonErrors,
  memoryCalc,
  sumElements,
  rowSum,
  colSum,
  useCases,
  multidim,
  quiz,
  pitfalls,
  summary,
}

class TwoDArrayPage extends StatefulWidget {
  @override
  _TwoDArrayPageState createState() => _TwoDArrayPageState();
}

class _TwoDArrayPageState extends State<TwoDArrayPage>
    with TickerProviderStateMixin {
  int _currentStepIndex = 0;

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<TwoDArrayStep> _steps = TwoDArrayStep.values;

  String? _quizResult;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation =
        CurvedAnimation(parent: _animController, curve: Curves.easeInOutCubic);

    _slideAnimation =
        Tween<Offset>(begin: Offset(0, 0.15), end: Offset.zero).animate(_fadeAnimation);

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _goToStep(int index) async {
    if (index < 0 || index >= _steps.length) return;

    await _animController.reverse();
    setState(() {
      _currentStepIndex = index;
      _quizResult = null;
    });
    await _animController.forward();
  }

  void _nextStep() {
    if (_currentStepIndex < _steps.length - 1) {
      _goToStep(_currentStepIndex + 1);
    }
  }

  void _previousStep() {
    if (_currentStepIndex > 0) {
      _goToStep(_currentStepIndex - 1);
    }
  }

  TwoDArrayStep get _currentStep => _steps[_currentStepIndex];

  // Explanations with doubled explanation + examples for each step (concise here for brevity)
  String _explanationForStep(TwoDArrayStep step) {
    switch (step) {
      case TwoDArrayStep.intro:
        return '''
A 1D array is a simple collection of elements of the same type stored continuously in memory.
Example:
int arr[5] = {1, 2, 3, 4, 5};
You access elements via zero-based indices, e.g. arr[0] = 1.

However, 1D arrays are not suitable for tabular or matrix data structures.
''';
      case TwoDArrayStep.motivation:
        return '''
Data that naturally fits rows and columns (like grids, game boards, images) requires 2D arrays to represent both dimensions explicitly.

Think of a chessboard or classroom seating chart — 1D arrays can't easily represent these.
''';
      case TwoDArrayStep.definition:
        return '''
A 2D array in C is an array of arrays.
It's declared as arr[rows][cols], indexed by two indices: the row and the column.

Example:
int matrix[2][3];

Think of this as 2 rows, each with 3 columns.
Visualization:
matrix[0][0], matrix[0][1], matrix[0][2]
matrix[1][0], matrix[1][1], matrix[1][2]
''';
      case TwoDArrayStep.syntax:
        return '''
You declare 2D arrays like so:
int matrix[2][3]; // 2 rows, 3 columns
float grid[4][4]; // 4x4 float grid

This syntax creates contiguous memory blocks sized rows × columns.
''';
      case TwoDArrayStep.memoryLayout:
        return '''
C stores 2D arrays in row-major order meaning memory layout is:
matrix[0][0], matrix[0][1], ..., matrix[1][0], matrix[1][1], ...

This behavior is important for understanding memory access and performance.
''';
      case TwoDArrayStep.accessingElements:
        return '''
Access or modify with both indices:
matrix[1][2] = 7; // sets 2nd row, 3rd col element
printf("%d", matrix[1][2]); // prints 7

Remember, indexing is zero-based.
''';
      case TwoDArrayStep.initialization:
        return '''
You can initialize all elements at declaration, or partially (rest are zeroed).

Example full init:
int matrix[2][3] = {
  {1, 2, 3},
  {4, 5, 6}
};

Partial init:
int partial[3][4] = {
  {1, 2},
  {3}
};
// Unspecified elements set to 0 automatically.
''';
      case TwoDArrayStep.partialInit:
        return '''
Partial initialization fills unspecified locations with zeros.

Example:
int arr[3][4] = {
  {1, 2},
  {3}
};

Here, all uninitialized elements become 0.
''';
      case TwoDArrayStep.nestedLoops:
        return '''
Nested loops lets you traverse every element:

for (int i = 0; i < rows; i++) {
  for (int j = 0; j < cols; j++) {
    // Use arr[i][j]
  }
}

It's the standard way to scan 2D arrays completely.
''';
      case TwoDArrayStep.printExample:
        return '''
Example: print all elements:

for (int i = 0; i < 2; i++) {
  for (int j = 0; j < 3; j++) {
    printf("%d ", matrix[i][j]);
  }
  printf("\\n");
}

// Output:
// 1 2 3
// 4 5 6
''';
      case TwoDArrayStep.dynamicChange:
        return '''
You can change elements dynamically by indices:

matrix[0][2] = 99;
matrix[1][1] = matrix[0][0] + 1;

This is useful for algorithms needing in-place updates.
''';
      case TwoDArrayStep.passingArrayToFunc:
        return '''
When passing 2D arrays to functions, the second dimension size must be fixed:

void fun(int arr[][3]) { ... }
or
void fun(int arr[2][3]) { ... }

This is needed for pointer arithmetic.
''';
      case TwoDArrayStep.commonErrors:
        return '''
Accessing outside declared bounds causes undefined behavior.

Do NOT do: arr[3][0] if array has only 3 rows (index 0-2).

Always ensure accesses are within range!
''';
      case TwoDArrayStep.memoryCalc:
        return '''
Memory required equals rows × columns × sizeof(element).

For int arr[3][4], total elements = 12.
If int = 4 bytes, total memory = 48 bytes.
''';
      case TwoDArrayStep.sumElements:
        return '''
Sum all elements:

int sum = 0;
for (int i = 0; i < rows; i++)
  for (int j = 0; j < cols; j++)
    sum += arr[i][j];

printf("Sum = %d", sum);
''';
      case TwoDArrayStep.rowSum:
        return '''
Sum elements row-wise:

for (int i = 0; i < rows; i++) {
  int sumRow = 0;
  for (int j = 0; j < cols; j++)
    sumRow += arr[i][j];
  printf("Row %d sum = %d\\n", i, sumRow);
}
''';
      case TwoDArrayStep.colSum:
        return '''
Sum elements column-wise:

for (int j = 0; j < cols; j++) {
  int sumCol = 0;
  for (int i = 0; i < rows; i++)
    sumCol += arr[i][j];
  printf("Col %d sum = %d\\n", j, sumCol);
}
''';
      case TwoDArrayStep.useCases:
        return '''
2D arrays commonly store:

- Image pixels
- Game boards (chess, minesweeper)
- Tabular data (spreadsheets)
- Mathematical matrices

Understanding these helps apply arrays effectively.
''';
      case TwoDArrayStep.multidim:
        return '''
You can have 3D or higher dimensions:

int arr[3][4][5];

Useful for RGB images or volumetric data.
''';
      case TwoDArrayStep.quiz:
        return '''
Quiz:

What is the output of this code?

int arr[2][3] = {
  {1, 2, 3},
  {4, 5, 6}
};
for(int i=0; i<2; i++) {
  for(int j=0; j<3; j++) {
    printf("%d ", arr[i][j]);
  }
  printf("\\n");
}
''';
      case TwoDArrayStep.pitfalls:
        return '''
Beware of uninitialized arrays which hold garbage data unless explicitly initialized.

Always initialize arrays before use to avoid unpredictable behavior.
''';
      case TwoDArrayStep.summary:
        return '''
Summary:

You learned about 2D array declaration, indexing, memory layout, initialization, looping, passing arrays to functions, pitfalls, and more.

You are ready to use 2D arrays effectively in C programming!
''';
      default:
        return '';
    }
  }

  // Evolving code snippets per step
  String _codeForStep(TwoDArrayStep step) {
    switch (step) {
      case TwoDArrayStep.intro:
        return '''
// 1D array example
int arr[5] = {1, 2, 3, 4, 5};
''';
      case TwoDArrayStep.motivation:
        return '''
// 1D arrays not suitable for matrice-like data
// Need 2D arrays instead
''';
      case TwoDArrayStep.definition:
        return '''
// 2D array declaration
int matrix[2][3];
''';
      case TwoDArrayStep.syntax:
        return '''
int matrix[2][3];
float grid[4][4];
''';
      case TwoDArrayStep.memoryLayout:
        return '''
// Memory layout (row-major):
// matrix[0][0], matrix[0][1], matrix[0][2], matrix[1][0], ...
''';
      case TwoDArrayStep.accessingElements:
        return '''
matrix[1][2] = 7;
printf("%d", matrix[1][2]);
''';
      case TwoDArrayStep.initialization:
        return '''
int matrix[2][3] = {
  {1, 2, 3},
  {4, 5, 6}
};

// Partial init:
int partial[3][4] = {
  {1, 2},
  {3}
};
''';
      case TwoDArrayStep.partialInit:
        return '''
// Partial initialized elements default to 0
int arr[3][4] = {
  {1, 2},
  {3}
};
''';
      case TwoDArrayStep.nestedLoops:
        return '''
for (int i = 0; i < 2; i++) {
  for (int j = 0; j < 3; j++) {
    // use matrix[i][j]
  }
}
''';
      case TwoDArrayStep.printExample:
        return '''
for (int i=0; i<2; i++) {
  for (int j=0; j<3; j++) {
    printf("%d ", matrix[i][j]);
  }
  printf("\\n");
}
''';
      case TwoDArrayStep.dynamicChange:
        return '''
matrix[0][2] = 99;
matrix[1][1] = matrix[0][0] + 1;
''';
      case TwoDArrayStep.passingArrayToFunc:
        return '''
void fun(int arr[][3]) {
  // Body
}
''';
      case TwoDArrayStep.commonErrors:
        return '''
// Beware accessing out of bounds causes undefined behavior
''';
      case TwoDArrayStep.memoryCalc:
        return '''
// Memory calc:
// rows * cols * sizeof(element)
''';
      case TwoDArrayStep.sumElements:
        return '''
int sum = 0;
for (int i=0; i<3; i++)
  for (int j=0; j<4; j++)
    sum += arr[i][j];

printf("Sum = %d", sum);
''';
      case TwoDArrayStep.rowSum:
        return '''
for (int i=0; i<3; i++) {
  int sumRow = 0;
  for (int j=0; j<4; j++)
    sumRow += arr[i][j];
  printf("Row %d sum = %d\\n", i, sumRow);
}
''';
      case TwoDArrayStep.colSum:
        return '''
for (int j=0; j<4; j++) {
  int sumCol = 0;
  for (int i=0; i<3; i++)
    sumCol += arr[i][j];
  printf("Col %d sum = %d\\n", j, sumCol);
}
''';
      case TwoDArrayStep.useCases:
        return '''
// Use cases:
// Images, games, tabular data, math matrices
''';
      case TwoDArrayStep.multidim:
        return '''
int arr[3][4][5]; // 3D array
''';
      case TwoDArrayStep.quiz:
        return '''
int arr[2][3] = {
  {1, 2, 3},
  {4, 5, 6}
};
for(int i=0; i<2; i++) {
  for(int j=0; j<3; j++) {
    printf("%d ", arr[i][j]);
  }
  printf("\\n");
}
''';
      case TwoDArrayStep.pitfalls:
        return '''
int arr[2][3]; // uninitialized - may contain garbage values
''';
      case TwoDArrayStep.summary:
        return '''
// You learned all about 2D arrays in C!
// Declaration, access, initialization, loops, functions, pitfalls...
''';
      default:
        return '';
    }
  }

  // The flowchart with current step highlight
  Widget _buildFlowchart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? Colors.teal[700]! : Colors.teal[50]!;
    final borderColor = isDark ? Colors.tealAccent : Colors.teal[800]!;
    final textColor = isDark ? Colors.white : Colors.teal[900]!;

    final stepsText = [
      'Intro',
      'Motivation',
      'Definition',
      'Syntax',
      'Memory Layout',
      'Access Elements',
      'Initialization',
      'Partial Init',
      'Nested Loops',
      'Print Example',
      'Dynamic Change',
      'Pass to Func',
      'Common Errors',
      'Memory Calc',
      'Sum Elements',
      'Row Sum',
      'Col Sum',
      'Use Cases',
      'Multi-dim',
      'Quiz',
      'Pitfalls',
      'Summary',
    ];

    return Container(
      color: isDark ? Colors.black12 : Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: List.generate(stepsText.length * 2 - 1, (i) {
            if (i.isEven) {
              final idx = i ~/ 2;
              final active = idx == _currentStepIndex;
              return Container(
                width: 120,
                margin: EdgeInsets.symmetric(horizontal: 6),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: active ? (isDark ? Colors.tealAccent : Colors.teal[300]) : bgColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: borderColor,
                    width: active ? 2.5 : 1.6,
                  ),
                  boxShadow: active
                      ? [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0,2))]
                      : null,
                ),
                child: Center(
                  child: Text(
                    stepsText[idx],
                    style: TextStyle(
                      color: active ? (isDark ? Colors.black : Colors.white) : textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              // arrow between boxes
              return Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isDark ? Colors.tealAccent.withOpacity(0.7) : Colors.teal[700],
              );
            }
          }),
        ),
      ),
    );
  }

  // Widget for code box with dark mode and horizontal scroll
  Widget _buildCodeBox(String code) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? Color(0xFF121212) : Color(0xFFF7F9FA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.tealAccent.shade700 : Colors.teal.shade300,
          width: 1.3,
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SelectableText(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14,
            color: isDark ? Colors.tealAccent.shade100 : Colors.teal.shade900,
            height: 1.3,
          ),
        ),
      ),
    );
  }

  // Explanation text box
  Widget _buildExplanationBox(String explanation) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: SelectableText(
        explanation.trim(),
        style: TextStyle(
          fontSize: 16,
          height: 1.35,
          color: isDark ? Colors.tealAccent.shade100 : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Quiz UI at quiz step
  Widget _buildQuiz() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final options = ["1", "2", "3", "0"];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.teal[900]!.withOpacity(0.15) : Colors.teal[50],
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? Colors.tealAccent.withOpacity(0.3) : Colors.teal.shade300,
            width: 1.6,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quiz: What is the output of this code?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDark ? Colors.yellowAccent : Colors.teal.shade900,
              ),
            ),
            SizedBox(height: 8),
            SelectableText(
              '''int arr[2][3] = {
  {1, 2, 3},
  {4, 5, 6}
};
for(int i=0; i<2; i++) {
  for(int j=0; j<3; j++) {
    printf("%d ", arr[i][j]);
  }
  printf("\\n");
}''',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                color: isDark ? Colors.tealAccent.shade100 : Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 14,
              children: options.map((opt) {
                final isCorrect = opt == "1";
                final selectedCorrect = _quizResult != null && _quizResult!.startsWith("Correct") && isCorrect;
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isCorrect) {
                        _quizResult = "Correct! Output:\n1 2 3\n4 5 6";
                      } else {
                        _quizResult = "Try again! Hint: Review the nested loop structure.";
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(50, 38),
                    backgroundColor: selectedCorrect
                        ? (isDark ? Colors.tealAccent : Colors.teal.shade300)
                        : (isDark ? Colors.teal[900] : Colors.teal[100]),
                    foregroundColor: selectedCorrect
                        ? Colors.black
                        : (isDark ? Colors.tealAccent : Colors.teal.shade900),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    opt,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
            if (_quizResult != null) ...[
              SizedBox(height: 14),
              Text(
                _quizResult!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _quizResult!.startsWith("Correct")
                      ? (isDark ? Colors.greenAccent : Colors.green)
                      : (isDark ? Colors.redAccent : Colors.red),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  // Build main content area for current step with animations
  Widget _buildCurrentStepContent() {
    final step = _currentStep;
    final explanation = _explanationForStep(step);
    final code = _codeForStep(step);

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600; // side-by-side layout threshold

            Widget explanationWidget = _buildExplanationBox(explanation);
            Widget codeWidget = _buildCodeBox(code);

            Widget content;
            if (isWide) {
              // side by side row
              content = Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: explanationWidget),
                    SizedBox(width: 18),
                    Expanded(child: codeWidget),
                  ],
                ),
              );
            } else {
              // stacked column
              content = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  explanationWidget,
                  codeWidget,
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Center(
                  child: Text(
                    step.name
                        .replaceAllMapped(RegExp(r'([A-Z])'), (m) => " ${m[1]}")
                        .trim()
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.tealAccent
                          : Colors.teal[900],
                    ),
                  ),
                ),
                Divider(
                  thickness: 1.3,
                  indent: 24,
                  endIndent: 24,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.tealAccent.withOpacity(0.3)
                      : Colors.teal[300],
                ),
                content,
                if (step == TwoDArrayStep.quiz) _buildQuiz(),
              ],
            );
          },
        ),
      ),
    );
  }

  // Build bottom navigation buttons bar
  Widget _buildNavigationButtons() {
    final isFirst = _currentStepIndex == 0;
    final isLast = _currentStepIndex == _steps.length - 1;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: isFirst ? null : _previousStep,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? Colors.teal[800] : Colors.teal[100],
              foregroundColor: isDark ? Colors.tealAccent : Colors.teal[900],
              minimumSize: Size(110, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            icon: Icon(Icons.arrow_back,
                color: isFirst ? Colors.grey : (isDark ? Colors.tealAccent : Colors.teal[900])),
            label: Text('Back'),
          ),
          if (!isLast)
            ElevatedButton.icon(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? Colors.teal[900] : Colors.teal[300],
                foregroundColor: isDark ? Colors.tealAccent : Colors.teal[900],
                minimumSize: Size(110, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              icon: Text('Next'),
              label: Icon(Icons.arrow_forward,
                  color: isDark ? Colors.tealAccent : Colors.teal[900]),
            )
          else
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).maybePop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? Colors.greenAccent : Colors.teal[700],
                foregroundColor: isDark ? Colors.black : Colors.white,
                minimumSize: Size(110, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              icon: Icon(Icons.check_circle_outline, color: Colors.black),
              label: Text('Finish'),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '2D Array in C',
          style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900]),
        ),
        backgroundColor: isDark ? Colors.black : Colors.teal[50],
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: isDark ? Colors.tealAccent : Colors.teal[900]),
      ),
      backgroundColor: isDark ? Color(0xFF11161D) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildFlowchart(context),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 8),
                child: _buildCurrentStepContent(),
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }
}
