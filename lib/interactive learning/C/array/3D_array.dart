import 'package:flutter/material.dart';

enum ThreeDArrayStep {
  introRecap,
  concept,
  visualization,
  syntax,
  memoryLayout,
  accessElements,
  initialization,
  partialInit,
  nestedLoops,
  printExample,
  dynamicModify,
  passingToFunc,
  sumAll,
  sumLayer,
  sumAcrossLayers,
  memoryCalc,
  commonErrors,
  dynamic3D,
  useCases,
  beyond3D,
  quiz,
  pitfalls,
  summary,
}

class ThreeDArrayPage extends StatefulWidget {
  @override
  _ThreeDArrayPageState createState() => _ThreeDArrayPageState();
}

class _ThreeDArrayPageState extends State<ThreeDArrayPage> with TickerProviderStateMixin {
  int _currentStepIndex = 0;
  final List<ThreeDArrayStep> _steps = ThreeDArrayStep.values;

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int? _selectedQuizChoice;
  String? _quizFeedback;

  // Quiz choices for the quiz step
  final List<_QuizChoice> _quizChoices = [
    _QuizChoice(
      '1 2 3 4 5 6 Layer 7 8 9 10 11 12 Layer',
      false,
    ),
    _QuizChoice(
      '1 2 3 4 5 6 7 8 9 10 11 12 Layer',
      false,
    ),
    _QuizChoice(
      '1 2 3 \n4 5 6 \nLayer \n7 8 9 \n10 11 12 \nLayer',
      true,
    ),
    _QuizChoice(
      'Layer 1 2 3 4 5 6 Layer 7 8 9 10 11 12',
      false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(duration: Duration(milliseconds: 400), vsync: this);

    _fadeAnimation = CurvedAnimation(parent: _animController, curve: Curves.easeInOutCubic);
    _slideAnimation =
        Tween<Offset>(begin: Offset(0, 0.15), end: Offset.zero).animate(_fadeAnimation);

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  ThreeDArrayStep get _currentStep => _steps[_currentStepIndex];

  void _goToStep(int index) async {
    if (index < 0 || index >= _steps.length) return;

    await _animController.reverse();
    setState(() {
      _currentStepIndex = index;
      _selectedQuizChoice = null;
      _quizFeedback = null;
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

  String _stepTitle(ThreeDArrayStep step) {
    switch (step) {
      case ThreeDArrayStep.introRecap:
        return 'INTRODUCTION & RECAP';
      case ThreeDArrayStep.concept:
        return 'CONCEPT OF 3D ARRAYS';
      case ThreeDArrayStep.visualization:
        return 'VISUALIZATION';
      case ThreeDArrayStep.syntax:
        return 'SYNTAX';
      case ThreeDArrayStep.memoryLayout:
        return 'MEMORY LAYOUT';
      case ThreeDArrayStep.accessElements:
        return 'ACCESSING ELEMENTS';
      case ThreeDArrayStep.initialization:
        return 'INITIALIZATION';
      case ThreeDArrayStep.partialInit:
        return 'PARTIAL INITIALIZATION';
      case ThreeDArrayStep.nestedLoops:
        return 'NESTED LOOPS';
      case ThreeDArrayStep.printExample:
        return 'PRINT EXAMPLE';
      case ThreeDArrayStep.dynamicModify:
        return 'DYNAMIC MODIFICATION';
      case ThreeDArrayStep.passingToFunc:
        return 'PASSING TO FUNCTIONS';
      case ThreeDArrayStep.sumAll:
        return 'SUM ALL ELEMENTS';
      case ThreeDArrayStep.sumLayer:
        return 'SUM SPECIFIC LAYER';
      case ThreeDArrayStep.sumAcrossLayers:
        return 'SUM ACROSS LAYERS';
      case ThreeDArrayStep.memoryCalc:
        return 'MEMORY CALCULATION';
      case ThreeDArrayStep.commonErrors:
        return 'COMMON ERRORS';
      case ThreeDArrayStep.dynamic3D:
        return 'DYNAMIC 3D ARRAYS';
      case ThreeDArrayStep.useCases:
        return 'USE CASES';
      case ThreeDArrayStep.beyond3D:
        return 'BEYOND 3D ARRAYS';
      case ThreeDArrayStep.quiz:
        return 'QUIZ';
      case ThreeDArrayStep.pitfalls:
        return 'POTENTIAL PITFALLS';
      case ThreeDArrayStep.summary:
        return 'SUMMARY';
    }
  }

  String? _infoTextForStep(ThreeDArrayStep step) {
    switch (step) {
      case ThreeDArrayStep.introRecap:
        return "Quick review of 1D and 2D arrays and why multidimensional arrays matter.";
      case ThreeDArrayStep.concept:
        return "A 3D array is an array of 2D arrays — think of it as a cube or layers of matrices.";
      case ThreeDArrayStep.visualization:
        return "Visualize 3D arrays as rows × columns × depth (layers) like a stack of tables.";
      case ThreeDArrayStep.memoryLayout:
        return "Data stored sequentially in memory layer by layer, row by row.";
      case ThreeDArrayStep.partialInit:
        return "Partial initialization sets unspecified elements to zero by default.";
      case ThreeDArrayStep.dynamicModify:
        return "Modify elements dynamically with indexing, e.g. arr[0][1][2] = 42;";
      case ThreeDArrayStep.memoryCalc:
        return "Total elements = depth × rows × columns, e.g. 2 × 3 × 4 = 24.";
      case ThreeDArrayStep.dynamic3D:
        return "Dynamic 3D arrays can be allocated using pointers and malloc (advanced).";
      case ThreeDArrayStep.useCases:
        return "Use cases: RGB images (layers), 3D games, scientific simulations.";
      case ThreeDArrayStep.beyond3D:
        return "Higher dimension arrays (4D+) exist for complex data structures.";
      case ThreeDArrayStep.pitfalls:
        return "Uninitialized arrays may contain garbage; always initialize.";
      case ThreeDArrayStep.summary:
        return "Summary: 3D arrays store data in layers; accessed with 3 indices.";
      case ThreeDArrayStep.quiz:
      case ThreeDArrayStep.syntax:
      case ThreeDArrayStep.accessElements:
      case ThreeDArrayStep.initialization:
      case ThreeDArrayStep.nestedLoops:
      case ThreeDArrayStep.printExample:
      case ThreeDArrayStep.passingToFunc:
      case ThreeDArrayStep.sumAll:
      case ThreeDArrayStep.sumLayer:
      case ThreeDArrayStep.sumAcrossLayers:
      case ThreeDArrayStep.commonErrors:
        return null;
    }
  }

  String? _codeForStep(ThreeDArrayStep step) {
    // Return relevant code snippet or null
    switch (step) {
      case ThreeDArrayStep.syntax:
        return '''
// Syntax to declare a 3D array in C:
int arr[2][3][4];

// 2 = depth (layers)
// 3 = rows
// 4 = columns
''';
      case ThreeDArrayStep.accessElements:
        return '''
// Accessing an element:
arr[1][0][2] = 10;

// depth 1, row 0, column 2 (0-based indexing)
''';
      case ThreeDArrayStep.initialization:
        return '''
// Initializing a 3D array:
int arr[2][2][3] = {
  {
    {1, 2, 3},
    {4, 5, 6}
  },
  {
    {7, 8, 9},
    {10, 11, 12}
  }
};
''';
      case ThreeDArrayStep.nestedLoops:
        return '''
// Iterating over 3D arrays:
for(int d = 0; d < depth; d++) {
  for(int r = 0; r < rows; r++) {
    for(int c = 0; c < cols; c++) {
      // access arr[d][r][c]
    }
  }
}
''';
      case ThreeDArrayStep.printExample:
        return '''
// Print all elements layer by layer in order.
''';
      case ThreeDArrayStep.passingToFunc:
        return '''
// Passing 3D arrays to functions:
void func(int arr[][3][4]) {
  // second and third dimensions fixed
}
''';
      case ThreeDArrayStep.sumAll:
        return '''
// Sum all elements:
int sum = 0;
for(int d=0; d<depth; d++) {
  for(int r=0; r<rows; r++) {
    for(int c=0; c<cols; c++) {
      sum += arr[d][r][c];
    }
  }
}
''';
      case ThreeDArrayStep.sumLayer:
        return '''
// Sum elements of a specific 2D layer:
int sumLayer = 0;
int layer = 1; // example layer index
for(int r=0; r<rows; r++) {
  for(int c=0; c<cols; c++) {
    sumLayer += arr[layer][r][c];
  }
}
''';
      case ThreeDArrayStep.sumAcrossLayers:
        return '''
// Sum elements of a specific row and column across all layers:
int sumElem = 0;
int row = 0, col = 2; // example indices
for(int d=0; d<depth; d++) {
  sumElem += arr[d][row][col];
}
''';
      case ThreeDArrayStep.commonErrors:
        return '''
// Common errors - Index out of bounds causes runtime issues.
Example: arr[2][0][0] invalid if depth is 2 (max index 1).
''';
      case ThreeDArrayStep.introRecap:
      case ThreeDArrayStep.concept:
      case ThreeDArrayStep.visualization:
      case ThreeDArrayStep.memoryLayout:
      case ThreeDArrayStep.partialInit:
      case ThreeDArrayStep.dynamicModify:
      case ThreeDArrayStep.memoryCalc:
      case ThreeDArrayStep.dynamic3D:
      case ThreeDArrayStep.useCases:
      case ThreeDArrayStep.beyond3D:
      case ThreeDArrayStep.quiz:
      case ThreeDArrayStep.pitfalls:
      case ThreeDArrayStep.summary:
        return null;
    }
  }

  Widget _buildStepFlowchart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pearlGreen = isDark ? Color(0xffa7f3d0) : Colors.teal[900]!;

    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: _steps.map((s) {
            final isActive = s == _currentStep;
            return GestureDetector(
              onTap: () => _goToStep(_steps.indexOf(s)),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isActive ? pearlGreen : (isDark ? Colors.grey[800] : Colors.grey[300]),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: isActive
                      ? [BoxShadow(color: pearlGreen.withOpacity(0.5), blurRadius: 8, offset: Offset(0, 2))]
                      : null,
                ),
                child: Text(
                  _stepTitle(s),
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    fontSize: 13,
                    color: isActive ? Colors.black : (isDark ? Colors.teal[100] : Colors.black87),
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildPopup(
      BuildContext context,
      String text,
      Color backgroundColor, {
        Color? textColor,
        String? fontFamily,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: textColor?.withOpacity(0.4) ?? (isDark ? Colors.tealAccent : Colors.black12)),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black45 : Colors.grey.withOpacity(0.2)),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SelectableText(
        text,
        style: TextStyle(
          fontSize: 15.2,
          color: textColor ?? (isDark ? Colors.tealAccent.shade100 : Colors.black87),
          fontFamily: fontFamily ?? "Roboto",
          height: 1.35,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildExplanation(String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SelectableText(
        text.trim(),
        style: TextStyle(
          fontSize: 16,
          height: 1.35,
          color: isDark ? Colors.tealAccent.shade100 : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCodeBox(String code) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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

  Widget _buildQuiz() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const quizCode = '''
int arr[2][2][3] = {
  {
    {1, 2, 3},
    {4, 5, 6}
  },
  {
    {7, 8, 9},
    {10, 11, 12}
  }
};
for(int d = 0; d < 2; d++) {
  for(int r = 0; r < 2; r++) {
    for(int c = 0; c < 3; c++) {
      printf("%d ", arr[d][r][c]);
    }
    printf("\\n");
  }
  printf("Layer \\n");
}
''';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.teal[900]!.withOpacity(0.15) : Colors.teal[50],
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? Colors.tealAccent.withOpacity(0.3) : Colors.teal.shade300,
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QUIZ: PREDICT THE OUTPUT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.yellowAccent[700],
                letterSpacing: 1.3,
              ),
            ),
            SizedBox(height: 8),
            _buildPopup(
              context,
              quizCode,
              isDark ? Colors.tealAccent.withOpacity(0.2) : Colors.amber[100]!,
              fontFamily: "monospace",
              textColor: isDark ? Colors.tealAccent[100] : Colors.black87,
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: List.generate(_quizChoices.length, (index) {
                final choice = _quizChoices[index];
                final isSelected = _selectedQuizChoice == index;
                Color? buttonColor;
                Color? textColor;

                if (_quizFeedback != null) {
                  if (isSelected) {
                    if (choice.isCorrect) {
                      buttonColor = Colors.greenAccent.shade700;
                      textColor = Colors.black;
                    } else {
                      buttonColor = Colors.redAccent.shade400;
                      textColor = Colors.white;
                    }
                  } else if (choice.isCorrect) {
                    buttonColor = Colors.greenAccent.shade400;
                    textColor = Colors.black;
                  }
                } else if (isSelected) {
                  buttonColor = isDark ? Colors.teal[800] : Colors.teal[200];
                  textColor = isDark ? Colors.tealAccent : Colors.teal[900];
                } else {
                  buttonColor = isDark ? Colors.teal[900] : Colors.teal[50];
                  textColor = isDark ? Colors.tealAccent : Colors.teal[900];
                }

                return ElevatedButton(
                  onPressed: _quizFeedback == null
                      ? () {
                    setState(() {
                      _selectedQuizChoice = index;
                      if (choice.isCorrect) {
                        _quizFeedback = "Correct! Well done.";
                      } else {
                        _quizFeedback = "Incorrect, try again.";
                      }
                    });
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: textColor,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    textStyle: TextStyle(fontSize: 14, fontFamily: "monospace", fontWeight: FontWeight.w600),
                    elevation: 0,
                  ),
                  child: Text(choice.text),
                );
              }),
            ),
            if (_quizFeedback != null) ...[
              SizedBox(height: 14),
              Text(
                _quizFeedback!,
                style: TextStyle(
                    color: _quizFeedback == "Correct! Well done."
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final step = _currentStep;

    final infoText = _infoTextForStep(step);
    final codeText = _codeForStep(step);

    return LayoutBuilder(builder: (context, constraints) {
      final isWide = constraints.maxWidth > 720;

      Widget explanationWidget = infoText != null
          ? _buildPopup(
        context,
        infoText,
        isDark ? Colors.teal[700]!.withOpacity(0.15) : Colors.teal[50]!,
        textColor: isDark ? Colors.tealAccent : Colors.teal[900],
      )
          : const SizedBox.shrink();

      Widget codeWidget = codeText != null
          ? _buildPopup(
        context,
        codeText,
        isDark ? Colors.tealAccent.withOpacity(0.15) : Colors.amber[100]!,
        fontFamily: "monospace",
        textColor: isDark ? Colors.teal[100] : Colors.teal[900],
      )
          : const SizedBox.shrink();

      Widget contentWidget;
      if (isWide) {
        contentWidget = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: explanationWidget),
            SizedBox(width: 24),
            Expanded(child: codeWidget),
          ],
        );
      } else {
        contentWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            explanationWidget,
            SizedBox(height: 16),
            codeWidget,
          ],
        );
      }

      final stepTitle = _stepTitle(step);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16),
          Center(
            child: Text(
              stepTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.tealAccent : Colors.teal[900],
                letterSpacing: 1.1,
              ),
            ),
          ),
          Divider(
            thickness: 1.3,
            indent: 32,
            endIndent: 32,
            color: isDark ? Colors.tealAccent.withOpacity(0.3) : Colors.teal[300],
          ),
          contentWidget,
          if (step == ThreeDArrayStep.quiz) _buildQuiz(),
          SizedBox(height: 20),
        ],
      );
    });
  }

  Widget _buildAnimatedStepContent() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: KeyedSubtree(
          key: ValueKey(_currentStepIndex),
          child: _buildStepContent(context),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    final isFirst = _currentStepIndex == 0;
    final isLast = _currentStepIndex == _steps.length - 1;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: isFirst ? null : _previousStep,
            icon: Icon(Icons.arrow_back, color: isFirst ? Colors.grey : (isDark ? Colors.tealAccent : Colors.teal[900])),
            label: Text('Back'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(110, 45),
              backgroundColor: isDark ? Colors.teal[800] : Colors.teal[100],
              foregroundColor: isDark ? Colors.tealAccent : Colors.teal[900],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          if (!isLast)
            ElevatedButton.icon(
              onPressed: _nextStep,
              label: Text('Next'),
              icon: Icon(Icons.arrow_forward, color: isDark ? Colors.tealAccent : Colors.teal[900]),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(110, 45),
                backgroundColor: isDark ? Colors.teal[900] : Colors.teal[300],
                foregroundColor: isDark ? Colors.tealAccent : Colors.teal[900],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            )
          else
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: Icon(Icons.check_circle_outline, color: Colors.black),
              label: Text('Finish'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(110, 45),
                backgroundColor: isDark ? Colors.greenAccent : Colors.teal[700],
                foregroundColor: isDark ? Colors.black : Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
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
          '3D Array in C',
          style: TextStyle(color: isDark ? Colors.tealAccent : Colors.teal[900], fontWeight: FontWeight.bold),
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
            _buildStepFlowchart(context),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 8),
                child: _buildAnimatedStepContent(),
              ),
            ),
            _buildNavigationButtons(),
          ],
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
