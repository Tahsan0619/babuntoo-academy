import 'package:flutter/material.dart';
import 'dart:math';

enum EnumUnionStep {
  introEnums,
  whyEnums,
  enumSyntax,
  enumDefaultValues,
  enumExplicitAssignment,
  enumIncrementalProgression,
  enumUsageInCode,
  enumAdvantages,
  enumVsDefineConst,
  enumUsageExamples,
  introUnions,
  whyUnions,
  unionSyntax,
  unionMemoryLayout,
  unionAssignValues,
  unionReadMembers,
  unionWhenToUse,
  unionVsStruct,
  unionLimitations,
  unionUsageExamples,
  quiz,
  summary,
}

class EnumUnionPage extends StatefulWidget {
  @override
  _EnumUnionPageState createState() => _EnumUnionPageState();
}

class _EnumUnionPageState extends State<EnumUnionPage> with TickerProviderStateMixin {
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
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.2, 0),
      end: Offset.zero,
    ).animate(_fadeAnimation);

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
      // Reset quiz state on any step change
      _selectedAnswerIndex = null;
      _quizAnswered = false;
    });
    await _animController.forward();
  }

  void _onNext() {
    if (_currentStepIndex < EnumUnionStep.values.length - 1) {
      _goToStep(_currentStepIndex + 1);
    }
  }

  void _onPrevious() {
    if (_currentStepIndex > 0) {
      _goToStep(_currentStepIndex - 1);
    }
  }

  bool get _isFirstStep => _currentStepIndex == 0;
  bool get _isLastStep => _currentStepIndex == EnumUnionStep.values.length - 1;

  // Colors for dark/light mode and theming

  Color _textColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? const Color(0xFF7FFFD4) : Colors.black87;

  Color _annotationBgColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.green.withOpacity(0.15)
          : Colors.green.shade100;

  Color _annotationTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.shade100 : Colors.green.shade900;

  Color _flowChartTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.lightGreenAccent.shade100 : Colors.teal.shade900;

  Color _flowChartBoxColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.teal.shade800.withOpacity(0.3) : Colors.teal.shade50;

  Color _flowChartBorderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent.withOpacity(0.7) : Colors.green.shade200;

  Color _buttonTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent : Colors.teal.shade900;

  Color _buttonBackColor(BuildContext context, [int shade = 800]) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.teal[shade]! : Colors.teal[200]!;
  }

  Color _buttonNextBackColor(BuildContext context, [int shade = 900]) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.teal[shade]! : Colors.teal[400]!;
  }

  // Label text for flowchart steps (only major content steps)
  final List<EnumUnionStep> _flowchartSteps = [
    EnumUnionStep.introEnums,
    EnumUnionStep.whyEnums,
    EnumUnionStep.enumSyntax,
    EnumUnionStep.enumDefaultValues,
    EnumUnionStep.enumExplicitAssignment,
    EnumUnionStep.enumIncrementalProgression,
    EnumUnionStep.enumUsageInCode,
    EnumUnionStep.enumAdvantages,
    EnumUnionStep.enumVsDefineConst,
    EnumUnionStep.enumUsageExamples,
    EnumUnionStep.introUnions,
    EnumUnionStep.whyUnions,
    EnumUnionStep.unionSyntax,
    EnumUnionStep.unionMemoryLayout,
    EnumUnionStep.unionAssignValues,
    EnumUnionStep.unionReadMembers,
    EnumUnionStep.unionWhenToUse,
    EnumUnionStep.unionVsStruct,
    EnumUnionStep.unionLimitations,
    EnumUnionStep.unionUsageExamples,
    EnumUnionStep.quiz,
    EnumUnionStep.summary
  ];

  String _labelForStep(EnumUnionStep step) {
    switch (step) {
      case EnumUnionStep.introEnums: return 'Intro Enums';
      case EnumUnionStep.whyEnums: return 'Why Enums';
      case EnumUnionStep.enumSyntax: return 'Enum Syntax';
      case EnumUnionStep.enumDefaultValues: return 'Default Values';
      case EnumUnionStep.enumExplicitAssignment: return 'Explicit Assignment';
      case EnumUnionStep.enumIncrementalProgression: return 'Incremental Values';
      case EnumUnionStep.enumUsageInCode: return 'Usage In Code';
      case EnumUnionStep.enumAdvantages: return 'Advantages';
      case EnumUnionStep.enumVsDefineConst: return 'Enum Vs #define/const';
      case EnumUnionStep.enumUsageExamples: return 'Usage Examples';
      case EnumUnionStep.introUnions: return 'Intro Unions';
      case EnumUnionStep.whyUnions: return 'Why Unions';
      case EnumUnionStep.unionSyntax: return 'Union Syntax';
      case EnumUnionStep.unionMemoryLayout: return 'Memory Layout';
      case EnumUnionStep.unionAssignValues: return 'Assign Values';
      case EnumUnionStep.unionReadMembers: return 'Read Members';
      case EnumUnionStep.unionWhenToUse: return 'When to Use';
      case EnumUnionStep.unionVsStruct: return 'Union vs Struct';
      case EnumUnionStep.unionLimitations: return 'Limitations';
      case EnumUnionStep.unionUsageExamples: return 'Use Examples';
      case EnumUnionStep.quiz: return 'Quiz';
      case EnumUnionStep.summary: return 'Summary';
      default: return '';
    }
  }

  Widget _buildFlowchart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final txtClr = _flowChartTextColor(context);
    final boxClr = _flowChartBoxColor(context);
    final brdClr = _flowChartBorderColor(context);
    final activeClr = isDark ? Colors.tealAccent.shade200 : Colors.teal.shade700;

    return Container(
      color: isDark ? const Color(0xFF152a23) : const Color(0xFFE6F2ED),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_flowchartSteps.length, (index) {
            final step = _flowchartSteps[index];
            final bool isActive = step == EnumUnionStep.values[_currentStepIndex];
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    _goToStep(EnumUnionStep.values.indexOf(step));
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isActive ? activeClr.withOpacity(0.3) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isActive ? activeClr : brdClr,
                        width: isActive ? 2.5 : 1.4,
                      ),
                    ),
                    constraints: const BoxConstraints(minWidth: 100),
                    child: Text(
                      _labelForStep(step).toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        letterSpacing: 0.5,
                        color: isActive ? activeClr : txtClr,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (index < _flowchartSteps.length - 1)
                  Icon(Icons.arrow_forward_ios,
                      size: 14,
                      color: isDark ? Colors.tealAccent.shade100.withOpacity(0.7) : Colors.teal.shade300),
              ],
            );
          }),
        ),
      ),
    );
  }

  // Responsive widget to show explanation and code side-by-side on wide, stacked on narrow
  Widget _responsiveContent({required Widget explanation, Widget? code}) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 700) {
        // side by side
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
          color: isDark ? const Color(0xFF141A18) : const Color(0xFFF2FCF4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isDark ? Colors.green.shade900 : Colors.teal.shade200,
              width: 1.4)),
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SelectableText(
          code,
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
    return Container(
      decoration: BoxDecoration(
        color: _annotationBgColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(top: 12, bottom: 16),
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

  Widget _buildStepContent() {
    final EnumUnionStep step = EnumUnionStep.values[_currentStepIndex];

    // Return title, explanation widget (Column of Texts), optional code, optional annotations, and optional flowchart for intro steps
    // Each step has expanded explanations with at least 2 examples

    switch (step) {

    //
    // ENUM STEPS
    //
      case EnumUnionStep.introEnums:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'INTRODUCTION TO ENUMERATIONS',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: _textColor(context)),
            ),
            const SizedBox(height: 16),
            Text(
              'Enumerations (enums) are user-defined types consisting of a set of named integral constants. '
                  'They replace plain numbers with meaningful names improving clarity and safety in your code.',
              style: TextStyle(fontSize: 17, height: 1.5, color: _textColor(context)),
            ),
            const SizedBox(height: 12),
            Text(
              'Enums enable you to represent related values under one type name, such as days of the week, states, or options.',
              style: TextStyle(fontSize: 16, height: 1.4, fontWeight: FontWeight.w600, color: Colors.teal),
            ),
            const SizedBox(height: 18),
            _enumFlowChart(),
          ],
        );

      case EnumUnionStep.whyEnums:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WHY USE ENUMS?',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• Enums replace magic numbers in code, e.g., use MONDAY instead of 0, improving readability.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              const SizedBox(height: 8),
              Text(
                '• They reduce errors: using named constants helps prevent invalid values.',
                style: TextStyle(fontSize: 16, height: 1.4, color: _textColor(context)),
              ),
              const SizedBox(height: 12),
              Text(
                'Example 1:\nUsing integers for days of the week can be confusing and error-prone.\nUsing an enum makes conditions self-descriptive.',
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 12),
              Text(
                'Example 2:\nCode maintainability is easier when using enums because changes need to be done centrally.',
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          code: _codeBlock('''
// Without enum
int today = 3; // What day?

// Using enum
enum Weekday { Monday, Tuesday, Wednesday, Thursday, Friday }
Weekday today = Weekday.Wednesday;
'''),
        );

      case EnumUnionStep.enumSyntax:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ENUM DECLARATION SYNTAX',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• Use the keyword `enum` followed by an optional name and a brace-enclosed list of enumerators.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              const SizedBox(height: 10),
              Text(
                '• Each enumerator represents a named integral constant.',
                style: TextStyle(fontSize: 16, height: 1.4, color: _textColor(context)),
              ),
              const SizedBox(height: 12),
              Text(
                'Example 1: A simple enum for days:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'enum Weekday { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday };',
                style: TextStyle(fontFamily: "monospace", fontSize: 15, color: Colors.teal[700]),
              ),
              const SizedBox(height: 14),
              Text(
                'Example 2: Enum without a tag (anonymous) can be declared inside a struct or typedef.',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          code: _codeBlock('''
enum Color {
  Red,
  Green,
  Blue
};
'''),
        );

      case EnumUnionStep.enumDefaultValues:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DEFAULT VALUES OF ENUMS',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• Enum members receive integer values starting from 0, incremented by 1 automatically.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              const SizedBox(height: 16),
              Text(
                'Example 1:\nDays assigned values 0 to 6.',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
              ),
              const SizedBox(height: 10),
              Text(
                'Example 2:\nYou can manually check the underlying integer values at runtime by casting the enum.',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
              ),
            ],
          ),
          code: _codeBlock('''
enum Weekday { Monday, Tuesday, Wednesday };
  
printf("%d", Monday);    // 0
printf("%d", Wednesday); // 2
'''),
        );

      case EnumUnionStep.enumExplicitAssignment:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EXPLICIT VALUE ASSIGNMENT',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 12),
              Text(
                '• You can assign explicit integer values to some enum members.',
                style: TextStyle(fontSize: 16, height: 1.4, color: _textColor(context)),
              ),
              Text(
                '• Values not explicitly assigned automatically increment starting from the last assigned value.',
                style: TextStyle(fontSize: 16, height: 1.4, color: _textColor(context)),
              ),
              const SizedBox(height: 12),
              Text(
                'Example 1:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'enum Color { Red = 1, Green, Blue };',
                style: TextStyle(fontFamily: "monospace", fontSize: 15, color: Colors.teal[700]),
              ),
              const SizedBox(height: 8),
              Text(
                '→ Green is assigned 2, Blue gets 3 automatically.',
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[700]),
              ),
              const SizedBox(height: 12),
              Text(
                'Example 2:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'enum Status { Ok = 200, NotFound = 404 };',
                style: TextStyle(fontFamily: "monospace", fontSize: 15, color: Colors.teal[700]),
              ),
            ],
          ),
          code: _codeBlock('''
enum Color {
  Red = 1,
  Green,   // 2
  Blue     // 3
};
'''),
        );

      case EnumUnionStep.enumIncrementalProgression:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INCREMENTAL VALUE PROGRESSION',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• When some enum members get explicit values, unassigned members increment from the last assigned value.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              const SizedBox(height: 8),
              Text(
                'Example 1:\nIn `enum { A=3, B, C }`, A=3, B=4, C=5.',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
              ),
              const SizedBox(height: 8),
              Text(
                'Example 2:\nYou can mix assigned values and unassigned members freely in enum declarations.',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
              ),
            ],
          ),
          code: _codeBlock('''
enum Numbers {
  Zero = 0,
  One = 1,
  Five = 5,
  Six,           // 6
  Seven          // 7
};
'''),
        );

      case EnumUnionStep.enumUsageInCode:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'USING ENUM VALUES IN CODE',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• Enum values can be assigned to variables and used in control statements.',
                style: TextStyle(fontSize: 16, height: 1.4, color: _textColor(context)),
              ),
              const SizedBox(height: 10),
              Text(
                'Example 1: Using enum in conditional statements.',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'enum Day { Monday, Tuesday };\nDay today = Monday;\nif (today == Tuesday) {\n  // do something\n}',
                style: TextStyle(fontFamily: "monospace", fontSize: 15, color: Colors.teal[700]),
              ),
              const SizedBox(height: 12),
              Text(
                'Example 2: Using enum in switch case for state machines.',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'switch(state) {\n case Idle:\n   // ...\n   break;\n case Running:\n   // ...\n   break;\n}',
                style: TextStyle(fontFamily: "monospace", fontSize: 15, color: Colors.teal[700]),
              ),
            ],
          ),
          code: _codeBlock('''
enum Day { Monday, Tuesday };

Day today = Monday;

if (today == Tuesday) {
  // ...
}
'''),
        );

      case EnumUnionStep.enumAdvantages:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ADVANTAGES: CODE CLARITY',
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• Enums replace numbers with meaningful names reducing mistakes.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              const SizedBox(height: 8),
              Text(
                '• They make switch/case and conditionals easier to read and maintain.',
                style: TextStyle(fontSize: 16, height: 1.4, color: _textColor(context)),
              ),
              const SizedBox(height: 10),
              Text(
                'Example 1:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'switch(day) {\n  case Monday:\n    // ...\n    break;\n  // ...\n}',
                style: TextStyle(fontFamily: "monospace", fontSize: 15, color: Colors.teal[800]),
              ),
              const SizedBox(height: 10),
              Text(
                'Example 2: Better self-documenting code.',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'if (status == Status.Ok) { ... } // instead of if (status == 200)',
                style: TextStyle(fontFamily: "monospace", fontSize: 15, color: Colors.teal[800]),
              ),
            ],
          ),
          code: null,
        );

      case EnumUnionStep.enumVsDefineConst:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ENUM VS #DEFINE OR CONST',
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• Enums provide scoped, typed named constants grouped under one type.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              Text(
                '• #define creates untyped global macros which can cause naming conflicts.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              Text(
                '• const variables are typed but best for singular constants, not grouped values.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              const SizedBox(height: 12),
              Text(
                'Example 1:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                '#define RED 1\nconst int Red = 1;\nenum Color { Red, Green };',
                style: TextStyle(fontFamily: "monospace", fontSize: 15, color: Colors.teal[700]),
              ),
              const SizedBox(height: 10),
              Text(
                'Example 2: Avoiding macro pollution with enums.',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          code: null,
        );

      case EnumUnionStep.enumUsageExamples:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PRACTICAL USAGE EXAMPLES',
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                'Common enum use cases:',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              const SizedBox(height: 8),
              Text(
                '1. Days of the week',
                style: TextStyle(fontSize: 16, height: 1.3),
              ),
              Text(
                '2. Menu options in UI',
                style: TextStyle(fontSize: 16, height: 1.3),
              ),
              Text(
                '3. States in a state machine',
                style: TextStyle(fontSize: 16, height: 1.3),
              ),
              Text(
                '4. Flag or mode values',
                style: TextStyle(fontSize: 16, height: 1.3),
              ),
              const SizedBox(height: 14),
              Text(
                'Example 1:\nDefining days of a week enum and usage in switch statement.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 10),
              Text(
                'Example 2:\nDefining states for network connection using enums.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          code: _codeBlock('''
enum NetworkState {
  Disconnected,
  Connecting,
  Connected,
  Disconnecting
};

switch(state) {
  case Connecting:
    // show spinner
    break;
  case Connected:
    // show content
    break;
  // ...
}
'''),
        );

    //
    // UNION STEPS
    //

      case EnumUnionStep.introUnions:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'INTRODUCTION TO UNIONS',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: _textColor(context)),
            ),
            const SizedBox(height: 16),
            Text(
              'Unions are special data types where all members share the same memory location. '
                  'Only one member can hold a meaningful value at a time.',
              style: TextStyle(fontSize: 17, height: 1.5, color: _textColor(context)),
            ),
            const SizedBox(height: 12),
            Text(
              'They save memory when variables need to hold various types but never simultaneously.',
              style: TextStyle(fontSize: 16, height: 1.4, fontWeight: FontWeight.w600, color: Colors.teal),
            ),
            const SizedBox(height: 18),
            _unionFlowChart(),
          ],
        );

      case EnumUnionStep.whyUnions:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WHY USE UNIONS?',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• Unions save memory by overlaying different types occupying the same memory space.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              const SizedBox(height: 8),
              Text(
                '• Useful when a variable can hold different types but only one value at a time.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              const SizedBox(height: 12),
              Text(
                'Example 1:\nUsing unions to access the same data as int or float.',
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 10),
              Text(
                'Example 2:\nSaving memory in protocols with variable message formats.',
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          code: _codeBlock('''
union Data {
  int i;
  float f;
  char str[20];
};

union Data d;
d.i = 10;
d.f = 220.5;
'''),
        );

      case EnumUnionStep.unionSyntax:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UNION DECLARATION SYNTAX',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• Declared with the keyword `union` followed by members enclosed in braces.',
                style: TextStyle(fontSize: 16, height: 1.4, color: _textColor(context)),
              ),
              const SizedBox(height: 10),
              Text(
                'Example 1:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'union Data {\n  int i;\n  float f;\n  char str[20];\n};',
                style: TextStyle(fontFamily: "monospace", fontSize: 15, color: Colors.teal[700]),
              ),
              const SizedBox(height: 10),
              Text(
                'Example 2: Access union members, but only one at a time.',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          code: _codeBlock('''
union Data d;
d.i = 10;      // sets integer
d.f = 3.14;    // now float overwrites integer
printf("%d", d.i);    // undefined behavior
'''),
        );

      case EnumUnionStep.unionMemoryLayout:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MEMORY LAYOUT OF UNIONS',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• The union size equals that of its largest member.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              const SizedBox(height: 10),
              Text(
                '• All members overlay the same memory space; writing to one affects all.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                'Example 1:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'If the largest member is char str[20], the union size is at least 20 bytes.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 10),
              Text(
                'Example 2:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'Memory is shared: writing int then reading char array leads to unexpected results.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          code: null,
        );

      case EnumUnionStep.unionAssignValues:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ASSIGNING VALUES TO UNION MEMBERS',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• Only one member can hold a meaningful value at a time.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              Text(
                '• Assigning to one member overwrites the others\' data.',
                style: TextStyle(fontSize: 16, height: 1.4, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                'Example 1:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'union Data d;\nd.i = 10;\nd.f = 3.14; // overwrites i',
                style: TextStyle(fontFamily: "monospace", fontSize: 15, color: Colors.teal[700]),
              ),
              const SizedBox(height: 10),
              Text(
                'Example 2:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'You must track which member is valid at any time for correctness.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          code: null,
        );

      case EnumUnionStep.unionReadMembers:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'READING UNION MEMBERS',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• Reading a member that was not last assigned causes undefined behavior and unpredictable results.',
                style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context)),
              ),
              const SizedBox(height: 10),
              Text(
                'Example 1:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'd.i = 5;\nprintf("%f", d.f); // undefined behavior',
                style: TextStyle(fontFamily: "monospace", fontSize: 15, color: Colors.teal[700]),
              ),
              const SizedBox(height: 8),
              Text(
                'Example 2:\nAccess only the last written member to avoid bugs.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          code: null,
        );

      case EnumUnionStep.unionWhenToUse:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WHEN TO USE UNIONS',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 16),
              Text(
                '• Low-level programming managing hardware registers.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              Text(
                '• Handling messages with variable content interpreted differently depending on context.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              Text(
                '• Saving memory in variant data structures like tagged unions.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 12),
              Text(
                'Example 1:\nA union used to read/write the same memory space as int or float.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 10),
              Text(
                'Example 2:\nNode structures where data type varies and is indicated by a separate flag.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          code: null,
        );

      case EnumUnionStep.unionVsStruct:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UNION VS STRUCT',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• Struct members each occupy their own space; memory size is sum of all members plus padding.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              Text(
                '• Union members overlap; memory size equals the largest member.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              Text(
                '• Struct allows simultaneous storage of all members while union stores only one value at a time.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 10),
              Text(
                'Example:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'struct S { int i; char c; };\nunion U { int i; char c; };',
                style: TextStyle(fontFamily: "monospace", fontSize: 15),
              ),
            ],
          ),
          code: null,
        );

      case EnumUnionStep.unionLimitations:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LIMITATIONS & RISKS OF UNIONS',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 14),
              Text(
                '• Reading inactive union members causes undefined behavior.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              Text(
                '• Hard to track valid member without explicit metadata (tagged unions help).',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              Text(
                '• Careless use can cause subtle bugs and data corruption.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 12),
              Text(
                'Best Practice:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Keep track of which union member is active, use enums or flags alongside unions.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          code: null,
        );

      case EnumUnionStep.unionUsageExamples:
        return _responsiveContent(
          explanation: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PRACTICAL USAGE EXAMPLES',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: _textColor(context)),
              ),
              const SizedBox(height: 12),
              Text(
                '• Protocol implementations with variable data formats.',
                style: TextStyle(fontSize: 16, height: 1.3),
              ),
              Text(
                '• Embedded systems with memory constraints.',
                style: TextStyle(fontSize: 16, height: 1.3),
              ),
              Text(
                '• Parsers that interpret variable payloads.',
                style: TextStyle(fontSize: 16, height: 1.3),
              ),
              const SizedBox(height: 10),
              Text(
                'Example:\nUnion for storing different sensor data types in the same memory space.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          code: _codeBlock('''
union SensorData {
  int count;
  float temp;
  char label[10];
};

union SensorData data;
data.count = 100;
'''),
        );

      case EnumUnionStep.quiz:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QUIZ: IDENTIFY THE CORRECT OUTPUT',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                  color: _textColor(context)),
            ),
            const SizedBox(height: 16),
            Text(
              'Given this code snippet, what is the expected output?',
              style: TextStyle(fontSize: 17, height: 1.5, color: _textColor(context)),
            ),
            const SizedBox(height: 14),
            _codeBlock('''
union Data {
  int i;
  float f;
};

int main() {
  union Data d;
  d.i = 42;
  d.f = 3.14f;
  printf("%d", d.i);
  return 0;
}
'''),
            const SizedBox(height: 14),
            Column(
              children: List.generate(_quizOptions.length, (idx) {
                Color? btnColor;
                if (_quizAnswered) {
                  if (idx == _correctAnswerIndex) {
                    btnColor = Colors.green;
                  } else if (_selectedAnswerIndex == idx) {
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
                        color: (_selectedAnswerIndex == idx) ? Theme.of(context).colorScheme.primary : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    onPressed: _quizAnswered
                        ? null
                        : () {
                      setState(() {
                        _selectedAnswerIndex = idx;
                        _quizAnswered = true;
                      });
                    },
                    child: Text(
                      _quizOptions[idx],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }),
            ),
            if (_quizAnswered)
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                child: Text(
                  _selectedAnswerIndex == _correctAnswerIndex
                      ? 'Correct! The integer member value is overwritten by the float assignment. Printing d.i after assigning to d.f is undefined and usually unexpected.'
                      : 'Try again. Assigning to d.f overwrites d.i. So printing d.i will output unpredictable results.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _selectedAnswerIndex == _correctAnswerIndex ? Colors.green : Colors.red[700],
                  ),
                ),
              )
          ],
        );

      case EnumUnionStep.summary:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SUMMARY & BEST PRACTICES',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                  color: _textColor(context)),
            ),
            const SizedBox(height: 16),
            Text(
              '• Enums improve code clarity by giving names to integral constants.',
              style: TextStyle(fontSize: 17, height: 1.5, color: _textColor(context)),
            ),
            const SizedBox(height: 8),
            Text(
              '• Enums give you type-safety and group related constants.',
              style: TextStyle(fontSize: 17, height: 1.5, color: _textColor(context)),
            ),
            const SizedBox(height: 8),
            Text(
              '• Unions share memory among members, saving space, but only one member is valid at a time.',
              style: TextStyle(fontSize: 17, height: 1.5, color: _textColor(context)),
            ),
            const SizedBox(height: 8),
            Text(
              '• Always track which union member currently holds valid data to avoid undefined behavior.',
              style: TextStyle(fontSize: 17, height: 1.5, color: _textColor(context)),
            ),
            const SizedBox(height: 8),
            Text(
              '• Use enums and unions responsibly to write safe, readable, and efficient C code.',
              style: TextStyle(fontSize: 17, height: 1.5, color: _textColor(context)),
            ),
          ],
        );

    //
    // Default fallback
    //
      default:
        return const SizedBox.shrink();
    }
  }

  // Quiz options and correct answer index
  final List<String> _quizOptions = [
    'A. 42',
    'B. 3',
    'C. 3.14',
    'D. Undefined/garbage value',
  ];

  final int _correctAnswerIndex = 3;

  // Flowcharts for introductory steps
  Widget _enumFlowChart() {
    final txtClr = _flowChartTextColor(context);
    final boxClr = _flowChartBoxColor(context);
    final brdClr = _flowChartBorderColor(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: boxClr,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: brdClr, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ENUM CONCEPT FLOWCHART',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: txtClr),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 20,
            runSpacing: 14,
            alignment: WrapAlignment.center,
            children: [
              _flowChartBox('Enum Declaration', txtClr, boxClr, brdClr),
              _flowChartArrow(txtClr),
              _flowChartBox('Members get integer values', txtClr, boxClr, brdClr),
              _flowChartArrow(txtClr),
              _flowChartBox('Used as named constants', txtClr, boxClr, brdClr),
            ],
          ),
        ],
      ),
    );
  }

  Widget _unionFlowChart() {
    final txtClr = _flowChartTextColor(context);
    final boxClr = _flowChartBoxColor(context);
    final brdClr = _flowChartBorderColor(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: boxClr,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: brdClr, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UNION CONCEPT FLOWCHART',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: txtClr),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 20,
            runSpacing: 14,
            children: [
              _flowChartBox('All members share memory', txtClr, boxClr, brdClr),
              _flowChartArrow(txtClr),
              _flowChartBox('Only one member holds valid data', txtClr, boxClr, brdClr),
              _flowChartArrow(txtClr),
              _flowChartBox('Memory size = largest member', txtClr, boxClr, brdClr),
            ],
          ),
        ],
      ),
    );
  }

  Widget _flowChartBox(String text, Color textColor, Color bgColor, Color borderColor) =>
      Container(
        width: 160,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.3),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      );

  Widget _flowChartArrow(Color color) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Icon(Icons.arrow_forward, color: color, size: 26),
  );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final horizontalPadding = MediaQuery.of(context).size.width < 600 ? 10.0 : 28.0;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        title: Text('ENUM AND UNION IN C',
            style: TextStyle(
                color: isDark ? Colors.greenAccent : Colors.teal[900],
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4)),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black87 : Colors.teal[100],
        iconTheme: IconThemeData(color: isDark ? Colors.greenAccent : Colors.teal[900]),
        elevation: 1.4,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
          child: Column(
            children: [
              _buildFlowchart(context),
              const SizedBox(height: 14),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SingleChildScrollView(
                      child: _buildStepContent(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
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
