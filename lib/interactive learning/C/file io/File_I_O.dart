import 'package:flutter/material.dart';

enum FileIOStep {
  intro,
  fileTypes,
  stdlib,
  filePointer,
  fopen,
  fileModes,
  fopenCheck,
  fclose,
  fgetc,
  fgets,
  feof,
  fscanf,
  fread,
  exampleCharByChar,
  exampleLineByLine,
  readErrorHandling,
  fputc,
  fputs,
  fprintf,
  fwrite,
  overwriteVsAppend,
  exampleCreateWrite,
  exampleAppend,
  writeErrorHandling,
  fseek,
  ftell,
  rewind,
  randomReadWrite,
  binReadWriteStructs,
  tmpfileUsage,
  fflush,
  filePermissions,
  debugTips,
  summary,
  quiz,
}

class FileIOPage extends StatefulWidget {
  @override
  _FileIOPageState createState() => _FileIOPageState();
}

class _FileIOPageState extends State<FileIOPage> with TickerProviderStateMixin {
  int _currentStepIndex = 0;
  final List<FileIOStep> _steps = FileIOStep.values;

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int? _selectedQuizChoice;
  String? _quizFeedback;

  final List<_QuizChoice> _quizChoices = [
    _QuizChoice(
      'No error; prints contents of "data.txt" line by line.',
      true,
    ),
    _QuizChoice(
      'Error: fclose(fp) is missing.',
      false,
    ),
    _QuizChoice(
      'Error: Buffer size too small for fgets.',
      false,
    ),
    _QuizChoice(
      'Error: Incorrect file mode for writing.',
      false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _fadeAnimation = CurvedAnimation(parent: _animController, curve: Curves.easeInOutCubic);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(_fadeAnimation);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  FileIOStep get _currentStep => _steps[_currentStepIndex];

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

  String _stepTitle(FileIOStep step) {
    switch (step) {
      case FileIOStep.intro:
        return 'INTRODUCTION';
      case FileIOStep.fileTypes:
        return 'FILE TYPES OVERVIEW';
      case FileIOStep.stdlib:
        return 'C STANDARD LIBRARY FILE HANDLING';
      case FileIOStep.filePointer:
        return 'FILE POINTER (FILE *)';
      case FileIOStep.fopen:
        return 'OPENING FILE - fopen()';
      case FileIOStep.fileModes:
        return 'FILE MODES';
      case FileIOStep.fopenCheck:
        return 'CHECKING FILE OPEN SUCCESS';
      case FileIOStep.fclose:
        return 'CLOSING FILE - fclose()';
      case FileIOStep.fgetc:
        return 'READING WITH fgetc()';
      case FileIOStep.fgets:
        return 'READING LINE WITH fgets()';
      case FileIOStep.feof:
        return 'END-OF-FILE CHECK - feof()';
      case FileIOStep.fscanf:
        return 'FORMATTED READ - fscanf()';
      case FileIOStep.fread:
        return 'BINARY READ - fread()';
      case FileIOStep.exampleCharByChar:
        return 'EXAMPLE: CHAR-BY-CHAR READ';
      case FileIOStep.exampleLineByLine:
        return 'EXAMPLE: LINE-BY-LINE READ';
      case FileIOStep.readErrorHandling:
        return 'ERROR HANDLING WHEN READING';
      case FileIOStep.fputc:
        return 'WRITE CHAR - fputc()';
      case FileIOStep.fputs:
        return 'WRITE STRING - fputs()';
      case FileIOStep.fprintf:
        return 'FORMATTED WRITE - fprintf()';
      case FileIOStep.fwrite:
        return 'BINARY WRITE - fwrite()';
      case FileIOStep.overwriteVsAppend:
        return 'OVERWRITE VS APPEND';
      case FileIOStep.exampleCreateWrite:
        return 'EXAMPLE: CREATE & WRITE';
      case FileIOStep.exampleAppend:
        return 'EXAMPLE: APPEND DATA';
      case FileIOStep.writeErrorHandling:
        return 'ERROR HANDLING WHEN WRITING';
      case FileIOStep.fseek:
        return 'FILE POSITIONING - fseek()';
      case FileIOStep.ftell:
        return 'FILE POSITION QUERY - ftell()';
      case FileIOStep.rewind:
        return 'RESET FILE POSITION - rewind()';
      case FileIOStep.randomReadWrite:
        return 'RANDOM ACCESS READ/WRITE';
      case FileIOStep.binReadWriteStructs:
        return 'BINARY READ/WRITE STRUCTS';
      case FileIOStep.tmpfileUsage:
        return 'TEMP FILES - tmpfile()';
      case FileIOStep.fflush:
        return 'FLUSHING BUFFERS - fflush()';
      case FileIOStep.filePermissions:
        return 'FILE PERMISSIONS & PORTABILITY';
      case FileIOStep.debugTips:
        return 'COMMON ERRORS & DEBUGGING';
      case FileIOStep.summary:
        return 'SUMMARY & BEST PRACTICES';
      case FileIOStep.quiz:
        return 'QUIZ';
    }
  }

  String _infoTextForStep(FileIOStep step) {
    switch (step) {
      case FileIOStep.intro:
        return 'File I/O (Input/Output) allows programs to read from and write to files. Files store data persistently on storage devices, unlike console I/O which is temporary.';
      case FileIOStep.fileTypes:
        return 'Files are generally text files (human-readable characters) or binary files (raw byte data). Each requires different handling methods.';
      case FileIOStep.stdlib:
        return 'C provides standard file functions in <stdio.h> like fopen, fclose, fread, fwrite, etc., for managing file operations.';
      case FileIOStep.filePointer:
        return 'FILE * is a pointer to a FILE structure representing an open file stream used to perform operations on the file.';
      case FileIOStep.fopen:
        return 'fopen() opens a file with a given mode like read ("r"), write ("w"), append ("a"), and returns a FILE pointer for further operations.';
      case FileIOStep.fileModes:
        return 'Common modes include "r" (read), "w" (write), "a" (append), "r+" (read/update), "w+" (write/update), and "a+" (append/update).';
      case FileIOStep.fopenCheck:
        return 'fopen() returns NULL if the file opening failed; always check this to handle errors safely.';
      case FileIOStep.fclose:
        return 'fclose() closes an open file to flush buffers and free associated resources; it should always be called after finishing file operations.';
      case FileIOStep.fgetc:
        return 'fgetc() reads a single character from an open file stream, returning EOF at the end of file.';
      case FileIOStep.fgets:
        return 'fgets() reads a whole line or up to a specified size from a file stream into a buffer safely.';
      case FileIOStep.feof:
        return 'feof() checks whether the end of the file has been reached to avoid infinite reading loops.';
      case FileIOStep.fscanf:
        return 'fscanf() reads data from a file stream based on format specifiers, similar to scanf().';
      case FileIOStep.fread:
        return 'fread() reads a block of binary data from a file, useful for non-text files or structures.';
      case FileIOStep.exampleCharByChar:
        return 'Read each character sequentially from a file and display or process.';
      case FileIOStep.exampleLineByLine:
        return 'Use fgets in a loop to read and process one line of text at a time.';
      case FileIOStep.readErrorHandling:
        return 'Check return values of fread, fgets, and handle errors with ferror() or checking NULL pointers to avoid data corruption.';
      case FileIOStep.fputc:
        return 'Writes a single character to a file stream.';
      case FileIOStep.fputs:
        return 'Writes a null-terminated string to a file stream (no formatting).';
      case FileIOStep.fprintf:
        return 'Writes formatted data to a file stream (like printf).';
      case FileIOStep.fwrite:
        return 'Writes blocks of raw memory data to a file (e.g., structures or arrays).';
      case FileIOStep.overwriteVsAppend:
        return '"w" mode truncates the file before writing, while "a" mode adds data to the end.';
      case FileIOStep.exampleCreateWrite:
        return 'Open a file in "w" mode and write text data using fputs or fprintf.';
      case FileIOStep.exampleAppend:
        return 'Open a file in "a" mode and append new data without erasing previous content.';
      case FileIOStep.writeErrorHandling:
        return 'Check return values of write functions and use ferror to detect issues.';
      case FileIOStep.fseek:
        return 'Move the file read/write pointer to a specific offset relative to origin.';
      case FileIOStep.ftell:
        return 'Retrieve the current position of the file pointer in the stream.';
      case FileIOStep.rewind:
        return 'Reset the file pointer to the beginning of the file.';
      case FileIOStep.randomReadWrite:
        return 'Use fseek and ftell to read/write at arbitrary positions without looping.';
      case FileIOStep.binReadWriteStructs:
        return 'Read/write structured data directly in binary format with fread and fwrite.';
      case FileIOStep.tmpfileUsage:
        return 'tmpfile() creates a temporary file automatically deleted on program exit, useful for transient data.';
      case FileIOStep.fflush:
        return 'Flushes buffered output to the file. Important for ensuring data is written promptly.';
      case FileIOStep.filePermissions:
        return '''File access permissions depend on the operating system (OS) settings.
Always ensure your program has the right to read, write, or modify files.

Portable code should handle failures due to permission issues gracefully.
Check fopen and related calls for NULL return to detect permission-denied errors.''';

      case FileIOStep.debugTips:
        return '''Common File I/O errors:
- Forgetting to close files (fclose).
- Not checking return values or error flags (ferror).
- Buffer overflows when reading lines (buffer size too small).
- Using incorrect file modes ("r" vs "w" vs "a").
- Reading/writing beyond file bounds.
Always validate file pointers and handle errors to avoid undefined behavior.
Use debugging prints/logs to trace file operation failures.''';

      case FileIOStep.summary:
        return '''File I/O in C enables persistent storage by reading and writing files.

Key points:
- Understand file modes to open files appropriately.
- Always check fopen return value.
- Use fclose to release resources.
- Familiarize with standard functions (fgetc, fgets, fread, fwrite).
- Handle errors and edge cases carefully.
- Remember OS permissions can affect file access.

With practice, file I/O becomes a powerful tool for data persistence in C programs.''';

      case FileIOStep.quiz:
        return '''Quiz: Given the following code snippet, identify if there is any error or what the output will be.

FILE *fp = fopen("data.txt", "r");
if (fp == NULL) {
  perror("File open failed");
  return -1;
}
char buf[100];
while (fgets(buf, sizeof(buf), fp)) {
  printf("%s", buf);
}
fclose(fp);
''';
    }
  }

  String? _codeForStep(FileIOStep step) {
    switch (step) {
      case FileIOStep.fopen:
        return 'FILE *fp = fopen("file.txt", "r");';
      case FileIOStep.fopenCheck:
        return '''
FILE *fp = fopen("file.txt", "r");
if (fp == NULL) {
  perror("Failed to open file");
  // handle error
}''';
      case FileIOStep.fclose:
        return 'fclose(fp);';
      case FileIOStep.fgetc:
        return 'int ch = fgetc(fp);';
      case FileIOStep.fgets:
        return 'fgets(buffer, sizeof(buffer), fp);';
      case FileIOStep.feof:
        return '''
while (!feof(fp)) {
  int ch = fgetc(fp);
  if (ch == EOF) break;
  // process ch
}''';
      case FileIOStep.fscanf:
        return 'fscanf(fp, "%d %s", &num, str);';
      case FileIOStep.fread:
        return 'size_t read = fread(buffer, sizeof(char), size, fp);';
      case FileIOStep.exampleCharByChar:
        return '''
int ch;
while ((ch = fgetc(fp)) != EOF) {
  putchar(ch);
}''';
      case FileIOStep.exampleLineByLine:
        return '''
char buf[256];
while (fgets(buf, sizeof(buf), fp)) {
  printf("%s", buf);
}''';
      case FileIOStep.fputc:
        return 'fputc(\'A\', fp);';
      case FileIOStep.fputs:
        return 'fputs("Hello, World!\\n", fp);';
      case FileIOStep.fprintf:
        return 'fprintf(fp, "Number: %d\\n", num);';
      case FileIOStep.fwrite:
        return 'fwrite(buffer, sizeof(char), size, fp);';
      case FileIOStep.exampleCreateWrite:
        return '''
FILE *fp = fopen("file.txt", "w");
if (fp != NULL) {
  fputs("Hello, world!\\n", fp);
  fclose(fp);
}''';
      case FileIOStep.exampleAppend:
        return '''
FILE *fp = fopen("file.txt", "a");
if (fp != NULL) {
  fputs("Appending a new line.\\n", fp);
  fclose(fp);
}''';
      case FileIOStep.fseek:
        return 'fseek(fp, offset, SEEK_SET);';
      case FileIOStep.ftell:
        return 'long pos = ftell(fp);';
      case FileIOStep.rewind:
        return 'rewind(fp);';
      case FileIOStep.fflush:
        return 'fflush(fp);';
      case FileIOStep.debugTips:
        return '''
// Example error check when opening a file:
FILE *fp = fopen("file.txt", "r");
if (fp == NULL) {
  perror("Error opening file");
  exit(EXIT_FAILURE);
}

// Always fclose after done with the file.
''';
    // No code for permissions, summary, quiz, those are theory/discussion steps
      default:
        return null;
    }
  }

  Widget _buildStepFlowchart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark ? Colors.greenAccent : Colors.teal[900]!;

    return Container(
      height: 56,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            const BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: _steps.map((s) {
            final isActive = s == _currentStep;
            return GestureDetector(
              onTap: () => _goToStep(_steps.indexOf(s)),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isActive ? accentColor : (isDark ? Colors.grey[800] : Colors.grey[300]),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: isActive
                      ? [BoxShadow(color: accentColor.withOpacity(0.5), blurRadius: 8, offset: Offset(0, 2))]
                      : null,
                ),
                child: Text(
                  _stepTitle(s),
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    fontSize: 13,
                    color: isActive ? Colors.black : (isDark ? Colors.greenAccent : Colors.black87),
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
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: textColor?.withOpacity(0.4) ??
              (isDark ? Colors.greenAccent : Colors.black12),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black45 : Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: SelectableText(
        text,
        style: TextStyle(
          fontSize: 15.2,
          color: textColor ?? (isDark ? Colors.greenAccent.shade100 : Colors.black87),
          fontFamily: fontFamily ?? "Roboto",
          height: 1.35,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCodeBox(String code) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121212) : const Color(0xFFF7F9FA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.greenAccent.shade700 : Colors.teal.shade300,
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
            color: isDark ? Colors.greenAccent.shade100 : Colors.teal.shade900,
            height: 1.3,
          ),
        ),
      ),
    );
  }

  Widget _buildQuiz() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const quizCode = '''
FILE *fp = fopen("data.txt", "r");
if (fp == NULL) {
  perror("File open failed");
  return -1;
}
char buf[100];
while (fgets(buf, sizeof(buf), fp)) {
  printf("%s", buf);
}
fclose(fp);
''';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.green.shade900.withOpacity(0.15) : Colors.teal[50],
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? Colors.greenAccent.withOpacity(0.3) : Colors.teal.shade300,
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QUIZ: IDENTIFY THE OUTPUT OR ERROR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.amber.shade700,
                letterSpacing: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            _buildPopup(
              context,
              quizCode,
              isDark ? Colors.greenAccent.withOpacity(0.2) : Colors.amber[100]!,
              fontFamily: "monospace",
              textColor: isDark ? Colors.greenAccent.shade100 : Colors.black87,
            ),
            const SizedBox(height: 16),
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
                  textColor = isDark ? Colors.greenAccent : Colors.teal[900];
                } else {
                  buttonColor = isDark ? Colors.teal[900] : Colors.teal[50];
                  textColor = isDark ? Colors.greenAccent : Colors.teal[900];
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
                    padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: "monospace",
                        fontWeight: FontWeight.w600),
                    elevation: 0,
                  ),
                  child: Text(choice.text),
                );
              }),
            ),
            if (_quizFeedback != null) ...[
              const SizedBox(height: 14),
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
    final step = _currentStep;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final explanation = _infoTextForStep(step);
    final codeSnippet = _codeForStep(step);

    return LayoutBuilder(builder: (context, constraints) {
      final isWide = constraints.maxWidth > 720;

      Widget explanationWidget = explanation != null
          ? _buildPopup(
        context,
        explanation,
        isDark ? Colors.green.shade700.withOpacity(0.15) : Colors.teal[50]!,
        textColor: isDark ? Colors.greenAccent : Colors.teal[900],
      )
          : const SizedBox.shrink();

      Widget codeWidget = codeSnippet != null
          ? _buildCodeBox(codeSnippet)
          : const SizedBox.shrink();

      Widget content;
      if (isWide) {
        content = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: explanationWidget),
            const SizedBox(width: 24),
            Expanded(child: codeWidget),
          ],
        );
      } else {
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            explanationWidget,
            const SizedBox(height: 16),
            codeWidget,
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Center(
            child: Text(
              _stepTitle(step),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.greenAccent : Colors.teal[900],
                letterSpacing: 1.1,
              ),
            ),
          ),
          Divider(
            thickness: 1.3,
            indent: 32,
            endIndent: 32,
            color:
            isDark ? Colors.greenAccent.withOpacity(0.3) : Colors.teal[300],
          ),
          content,
          if (step == FileIOStep.quiz) _buildQuiz(),
          const SizedBox(height: 20),
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

  Widget _buildNavigationButtons(bool isDark) {
    final isFirst = _currentStepIndex == 0;
    final isLast = _currentStepIndex == _steps.length - 1;
    final btnTextColor = isDark ? Colors.greenAccent : Colors.teal[900];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            icon: Icon(Icons.arrow_back,
                color: isFirst ? Colors.grey : btnTextColor),
            label: const Text('Back'),
            onPressed: isFirst ? null : _previousStep,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 45),
              backgroundColor: isDark ? Colors.teal[800] : Colors.teal[200],
              foregroundColor: btnTextColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          if (!isLast)
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Next'),
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(110, 45),
                backgroundColor: isDark ? Colors.teal[900] : Colors.teal[400],
                foregroundColor: btnTextColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            )
          else
            ElevatedButton.icon(
              icon: Icon(Icons.check_circle_outline, color: Colors.black87),
              label: const Text('Finish'),
              onPressed: () => Navigator.of(context).maybePop(),
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double horizontalPadding = MediaQuery.of(context).size.width < 600 ? 12 : 36;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'File I/O in C',
          style: TextStyle(color: isDark ? Colors.greenAccent : Colors.teal[900]),
        ),
        backgroundColor: isDark ? Colors.black87 : Colors.teal.shade100,
        iconTheme:
        IconThemeData(color: isDark ? Colors.greenAccent : Colors.teal[900]),
        centerTitle: true,
      ),
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 14,
          ),
          child: Column(
            children: [
              _buildStepFlowchart(context),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: _buildAnimatedStepContent(),
                ),
              ),
              const SizedBox(height: 12),
              _buildNavigationButtons(isDark),
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
