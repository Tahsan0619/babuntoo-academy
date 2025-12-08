import 'package:flutter/material.dart';

enum MemoryAllocStep {
  intro,
  stackVsHeap,
  whyDynamic,
  cStdLibFuncs,
  mallocPurpose,
  callocPurpose,
  mallocSyntax,
  mallocReturn,
  mallocCast,
  mallocExample,
  callocSyntax,
  mallocVsCalloc,
  callocExample,
  nullCheck,
  accessingMemory,
  pointerArithmetic,
  storeModifyAlloc,
  uninitMistake,
  needRealloc,
  reallocSyntax,
  reallocBehavior,
  reallocExample,
  reallocPitfall,
  freeImportance,
  freeSyntax,
  afterFree,
  setNull,
  allocStruct,
  linkedData,
  allocErrorHandling,
  fragmentation,
  leakDetection,
  summary,
  quiz,
  commonBugs,
  challenge,
}

class MemoryAllocPage extends StatefulWidget {
  const MemoryAllocPage({Key? key}) : super(key: key);

  @override
  State<MemoryAllocPage> createState() => _MemoryAllocPageState();
}

class _MemoryAllocPageState extends State<MemoryAllocPage>
    with SingleTickerProviderStateMixin {
  MemoryAllocStep _step = MemoryAllocStep.intro;

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
    _slideAnimation = Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  Future<void> _gotoStep(MemoryAllocStep newStep, {bool forward = true}) async {
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
    if (_step.index < MemoryAllocStep.values.length - 1) {
      _gotoStep(MemoryAllocStep.values[_step.index + 1], forward: true);
    }
  }

  void _previousStep() {
    if (_step.index > 0) {
      _gotoStep(MemoryAllocStep.values[_step.index - 1], forward: false);
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
        color: (Theme.of(context).brightness == Brightness.dark ? Colors.amberAccent.shade100 : Colors.teal.shade200).withOpacity(0.4),
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

  static const Map<MemoryAllocStep, Map<String, dynamic>> _stepsData = {
    MemoryAllocStep.intro: {
      'title': 'INTRODUCTION TO DYNAMIC MEMORY ALLOCATION',
      'content': 'Dynamic memory allows you to request memory during your program\'s execution instead of fixed size. It\'s useful when data size is not known before compile time or might change.',
      'code': null,
      'annotation': 'Dynamic allocation increases flexibility and resource efficiency.',
    },
    MemoryAllocStep.stackVsHeap: {
      'title': 'STACK VS HEAP MEMORY',
      'content': 'Stack memory stores local variables with automatic scope and limited size. Heap memory is manually managed and used for data needing variable or long lifetimes.',
      'code': null,
      'annotation': 'Stack overflow is easier to detect; heap misuse can cause leaks or fragmentation.',
    },
    MemoryAllocStep.whyDynamic: {
      'title': 'WHY USE DYNAMIC MEMORY ALLOCATION?',
      'content': 'To handle variable size data, large datasets, or data structures like linked lists and trees whose sizes are not fixed.',
      'code': null,
      'annotation': 'Dynamic memory enables scalable, data-driven programs.',
    },
    MemoryAllocStep.cStdLibFuncs: {
      'title': 'C STANDARD LIBRARY MEMORY FUNCTIONS',
      'content': 'The four main functions for memory management in C are malloc(), calloc(), realloc(), and free().',
      'code': null,
      'annotation': 'You must use these carefully to avoid leaks and undefined behavior.',
    },
    MemoryAllocStep.mallocPurpose: {
      'title': 'THE malloc() FUNCTION PURPOSE',
      'content': 'Allocates a memory block of requested bytes and returns a pointer to its first byte.',
      'code': 'void *malloc(size_t size);',
      'annotation': 'malloc() does not initialize memory; it contains garbage.',
    },
    MemoryAllocStep.callocPurpose: {
      'title': 'THE calloc() FUNCTION PURPOSE',
      'content': 'Allocates memory for an array of elements and initializes all bytes to zero.',
      'code': 'void *calloc(size_t num, size_t size);',
      'annotation': 'Use calloc() when you need zero-initialized memory.',
    },
    MemoryAllocStep.mallocSyntax: {
      'title': 'SYNTAX OF malloc()',
      'content': 'Typical usage example:',
      'code': 'int *arr = (int*) malloc(10 * sizeof(int));',
      'annotation': 'In C casting malloc() return is optional, but explicit in C++.',
    },
    MemoryAllocStep.mallocReturn: {
      'title': 'RETURN VALUE OF malloc()',
      'content': 'Returns a void pointer to the allocated block or NULL if allocation fails.',
      'code': null,
      'annotation': 'Always check for NULL to avoid crashes.',
    },
    MemoryAllocStep.mallocCast: {
      'title': 'CASTING malloc() RETURN VALUE',
      'content': 'Casting `void*` to appropriate pointer type makes code clearer or compliant in C++.',
      'code': 'int *ptr = (int*) malloc(5 * sizeof(int));',
    },
    MemoryAllocStep.mallocExample: {
      'title': 'EXAMPLE: ALLOCATING MEMORY USING malloc()',
      'content': 'Allocate single int and array, assign values:',
      'code': '''
int *ptr = (int*)malloc(sizeof(int));
if (ptr) {
  *ptr = 10;
}

int *arr = (int*)malloc(5 * sizeof(int));
if (arr) {
  arr[0] = 1;
}
''',
      'annotation': 'Always check pointers before use.',
    },
    MemoryAllocStep.callocSyntax: {
      'title': 'SYNTAX OF calloc()',
      'content': 'Allocate and zero-initialize an array:',
      'code': 'int *arr = (int*) calloc(10, sizeof(int));',
    },
    MemoryAllocStep.mallocVsCalloc: {
      'title': 'DIFFERENCE BETWEEN malloc() AND calloc()',
      'content': 'malloc() allocates uninitialized memory; calloc() allocates and zeros memory.',
      'annotation': 'calloc() is safer if you need zero values initially.',
    },
    MemoryAllocStep.callocExample: {
      'title': 'EXAMPLE: USING calloc()',
      'content': 'All array elements start as zero.',
      'code': '''
int *arr = (int*) calloc(5, sizeof(int));
// arr[0] ... arr[4] == 0
''',
    },
    MemoryAllocStep.nullCheck: {
      'title': 'CHECKING NULL AFTER ALLOCATION',
      'content': 'Always verify malloc/calloc return before use to prevent dereferencing NULL.',
      'code': '''
int *arr = (int*) malloc(10 * sizeof(int));
if (arr == NULL) {
  // handle allocation failure
}
''',
      'annotation': 'Failure handling is critical in robust programs.',
    },
    MemoryAllocStep.accessingMemory: {
      'title': 'ACCESSING ALLOCATED MEMORY',
      'content': 'Use pointer dereference or array indexing: *ptr, ptr[i]. Example:',
      'code': '''
ptr[0] = 42;
int val = *(ptr + 2);
''',
    },
    MemoryAllocStep.pointerArithmetic: {
      'title': 'POINTER ARITHMETIC AND ARRAYS',
      'content': 'Pointer arithmetic accesses consecutive elements: *(ptr + i) == ptr[i]',
      'code': null,
    },
    MemoryAllocStep.storeModifyAlloc: {
      'title': 'STORING AND MODIFYING VALUES',
      'content': 'Modify values using pointer or array syntax after allocation.',
      'code': null,
    },
    MemoryAllocStep.uninitMistake: {
      'title': 'MISTAKE: USING UNINITIALIZED MEMORY',
      'content': 'malloc() does not zero memory - uninitialized values may cause bugs if assumed zero.',
      'annotation': 'Use calloc() or initialize manually to avoid this.',
    },
    MemoryAllocStep.needRealloc: {
      'title': 'WHY USE realloc()?',
      'content': 'Resize allocated memory block to grow or shrink dynamically.',
    },
    MemoryAllocStep.reallocSyntax: {
      'title': 'realloc() SYNTAX',
      'content': 'void *realloc(void *ptr, size_t new_size);',
      'code': 'int *newArr = (int*) realloc(arr, 20 * sizeof(int));',
    },
    MemoryAllocStep.reallocBehavior: {
      'title': 'BEHAVIOR OF realloc()',
      'content': 'May move memory, return NULL on failure. Always assign to a temp pointer.',
      'annotation': 'Avoid losing original pointer on failure to prevent leaks.',
    },
    MemoryAllocStep.reallocExample: {
      'title': 'EXAMPLE: USING realloc() TO GROW ARRAY',
      'content': 'Double size, check for null:',
      'code': '''
int *arr = malloc(5 * sizeof(int));
int *tmp = realloc(arr, 10 * sizeof(int));
if (tmp != NULL) {
  arr = tmp;
}
''',
    },
    MemoryAllocStep.reallocPitfall: {
      'title': 'COMMON PITFALL: USING POINTER AFTER realloc() FAILURE',
      'content': 'If realloc returns NULL, original pointer remains valid. Don\'t overwrite original ptr before confirming success.',
    },
    MemoryAllocStep.freeImportance: {
      'title': 'WHY free() IS NECESSARY',
      'content': 'Memory allocated dynamically is NOT automatically freed. Omitting free() causes leaks.',
    },
    MemoryAllocStep.freeSyntax: {
      'title': 'SYNTAX OF free()',
      'content': 'void free(void *ptr); Releases allocated memory.',
      'code': 'free(arr);',
    },
    MemoryAllocStep.afterFree: {
      'title': 'BEHAVIOR AFTER free()',
      'content': 'Pointer is not reset! Dereferencing freed pointer causes undefined behavior.',
    },
    MemoryAllocStep.setNull: {
      'title': 'GOOD PRACTICE: SET POINTER NULL AFTER free()',
      'content': 'Avoid dangling pointers by setting ptr = NULL;',
      'code': '''
free(arr);
arr = NULL;
''',
    },
    MemoryAllocStep.allocStruct: {
      'title': 'ALLOCATING STRUCTURES DYNAMICALLY',
      'content': 'Example of allocating a structure:',
      'code': '''
typedef struct {
  int id;
  char name[40];
} Student;

Student *p = (Student*) malloc(sizeof(Student));
''',
    },
    MemoryAllocStep.linkedData: {
      'title': 'DYNAMIC MEMORY IN LINKED DATA STRUCTURES',
      'content': 'Linked lists and trees rely on dynamic memory to create and link nodes dynamically.',
    },
    MemoryAllocStep.allocErrorHandling: {
      'title': 'ERROR HANDLING IN MEMORY ALLOCATION',
      'content': 'Always check for NULL, and design recovery or termination logic safely.',
    },
    MemoryAllocStep.fragmentation: {
      'title': 'MEMORY FRAGMENTATION AND PERFORMANCE',
      'content': 'Fragmentation makes allocation slower and increases failure probability in long-running programs.',
    },
    MemoryAllocStep.leakDetection: {
      'title': 'TOOLS TO DETECT MEMORY LEAKS',
      'content': 'Valgrind, AddressSanitizer, and debuggers help track leaks and invalid memory usage.',
    },
    MemoryAllocStep.summary: {
      'title': 'SUMMARY AND BEST PRACTICES',
      'content': 'Use dynamic memory carefully: always check pointers, free what you allocate, avoid leaks, and initialize memory.',
    },
    MemoryAllocStep.quiz: {
      'title': 'QUIZ: DYNAMIC MEMORY BEHAVIOR',
      'content': 'Consider the given code snippets. Predict output and find issues.',
      'code': '''int *arr = malloc(3 * sizeof(int));
arr[0] = 10; arr[1] = 20; arr[2] = 30;
arr = realloc(arr, 5 * sizeof(int));
arr[3] = 40; arr[4] = 50;
for (int i = 0; i < 5; i++) printf("%d ", arr[i]);
free(arr);
// Output?''',
    },
    MemoryAllocStep.commonBugs: {
      'title': 'COMMON BUGS WITH DYNAMIC MEMORY',
      'content': 'Double free, dangling pointer, leak, uninitialized use, and realloc misuse are typical errors to avoid.',
    },
    MemoryAllocStep.challenge: {
      'title': 'CHALLENGE: IMPLEMENT RESIZABLE DYNAMIC ARRAY',
      'content': 'Write a function that doubles array size with realloc, tracks current capacity and size, and frees safely.',
    },
  };

  Widget _extraExplanation(BuildContext context, MemoryAllocStep step) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (step) {
      case MemoryAllocStep.intro:
        return Text(
          "Dynamic memory allocation lets your programs handle data whose size is unknown at compile time. "
              "It enables flexible algorithms and data structures that grow/shrink at runtime, improving efficiency.\n\n"
              "Without dynamic memory, you'd be stuck with fixed sizes or need complex static workarounds, limiting program flexibility.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case MemoryAllocStep.mallocExample:
        return Text(
          "In these examples, we allocate memory for single variables and arrays. "
              "Always check if malloc returns NULL to avoid accessing invalid memory.\n\n"
              "Also remember that malloc does NOT initialize memory, so values are undefined until assigned.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case MemoryAllocStep.reallocExample:
        return Text(
          "The realloc example shows growing an integer array to hold more elements. "
              "Storing the returned pointer in a temporary variable before assigning helps avoid losing original data on failure.\n\n"
              "This pattern is critical to robust dynamic array implementations.",
          style: TextStyle(fontSize: 14, height: 1.4, color: isDark ? Colors.white70 : Colors.black87),
        );
      case MemoryAllocStep.quiz:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What will the printed output be after reallocating and assigning the new elements? Will there be any issues?",
              style: TextStyle(fontSize: 14, height: 1.4, color: _textColor(context)),
            ),
            const SizedBox(height: 10),
            Text(
              "Choose an answer below:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly ? null : () {
                    setState(() {
                      _quizFeedback = "Correct! The output will be: 10 20 30 40 50";
                      _quizAnsweredCorrectly = true;
                    });
                  },
                  child: const Text("10 20 30 40 50"),
                ),
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly ? null : () {
                    setState(() {
                      _quizFeedback = "Incorrect. realloc either extends or moves the block preserving old content.";
                    });
                  },
                  child: const Text("Undefined or garbage values"),
                ),
                ElevatedButton(
                  onPressed: _quizAnsweredCorrectly ? null : () {
                    setState(() {
                      _quizFeedback = "Incorrect. There is no immediate memory leak in this code snippet.";
                    });
                  },
                  child: const Text("Memory leak immediately after realloc"),
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
    final stepData = _stepsData[_step]!;
    final explanationWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(stepData['content'], style: TextStyle(fontSize: 16, height: 1.5, color: _textColor(context))),
        const SizedBox(height: 16),
        _extraExplanation(context, _step),
        if (stepData['annotation'] != null) _annotationBox(context, stepData['annotation']),
      ],
    );

    final code = stepData['code'];
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
          ]
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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, height: 1.3, color: _annotationTextColor(context)),
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
          children: MemoryAllocStep.values.map((step) {
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
    final isLast = _step.index == MemoryAllocStep.values.length - 1;
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
          'Dynamic Memory in C',
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
              // Persistent flowchart bar
              _buildFlowChart(context),
              const SizedBox(height: 8),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title uppercase large
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

              // Navigation buttons with spacing
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: _buildNavigationButtons(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
