import 'package:flutter/material.dart';
import 'dart:math';

enum CProgramStructureStep {
  introduction,
  documentation,
  preprocessorDirectives,
  macroDefinitions,
  globalDeclarations,
  functionPrototypes,
  mainFunction,
  mainFunctionBody,
  userDefinedFunctionsIntro,
  exampleFunction,
  modularityBenefits,
  compilingBuilding,
  runningProgram,
  commonErrors,
  summary,
  quiz,
}

class CProgramStructurePage extends StatefulWidget {
  @override
  State<CProgramStructurePage> createState() => _CProgramStructurePageState();
}

class _CProgramStructurePageState extends State<CProgramStructurePage>
    with TickerProviderStateMixin {
  int _currentStepIndex = 0;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Quiz state
  int? _selectedAnswerIndex;
  bool _quizAnswered = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0.2, 0), end: Offset.zero)
        .animate(_fadeAnimation);

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _goToStep(int newStep) async {
    if (newStep == _currentStepIndex) return;

    await _animController.reverse();
    setState(() {
      _currentStepIndex = newStep;
      _selectedAnswerIndex = null;
      _quizAnswered = false;
    });
    await _animController.forward();
  }

  void _onNext() {
    if (_currentStepIndex < CProgramStructureStep.values.length - 1) {
      _goToStep(_currentStepIndex + 1);
    }
  }

  void _onPrevious() {
    if (_currentStepIndex > 0) {
      _goToStep(_currentStepIndex - 1);
    }
  }

  bool get _isFirstStep => _currentStepIndex == 0;

  bool get _isLastStep => _currentStepIndex == CProgramStructureStep.values.length - 1;

  // Color helpers for dark/light mode and consistent UI
  Color _textColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF7FFFD4) // aquamarine pearl/greenish
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
          ? Colors.teal.shade800.withOpacity(0.3)
          : Colors.teal.shade50;

  Color _flowChartBorderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.greenAccent.withOpacity(0.7)
          : Colors.green.shade200;

  Color _buttonTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent : Colors.teal.shade900;

  Color _buttonBackColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.teal[800]! : Colors.teal[200]!;
  }

  Color _buttonNextBackColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.teal[900]! : Colors.teal[400]!;
  }

  // Persistent horizontal flowchart with current step highlight
  final List<CProgramStructureStep> _flowchartSteps = [
    CProgramStructureStep.documentation,
    CProgramStructureStep.preprocessorDirectives,
    CProgramStructureStep.macroDefinitions,
    CProgramStructureStep.globalDeclarations,
    CProgramStructureStep.functionPrototypes,
    CProgramStructureStep.mainFunction,
    CProgramStructureStep.userDefinedFunctionsIntro,
  ];

  String _flowchartLabel(CProgramStructureStep step) {
    switch (step) {
      case CProgramStructureStep.documentation:
        return 'Documentation';
      case CProgramStructureStep.preprocessorDirectives:
        return 'Preprocessor Directives';
      case CProgramStructureStep.macroDefinitions:
        return 'Macro Definitions';
      case CProgramStructureStep.globalDeclarations:
        return 'Global Declarations';
      case CProgramStructureStep.functionPrototypes:
        return 'Function Prototypes';
      case CProgramStructureStep.mainFunction:
        return 'Main Function';
      case CProgramStructureStep.userDefinedFunctionsIntro:
        return 'User-Defined Functions';
      default:
        return '';
    }
  }

  Widget _buildFlowchart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final txtClr = _flowChartTextColor(context);
    final boxClr = _flowChartBoxColor(context);
    final brdClr = _flowChartBorderColor(context);
    final activeColor = isDark ? Colors.tealAccent.shade200 : Colors.teal.shade700;

    return Container(
      color: isDark ? const Color(0xFF152a23) : const Color(0xFFE6F2ED),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_flowchartSteps.length, (index) {
            final step = _flowchartSteps[index];
            final bool isActive = step == CProgramStructureStep.values[_currentStepIndex];
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    _goToStep(CProgramStructureStep.values.indexOf(step));
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isActive ? activeColor.withOpacity(0.3) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isActive ? activeColor : brdClr,
                        width: isActive ? 2.5 : 1.4,
                      ),
                    ),
                    constraints: const BoxConstraints(minWidth: 120),
                    child: Text(
                      _flowchartLabel(step).toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        letterSpacing: 0.5,
                        color: isActive ? activeColor : txtClr,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (index < _flowchartSteps.length - 1)
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: isDark ? Colors.tealAccent.shade100.withOpacity(0.7) : Colors.teal.shade300,
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // Responsive widget for side-by-side (wide) or stacked (narrow) explanation and code
  Widget _responsiveContent({required Widget explanation, Widget? code}) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 700) {
        // side by side horizontal
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: explanation),
            const SizedBox(width: 32),
            if (code != null)
              Flexible(
                child: code,
              ),
          ],
        );
      } else {
        // stacked vertical
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            explanation,
            if (code != null) ...[
              const SizedBox(height: 18),
              code,
            ],
          ],
        );
      }
    });
  }

  Widget _codeBlock(String code) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF141A18) : const Color(0xFFF2FCF4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? Colors.green.shade900 : Colors.teal.shade200,
          width: 1.4,
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SelectableText(
          code.trimRight(),
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14.5,
            color: isDark ? Colors.greenAccent.shade100 : Colors.green.shade900,
            height: 1.3,
          ),
        ),
      ),
    );
  }

  Widget _annotationBox(String text) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(top: 12, bottom: 16),
      decoration: BoxDecoration(
        color: _annotationBgColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: _annotationTextColor(context),
          fontSize: 15,
          height: 1.3,
        ),
      ),
    );
  }

  // Content widgets for each step with expanded explanations and progressive/evolving code examples

  Widget _buildStepContent() {
    final step = CProgramStructureStep.values[_currentStepIndex];
    final Color txtColor = _textColor(context);

    switch (step) {
      case CProgramStructureStep.introduction:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'INTRODUCTION',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.3,
                color: txtColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Understanding the structure of a C program is essential for writing clean, readable, and maintainable code. '
                  'Every C program consists of several sections that must appear in a specific order to compile and run properly.',
              style: TextStyle(fontSize: 17, height: 1.5, color: txtColor),
            ),
            const SizedBox(height: 12),
            Text(
              'The basic structure includes documentation comments, preprocessor directives, macro definitions, '
                  'global declarations, function prototypes, the main function (entry point), and user-defined functions.',
              style: TextStyle(fontSize: 17, height: 1.5, color: txtColor),
            ),
            const SizedBox(height: 18),
            _buildFlowchart(context),
          ],
        );

      case CProgramStructureStep.documentation:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DOCUMENTATION SECTION',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Comments at the beginning of the program help explain what the program does, who wrote it, and any pertinent notes. '
                    'Good documentation is invaluable for yourself and others who maintain your code.',
                style: TextStyle(fontSize: 16, height: 1.5, color: txtColor),
              ),
              const SizedBox(height: 12),
              Text('Example 1:\nSimple program header comment block:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          code: _codeBlock('''
// Author: Jane Doe
// Date: 2025-07-26
// Purpose: Demonstrate basic C program structure
'''),
        );

      case CProgramStructureStep.preprocessorDirectives:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PREPROCESSOR DIRECTIVES',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Preprocessor directives start with # and instruct the compiler to include files or define constants before compilation. '
                    'The most common directive is #include to bring in external libraries.',
                style: TextStyle(fontSize: 16, height: 1.5, color: txtColor),
              ),
              const SizedBox(height: 12),
              Text('Example 1:\nIncluding standard input/output library:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text('Example 2:\nUsing conditional compilation with #ifdef:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          code: _codeBlock('''
#include <stdio.h>

#ifdef DEBUG
  #define LOG(x) printf("LOG: %s\\n", x)
#else
  #define LOG(x)
#endif
'''),
        );

      case CProgramStructureStep.macroDefinitions:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MACRO DEFINITIONS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Macros are symbolic names or code snippets replaced during preprocessing. '
                    'They simplify code adjustments and avoid repeated literals.',
                style: TextStyle(fontSize: 16, height: 1.5, color: txtColor),
              ),
              const SizedBox(height: 12),
              Text(
                'Example 1:\nDefine constant for array size:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'Example 2:\nMacro function for squaring a number:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          code: _codeBlock('''
#define MAX_SIZE 100
#define SQUARE(x) ((x) * (x))

int arr[MAX_SIZE];
int y = SQUARE(5);
'''),
        );

      case CProgramStructureStep.globalDeclarations:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GLOBAL DECLARATIONS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Global variables and constants declared here can be used throughout the program. '
                    'However, they should be used judiciously to avoid side effects and maintenance issues.',
                style: TextStyle(fontSize: 16, height: 1.5, color: txtColor),
              ),
              const SizedBox(height: 12),
              Text('Example 1:\nGlobal counter variable:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Text('Example 2:\nGlobal constant definition:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          code: _codeBlock('''
int globalCounter = 0;
const int MAX_USERS = 10;
'''),
        );

      case CProgramStructureStep.functionPrototypes:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FUNCTION PROTOTYPES',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Function prototypes declare function signatures before their definitions. '
                    'This informs the compiler about their existence and enables type checking.',
                style: TextStyle(fontSize: 16, height: 1.5, color: txtColor),
              ),
              const SizedBox(height: 12),
              Text('Example 1:\nPrototype declaration:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Text('Example 2:\nSeparate implementation after prototype:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          code: _codeBlock('''
int add(int a, int b);
void printMessage(const char* msg);

int main() {
  int sum = add(2, 3);
  printMessage("Hello");
  return 0;
}

int add(int a, int b) {
  return a + b;
}

void printMessage(const char* msg) {
  printf("%s\\n", msg);
}
'''),
        );

      case CProgramStructureStep.mainFunction:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MAIN FUNCTION',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'The main function is the mandatory entry point of a C program. '
                    'Execution always starts here and returns an integer status to the system.',
                style: TextStyle(fontSize: 16, height: 1.5, color: txtColor),
              ),
              const SizedBox(height: 12),
              Text('Example 1:\nStandard main function:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Text('Example 2:\nMain with arguments:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          code: _codeBlock('''
int main(void) {
  printf("Program started.\\n");
  return 0;
}

int main(int argc, char *argv[]) {
  printf("Program started with %d arguments.\\n", argc);
  return 0;
}
'''),
        );

      case CProgramStructureStep.mainFunctionBody:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MAIN FUNCTION BODY',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Contains initialization code, calls to other functions, and program control flow logic. '
                    'Typically returns 0 to indicate successful execution.',
                style: TextStyle(fontSize: 16, height: 1.5, color: txtColor),
              ),
              const SizedBox(height: 12),
              Text('Example 1:\nVariable initialization and function call:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Text('Example 2:\nControl flow inside main:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          code: _codeBlock('''
int main(void) {
  int x = 5;
  int y = 8;
  int sum = add(x, y);
  printf("Sum is %d\\n", sum);
  return 0;
}
'''),
        );

      case CProgramStructureStep.userDefinedFunctionsIntro:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'USER-DEFINED FUNCTIONS INTRODUCTION',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Functions allow breaking large tasks into manageable chunks that can be reused and maintained easily.',
                style: TextStyle(fontSize: 16, height: 1.5, color: txtColor),
              ),
              const SizedBox(height: 12),
              Text('Example 1:\nA function to add two numbers:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Text('Example 2:\nFunctions improve modularity and clarity:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          code: _codeBlock('''
int add(int a, int b) {
  return a + b;
}
'''),
        );

      case CProgramStructureStep.exampleFunction:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EXAMPLE FUNCTION',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Here is a simple function that accepts two integers, adds them, and returns the result.',
                style: TextStyle(fontSize: 16, height: 1.5, color: txtColor),
              ),
              const SizedBox(height: 12),
              Text('Example usage in main function:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
            ],
          ),
          code: _codeBlock('''
int add(int a, int b) {
  return a + b;
}

int main() {
  int result = add(3, 4);
  printf("3 + 4 = %d\\n", result);
  return 0;
}
'''),
        );

      case CProgramStructureStep.modularityBenefits:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MODULARITY BENEFITS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Modular code improves readability, debugging, and team collaboration. It supports code reuse and easier maintenance.',
                style: TextStyle(fontSize: 16, height: 1.5, color: txtColor),
              ),
              const SizedBox(height: 12),
              Text('Example 1:\nSeparate logic in different functions/modules.',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Text('Example 2:\nEasier to debug small pieces than large monolithic code.',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          code: null,
        );

      case CProgramStructureStep.compilingBuilding:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'COMPILING AND BUILDING',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Compilation steps include preprocessing, compiling source code to object files, and linking those files into executables.',
                style: TextStyle(fontSize: 16, height: 1.5, color: txtColor),
              ),
              const SizedBox(height: 12),
              Text('Example 1:\ngcc -E to run the preprocessor.',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Text('Example 2:\ngcc -c to compile source to object files.',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          code: _codeBlock('''
gcc -E program.c      # Preprocessing
gcc -c program.c      # Compile to object file
gcc program.o -o prog  # Linking to create executable
'''),
        );

      case CProgramStructureStep.runningProgram:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RUNNING THE PROGRAM',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Once compiled and linked, the executable is run by the operating system, which loads it into memory and starts execution at main().',
                style: TextStyle(fontSize: 16, height: 1.5, color: txtColor),
              ),
              const SizedBox(height: 12),
              Text('Example 1:\nRun program on Unix:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Text('Example 2:\nPassing command-line arguments to main:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          code: _codeBlock('''
./prog     # Run executable

int main(int argc, char *argv[]) {
  // argc - number of arguments
  // argv - array of argument strings
}
'''),
        );

      case CProgramStructureStep.commonErrors:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'COMMON ERRORS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Typical errors causing compilation issues include missing function prototypes, lack of return statements, undeclared variables, or unmatched curly braces.',
                style: TextStyle(fontSize: 16, height: 1.5, color: txtColor),
              ),
              const SizedBox(height: 12),
              Text('Example 1:\nForgetting to declare a function prototype leads to warnings/errors.',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Text('Example 2:\nMismatched braces causes compilation errors.',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          code: _codeBlock('''
// Missing prototype
int main() {
  int result = add(3, 4); // error: implicit declaration of 'add'
  return 0;
}

// Mismatched braces
int sum(int a, int b) {
  return a + b;
 // missing closing brace here
'''),
        );

      case CProgramStructureStep.summary:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SUMMARY',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: txtColor),
            ),
            const SizedBox(height: 16),
            Text(
              'The C program structure involves an organized order including documentation comments, preprocessor directives, macros, global declarations, function prototypes, main entry point, user functions, and proper compiling and running stages.',
              style: TextStyle(fontSize: 17, height: 1.5, color: txtColor),
            ),
            const SizedBox(height: 12),
            Text(
              'Proper structure and modular code result in readable, maintainable, and efficient programs, and reduce bug risks.',
              style: TextStyle(fontSize: 17, height: 1.5, color: txtColor),
            ),
          ],
        );

      case CProgramStructureStep.quiz:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QUIZ: TEST YOUR KNOWLEDGE',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.3,
                color: txtColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Which section in a C program is used to declare global variables?',
              style: TextStyle(fontSize: 17, height: 1.5, color: txtColor),
            ),
            const SizedBox(height: 16),
            ...List.generate(_quizOptions.length, (index) {
              Color? btnColor;
              if (_quizAnswered) {
                if (index == _correctAnswerIndex) {
                  btnColor = Colors.green;
                } else if (_selectedAnswerIndex == index) {
                  btnColor = Colors.red[700];
                }
              }
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor ?? Theme.of(context).colorScheme.surface,
                    foregroundColor: btnColor != null ? Colors.white : null,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    alignment: Alignment.centerLeft,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    side: BorderSide(
                      color: (_selectedAnswerIndex == index) ? Theme.of(context).colorScheme.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  onPressed: _quizAnswered
                      ? null
                      : () {
                    setState(() {
                      _selectedAnswerIndex = index;
                      _quizAnswered = true;
                    });
                  },
                  child: Text(
                    _quizOptions[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }),
            if (_quizAnswered)
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                child: Text(
                  _selectedAnswerIndex == _correctAnswerIndex
                      ? 'Correct! Global variables are declared in the "Global Declarations" section.'
                      : 'Incorrect. Try again! Global variables belong to the "Global Declarations" section.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _selectedAnswerIndex == _correctAnswerIndex ? Colors.green : Colors.red[700],
                  ),
                ),
              )
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  final List<String> _quizOptions = [
    'Documentation',
    'Preprocessor Directives',
    'Global Declarations',
    'Main Function',
  ];

  final int _correctAnswerIndex = 2;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double horizontalPadding = MediaQuery.of(context).size.width < 600 ? 14 : 36;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        title: Text(
          'C PROGRAM STRUCTURE',
          style: TextStyle(
            color: isDark ? Colors.greenAccent : Colors.teal[900],
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black87 : Colors.teal.shade100,
        iconTheme: IconThemeData(color: isDark ? Colors.greenAccent : Colors.teal[900]),
        elevation: 1.4,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 14),
          child: Column(
            children: [
              // Persistent flowchart on top only for main structure steps
              if (_currentStepIndex != 0 && _currentStepIndex != CProgramStructureStep.quiz.index && _currentStepIndex != CProgramStructureStep.summary.index)
                _buildFlowchart(context),
              if (_currentStepIndex != 0 &&
                  _currentStepIndex != CProgramStructureStep.quiz.index &&
                  _currentStepIndex != CProgramStructureStep.summary.index)
                const SizedBox(height: 16),

              // Animated step content
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: _buildStepContent(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                    onPressed: _isFirstStep ? null : _onPrevious,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _buttonBackColor(context),
                      foregroundColor: _buttonTextColor(context),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                    ),
                  ),
                  if (!_isLastStep)
                    ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Next'),
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _buttonNextBackColor(context),
                        foregroundColor: _buttonTextColor(context),
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                      ),
                    ),
                  if (_isLastStep)
                    ElevatedButton.icon(
                      icon: const Icon(Icons.check_circle),
                      label: const Text('Finish Now'),
                      onPressed: () => Navigator.of(context).maybePop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? Colors.green[700] : Colors.green[300],
                        foregroundColor: isDark ? Colors.greenAccent.shade100 : Colors.teal[900],
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
