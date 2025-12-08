import 'package:flutter/material.dart';
import 'dart:math';

enum CStringLibStep {
  intro,
  strlen,
  strcpy,
  strncpy,
  strcat,
  strncat,
  strcmp,
  strncmp,
  strchr,
  strrchr,
  strstr,
  strspn,
  strcspn,
  strpbrk,
  memset,
  memcpy,
  memmove,
  strtok,
  strerror,
  strdup,
  strerror_r,
  quiz,
  pitfalls,
  summary,
}

class CStringLibraryPage extends StatefulWidget {
  @override
  State<CStringLibraryPage> createState() => _CStringLibraryPageState();
}

class _CStringLibraryPageState extends State<CStringLibraryPage>
    with TickerProviderStateMixin {
  // Animation Management
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  int _currentStep = 0;
  int? _lastStepIndex;
  bool _animating = false;

  // Quiz State
  int? _quizSelected;
  bool _quizAnswered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slideAnim =
        Tween<Offset>(begin: Offset(0.18, 0), end: Offset.zero).animate(_fadeAnim);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToStep(int stepIdx) async {
    if (_animating || stepIdx == _currentStep) return;
    setState(() {
      _lastStepIndex = _currentStep;
      _animating = true;
    });
    await _controller.reverse();
    setState(() {
      _currentStep = stepIdx;
      _quizSelected = null;
      _quizAnswered = false;
    });
    await _controller.forward();
    setState(() => _animating = false);
  }

  void _nextStep() => _goToStep(min(_currentStep + 1, CStringLibStep.values.length - 1));
  void _prevStep() => _goToStep(max(_currentStep - 1, 0));

  bool get _isFirstStep => _currentStep == 0;
  bool get _isLastStep => _currentStep == CStringLibStep.values.length - 1;

  // FLOWCHART: Horizontal, scrollable, sharp contrast for dark mode, highlight current
  Widget _buildFlowchart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final majorSteps = [
      CStringLibStep.strlen,
      CStringLibStep.strcpy,
      CStringLibStep.strncpy,
      CStringLibStep.strcat,
      CStringLibStep.strncat,
      CStringLibStep.strcmp,
      CStringLibStep.strncmp,
      CStringLibStep.strchr,
      CStringLibStep.strrchr,
      CStringLibStep.strstr,
      CStringLibStep.strspn,
      CStringLibStep.strcspn,
      CStringLibStep.strpbrk,
      CStringLibStep.memset,
      CStringLibStep.memcpy,
      CStringLibStep.memmove,
      CStringLibStep.strtok,
      CStringLibStep.strerror,
      CStringLibStep.strdup,
      CStringLibStep.strerror_r,
    ];

    return Container(
      width: double.infinity,
      color: isDark ? Color(0xFF1d2925) : Color(0xFFe4f5ea),
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 6),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < majorSteps.length; ++i) ...[
              GestureDetector(
                onTap: () => _goToStep(CStringLibStep.values.indexOf(majorSteps[i])),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 180),
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 17),
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: CStringLibStep.values[_currentStep] == majorSteps[i]
                        ? (isDark ? Color(0xFF00ffb4) : Color(0xFF00b37a)).withOpacity(0.22)
                        : Colors.transparent,
                    border: Border.all(
                      color: CStringLibStep.values[_currentStep] == majorSteps[i]
                          ? (isDark
                          ? Color(0xFF50ffa6)
                          : Color(0xFF047564))
                          : (isDark ? Color(0xFF23392c) : Color(0xFFabddc2)),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _flowStepLabel(majorSteps[i]).toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: CStringLibStep.values[_currentStep] == majorSteps[i]
                          ? (isDark ? Color(0xFF00ffb4) : Color(0xFF00704a))
                          : (isDark ? Color(0xFFafffd7) : Color(0xFF127250)),
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ),
              if (i < majorSteps.length - 1)
                Icon(Icons.arrow_forward_ios,
                    size: 15,
                    color:
                    isDark ? Color(0xFF5bd59e) : Color(0xFF98bbb2)),
            ]
          ],
        ),
      ),
    );
  }

  String _flowStepLabel(CStringLibStep step) {
    switch (step) {
      case CStringLibStep.strlen: return 'strlen';
      case CStringLibStep.strcpy: return 'strcpy';
      case CStringLibStep.strncpy: return 'strncpy';
      case CStringLibStep.strcat: return 'strcat';
      case CStringLibStep.strncat: return 'strncat';
      case CStringLibStep.strcmp: return 'strcmp';
      case CStringLibStep.strncmp: return 'strncmp';
      case CStringLibStep.strchr: return 'strchr';
      case CStringLibStep.strrchr: return 'strrchr';
      case CStringLibStep.strstr: return 'strstr';
      case CStringLibStep.strspn: return 'strspn';
      case CStringLibStep.strcspn: return 'strcspn';
      case CStringLibStep.strpbrk: return 'strpbrk';
      case CStringLibStep.memset: return 'memset';
      case CStringLibStep.memcpy: return 'memcpy';
      case CStringLibStep.memmove: return 'memmove';
      case CStringLibStep.strtok: return 'strtok';
      case CStringLibStep.strerror: return 'strerror';
      case CStringLibStep.strdup: return 'strdup';
      case CStringLibStep.strerror_r: return 'strerror_r';
      default: return '';
    }
  }

  // --- Responsive Layout Utility ---
  Widget _responsiveSection({
    required Widget explanation,
    required Widget code,
  }) {
    return LayoutBuilder(
      builder: (context, c) {
        bool isWide = c.maxWidth > 700;
        return isWide
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: explanation),
            SizedBox(width: 38),
            Flexible(child: code),
          ],
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            explanation,
            SizedBox(height: 18),
            code,
          ],
        );
      },
    );
  }

  // --- CONTENT DATA / STEPS ---
  List<_CStringStepContent> get _allSteps => [
    _CStringStepContent(
      title: 'INTRODUCTION TO C STRING LIBRARY',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "C's <string.h> library is a goldmine of powerful, efficient functions for manipulating null-terminated character arrays (strings). These let you get string length, copy, concatenate, tokenize, search, move memory, and more—all with blazing speed.",
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          SizedBox(height: 11),
          Text(
            "In this interactive tutorial, you'll see each key function *in action* with evolving code and best practice explanations.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.teal),
          ),
        ],
      ),
      code: '''
#include <string.h>
#include <stdio.h>

// The code will be progressively built up in each step
int main()
{
   // Let's start learning!
   return 0;
}
''',
    ),
    // strlen
    _CStringStepContent(
      title: 'STRLEN() — LENGTH OF STRING',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• `strlen()` returns the number of characters in a string (excluding the terminal '\\0')."),
          SizedBox(height: 7),
          Text(
              "• Useful for loops, buffer allocations, and truncating strings at runtime."),
          SizedBox(height: 13),
          Text("Example 1:"),
          SizedBox(height: 2),
          Text("If `str` is \"hello\", then `strlen(str)` returns 5."),
          SizedBox(height: 9),
          Text("Example 2:"),
          SizedBox(height: 2),
          Text("If `str` is \"\", the result is 0 (empty string)."),
        ],
      ),
      code: '''
#include <stdio.h>
#include <string.h>

int main() {
  char name[] = "Programming";
  printf("Length = %zu\\n", strlen(name));
  // Output: Length = 11

  char empty[] = "";
  printf("Length = %zu\\n", strlen(empty));
  // Output: Length = 0
}
''',
    ),
    // strcpy
    _CStringStepContent(
      title: 'STRCPY() — COPY STRING',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• `strcpy(dest, src)` copies all characters from `src` to `dest`, stopping after null terminator.",
          ),
          SizedBox(height: 4),
          Text(
            "Caution: Destination buffer must be *at least* as large as source!",
            style: TextStyle(color: Colors.red[600], fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 13),
          Text("Example 1:"),
          Text(
              "Copying a name into another buffer: `strcpy(newbuf, oldbuf);`"),
          SizedBox(height: 7),
          Text("Example 2:"),
          Text(
              "Duplicating a greeting:"),
          Text("`char str[32]; strcpy(str, \"hello!\"); printf(\"%s\", str);`  // hello!"),
        ],
      ),
      code: '''
char s1[50] = "OpenAI";
char s2[50];
strcpy(s2, s1);
printf("Copied: %s\\n", s2);
// Output: Copied: OpenAI

// Dangerous! If s2 too small for s1, can overwrite memory!
''',
    ),
    // strncpy
    _CStringStepContent(
      title: 'STRNCPY() — SAFE COPY N CHARS',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• `strncpy(dest, src, n)` copies *at most n* characters.",
          ),
          SizedBox(height: 3),
          Text(
            "• Safer than `strcpy`, but you must ensure null-termination yourself!",
          ),
          SizedBox(height: 13),
          Text("Example 1:"),
          Text(
              "Copying part of a string: `strncpy(buf, \"abcdef\", 3);` results in `buf` containing \"abc\" (plus possibly extra zeros)."),
          SizedBox(height: 7),
          Text("Example 2:"),
          Text(
              "Truncating a long user input safely:"),
          Text("`char nick[8]; strncpy(nick, input, 7); nick[7]=0;`"),
        ],
      ),
      code: '''
char src[] = "Programming";
char dst[6];
strncpy(dst, src, 5);
dst[5] = '\\0';
printf("Partial copy: %s\\n", dst); // Output: Progr
''',
    ),
    _CStringStepContent(
      title: 'STRCAT() — CONCATENATE TWO STRINGS',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• `strcat(dest, src)` appends `src` to the *end* of `dest`. `dest` must have *enough* space.",
          ),
          SizedBox(height: 9),
          Text("Example 1:"),
          Text(
              "Merging first and last names:"),
          Text("`strcat(fullname, lastname);`"),
          SizedBox(height: 7),
          Text("Example 2:"),
          Text(
              "Chaining words into a sentence:"),
          Text(
              "char sentence[100] = \"I like \"; strcat(sentence, \"C\"); strcat(sentence, \" code.\");"),
        ],
      ),
      code: '''
char hello[16] = "hello";
char world[] = " world";
strcat(hello, world);
printf("%s\\n", hello);
// Output: hello world
''',
    ),
    _CStringStepContent(
      title: 'STRNCAT() — CONCAT N CHARS SAFELY',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• `strncat(dest, src, n)` appends at most n chars from `src` to `dest`.",
          ),
          SizedBox(height: 6),
          Text(
            "Use for safe, bounded concatenation. `dest` is always null-terminated.",
          ),
          SizedBox(height: 13),
          Text("Example 1:"),
          Text(
              "`char buf[10] = \"Data\"; strncat(buf, \"12345678\", 3); // buf: Data123`"),
          SizedBox(height: 7),
          Text("Example 2:"),
          Text(
              "Chaining only part of a word:"),
          Text("`char word[10] = \"test\"; strncat(word, \"ingxyz\", 3);  // testing`"),
        ],
      ),
      code: '''
char base[12] = "num";
char suffix[] = "bers";
strncat(base, suffix, 3);
printf("%s\\n", base); // Output: numbers
''',
    ),
    _CStringStepContent(
      title: 'STRCMP() — COMPARE TWO STRINGS',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• `strcmp(str1, str2)` does a lexicographical comparison."),
          SizedBox(height: 4),
          Text(
              "Returns 0 if equal, <0 if first less, >0 if first greater."),
          SizedBox(height: 13),
          Text("Example 1:"),
          Text("Are two passwords the same?"),
          Text("if (!strcmp(in, expected)) ..."),
          SizedBox(height: 7),
          Text("Example 2:"),
          Text(
              "Alphabetical order:"),
          Text("strcmp(\"abc\", \"abd\") → -1 (since 'c' < 'd')"),
        ],
      ),
      code: '''
printf("%d\\n", strcmp("abc", "abc")); // 0
printf("%d\\n", strcmp("a", "b")); // negative
printf("%d\\n", strcmp("b", "a")); // positive
''',
    ),
    _CStringStepContent(
      title: 'STRNCMP() — COMPARE FIRST N CHARS',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• `strncmp(str1, str2, n)` compares up to n characters."),
          SizedBox(height: 4),
          Text(
              "Quickly test prefixes or controlled-length comparison."),
          SizedBox(height: 10),
          Text("Example 1:"),
          Text("strncmp(\"abcdef\", \"abczzz\", 3) → 0"),
          SizedBox(height: 6),
          Text("Example 2:"),
          Text("strncmp(\"hello\", \"hella\", 4) → 0, but for 5 → positive value."),
        ],
      ),
      code: '''
printf("%d\\n", strncmp("OpenAI", "Open", 4)); // 0
printf("%d\\n", strncmp("abcdef", "abcwow", 3)); // 0
''',
    ),
    _CStringStepContent(
      title: 'STRCHR() — FIND FIRST OCCURRENCE',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• Searches for *first* appearance of character in string."),
          SizedBox(height: 7),
          Text("Example 1:"),
          Text("strchr(\"banana\", 'a') → points to first 'a'"),
          SizedBox(height: 10),
          Text("Example 2:"),
          Text("strchr(\"xyz\", 'k') → NULL"),
        ],
      ),
      code: '''
char *p = strchr("banana", 'a');
if (p) printf("Found: %c\\n", *p); // a
else printf("Not found\\n");
''',
    ),
    _CStringStepContent(
      title: 'STRRCHR() — FIND LAST OCCURRENCE',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• Finds *last* occurrence of a character in a string."),
          SizedBox(height: 7),
          Text("Example 1:"),
          Text("strrchr(\"stats\", 's') → pointer to last 's'"),
          SizedBox(height: 10),
          Text("Example 2:"),
          Text("strrchr(\"data\", 'b') → NULL"),
        ],
      ),
      code: '''
char *p = strrchr("strrchr example", 'e');
if (p) printf("Found at pos %ld\\n", p - "strrchr example");
// Output: Found at pos 15
''',
    ),
    _CStringStepContent(
      title: 'STRSTR() — FIND SUBSTRING',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• Finds *first* occurrence of substring (needle) within another string (haystack)."),
          SizedBox(height: 8),
          Text("Example 1:"),
          Text("strstr(\"big surprise!\", \"surp\") → points at \"surprise!\""),
          SizedBox(height: 8),
          Text("Example 2:"),
          Text("strstr(\"abcdef\", \"hi\") → NULL (not found)"),
        ],
      ),
      code: '''
char *pos = strstr("banana split", "ana");
if (pos) printf("Found at index: %ld\\n", pos - "banana split"); // 1
''',
    ),
    _CStringStepContent(
      title: 'STRSPN() — LENGTH OF INITIAL SUBSET',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• Returns length of the initial segment of a string consisting *only* of chars from set."),
          SizedBox(height: 5),
          Text("Example 1:"),
          Text("strspn(\"abcabc123\", \"abc\") → 6 (first six are a, b, c)"),
          SizedBox(height: 8),
          Text("Example 2:"),
          Text("strspn(\"at123\", \"abcdeft\") → 2 (a and t)"),
        ],
      ),
      code: '''
size_t n = strspn("aaabbb12", "ab");
printf("Initial span: %zu\\n", n); // 6
''',
    ),
    _CStringStepContent(
      title: 'STRCSPN() — LENGTH UNTIL CHR FROM SET',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• Returns length of segment at string start *until* any char from given set occurs."),
          SizedBox(height: 5),
          Text("Example 1:"),
          Text("strcspn(\"number123\", \"123\") → 6"),
          SizedBox(height: 8),
          Text("Example 2:"),
          Text("strcspn(\"hello\", \"aef\") → 1"),
        ],
      ),
      code: '''
size_t n = strcspn("abc123", "123");
printf("Stopped at: %zu\\n", n); // 3
''',
    ),
    _CStringStepContent(
      title: 'STRPBRK() — FIND FIRST ANY FROM SET',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• Finds *first* occurrence of any character from set in string."),
          SizedBox(height: 6),
          Text("Example 1:"),
          Text("strpbrk(\"apples\", \"eiu\") → points to 'e'"),
          SizedBox(height: 8),
          Text("Example 2:"),
          Text("strpbrk(\"milk\", \"aeiou\") → NULL (no vowels)"),
        ],
      ),
      code: '''
char *ch = strpbrk("OpenAI world", "o");
if (ch) printf("Matched: %c\\n", *ch);
''',
    ),
    _CStringStepContent(
      title: 'MEMSET() — FILL MEMORY BLOCK',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• `memset(buf, value, n)` fills n bytes at buf with `value`. Often used to zero arrays."),
          SizedBox(height: 10),
          Text("Example 1:"),
          Text("Zero-initialize: `memset(array, 0, sizeof(array));`"),
          SizedBox(height: 8),
          Text("Example 2:"),
          Text("Set all to 'A': `memset(buf, 'A', 5);`"),
        ],
      ),
      code: '''
char buf[7];
memset(buf, '*', 6);
buf[6] = 0;
printf("%s\\n", buf); // Output: ******
''',
    ),
    _CStringStepContent(
      title: 'MEMCPY() — COPY MEMORY',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• `memcpy(dest, src, n)` copies precisely n bytes from src to dest. *No null checks, type agnostic!*"),
          SizedBox(height: 7),
          Text("Example 1:"),
          Text("Copying structs or arrays fast:"),
          Text("`memcpy(dst, src, sizeof(arr));`"),
          SizedBox(height: 8),
          Text("Example 2:"),
          Text("Copying strings if dest buffer is always big enough:"),
        ],
      ),
      code: '''
char src[8] = "sample";
char dest[8];
memcpy(dest, src, 7);
printf("%s\\n", dest); // sample
''',
    ),
    _CStringStepContent(
      title: 'MEMMOVE() — SAFE MEMORY COPY (OVERLAP ALLOWED)',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• Like memcpy, but handles overlapping buffers safely!"),
          SizedBox(height: 8),
          Text("Example 1:"),
          Text("Moving elements inside array:"),
          Text("int arr[5]={1,2,3,4,5}; memmove(arr+1, arr, sizeof(int)*4); // arr[1..4]=arr[0..3]"),
          SizedBox(height: 8),
          Text("Example 2:"),
          Text("Overlapping strings:"),
          Text("memmove(s + 3, s, strlen(s));"),
        ],
      ),
      code: '''
char word[12] = "abcdefghij";
memmove(word+2, word, 5); // copy first 5 chars to start at word[2]
word[7]=0;
printf("%s\\n", word);
''',
    ),
    _CStringStepContent(
      title: 'STRTOK() — SPLIT STRING INTO TOKENS',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• Splits C string into tokens, e.g. by spaces or commas, for parsing separated data."),
          SizedBox(height: 10),
          Text("Example 1:"),
          Text('For CSV:'),
          Text('''char str[] = "a,b,c"; char *tok=strtok(str,","); while(tok){...}'''),
          SizedBox(height: 8),
          Text("Example 2:"),
          Text("Splitting by spaces:"),
          Text('''char str[]="cat dog fox"; for(char *t=strtok(str," "); t; t=strtok(NULL," ")) printf("%s\\n",t);'''),
        ],
      ),
      code: '''
char animals[] = "dog,cat,bird";
char *tok = strtok(animals, ",");
while(tok) {
  printf("%s\\n", tok);
  tok = strtok(NULL, ",");
}
// Output: dog\ncat\nbird
''',
    ),
    _CStringStepContent(
      title: 'STRERROR() — ERROR MESSAGE TEXT',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• `strerror(errno)` converts error code to readable message text."),
          SizedBox(height: 8),
          Text("Example 1:"),
          Text(
              "`FILE *f=fopen(\"nofile.txt\",\"r\"); if(!f) puts(strerror(errno));`"),
          SizedBox(height: 8),
          Text("Example 2:"),
          Text(
              "Getting text for system error code:"),
          Text("printf(\"%s\", strerror(13));"),
        ],
      ),
      code: '''
#include <errno.h>
printf("Error: %s\\n", strerror(ENOENT));   // Error: No such file or directory
''',
    ),
    _CStringStepContent(
      title: 'STRDUP() — DUPLICATE STRING WITH MALLOC',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• Returns a new malloc'd copy of input string. Caller must free() it. (Not in C89, but most POSIX/modern)."),
          SizedBox(height: 8),
          Text("Example 1:"),
          Text(
              "`char *stuff = strdup(\"abcde\"); /* later... */ free(stuff);`"),
          SizedBox(height: 8),
          Text("Example 2:"),
          Text(
              "Useful for storing user input for later use."),
        ],
      ),
      code: '''
char *temp = strdup("temporary copy");
printf("%s\\n", temp);
free(temp);
''',
    ),
    _CStringStepContent(
      title: 'STRERROR_R() — THREAD SAFE ERROR TXT',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "• Like strerror but safe for threads (POSIX). Use for multi-threaded servers/processes."),
          SizedBox(height: 7),
          Text("Example 1:"),
          Text(
              "char buf[256]; strerror_r(errno, buf, sizeof(buf));"),
        ],
      ),
      code: '''
char msg[100];
strerror_r(ENOENT, msg, sizeof(msg));
printf("Thread-safe: %s\\n", msg);
''',
    ),
    _CStringStepContent(
      title: 'QUIZ: OUTPUT OF STRING MANIPULATION',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What is the output?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            "char foo[20] = \"he\", bar[20]=\"ll\"; \nstrcat(foo, bar); \nstrncat(foo, \"oworld!\", 4);\nprintf(\"%s\", foo);",
            style: TextStyle(fontFamily: "monospace"),
          ),
          SizedBox(height: 12),
          _quizOptions(),
        ],
      ),
      code: null,
    ),
    _CStringStepContent(
      title: 'COMMON PITFALLS AND BEST PRACTICES',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• Buffer overflow: Always check dest buffer size!"),
          Text("• Null pointers: Validate pointers before use."),
          Text("• Memory leaks: Free all memory allocated (e.g. by strdup)."),
          Text("• Non-null terminated: Bounded copy/concat may leave missing null-byte, check!"),
          Text("• Prefer `strncpy`, `strncat` for safety, especially with user data!"),
          SizedBox(height: 9),
          _annotationBox(context, 'Always verify buffer sizes and use safer, bounded versions of string functions to avoid security vulnerabilities.'),
        ],
      ),
      code: null,
    ),
    _CStringStepContent(
      title: 'SUMMARY AND RECAP',
      explanation: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "You learned the arsenal of <string.h>: getting string length, copying, concatenating, comparing, searching, tokenizing, and memory ops."),
          SizedBox(height: 8),
          Text(
              "Utilize the right C string function for your needs—safely and confidently!"),
          Text(
              "Remember: Respect buffer sizes, use bounded functions, and always manage memory!"),
        ],
      ),
      code: null,
    ),
  ];

  // QUIZ: Interactive options & feedback
  Widget _quizOptions() {
    List<String> options = [
      "A. helloworld!",
      "B. hellooworld!",
      "C. helllowor",
      "D. helloowor",
    ];
    int correct = 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(options.length, (i) {
        final isSelected = _quizSelected == i;
        final isCorrect = _quizAnswered && i == correct;
        final isWrong = _quizAnswered && isSelected && i != correct;
        Color? color;
        if (isCorrect)
          color = Colors.green;
        else if (isWrong) color = Colors.red[600];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          child: ElevatedButton(
            onPressed: _quizAnswered
                ? null
                : () => setState(() {
              _quizSelected = i;
              _quizAnswered = true;
            }),
            style: ElevatedButton.styleFrom(
              backgroundColor: color ??
                  (isSelected
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
                      : Theme.of(context).canvasColor),
              foregroundColor: color != null
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyLarge?.color,
              side: isSelected
                  ? BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 2)
                  : BorderSide.none,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(options[i], style: TextStyle(fontSize: 16))),
          ),
        );
      })
        ..add(
          _quizAnswered
              ? Padding(
              padding: const EdgeInsets.only(top: 10, left: 6),
              child: Text(
                  _quizSelected == 3
                      ? "Correct 🎉 — Output: 'helloowor'"
                      : "Try again! The code appends 'll' and then only 'owor' from the last string.",
                  style: TextStyle(
                      color: _quizSelected == 3
                          ? Colors.green
                          : Colors.red[700],
                      fontWeight: FontWeight.w600)))
              : Container(),
        ),
    );
  }

  // ANNOTATION box
  static Widget _annotationBox(BuildContext context, String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        color: isDark ? Colors.green.withOpacity(0.1) : Colors.green.shade100,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: isDark
              ? Colors.greenAccent.shade200
              : Colors.green.shade900,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  // CODE block UI
  Widget _codeBlock(String? code) {
    if (code == null) return SizedBox();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: isDark ? Color(0xFF141a18) : Color(0xFFf2fcf4),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
            color:
            isDark ? Colors.green.shade900 : Colors.teal.shade200,
            width: 1.4),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          code,
          style: TextStyle(
            fontSize: 14.5,
            fontFamily: "FiraMono, Menlo, monospace",
            color: isDark
                ? Colors.greenAccent.shade100
                : Colors.green.shade900,
            height: 1.37,
          ),
        ),
      ),
    );
  }

  // MAIN: Build UI
  @override
  Widget build(BuildContext context) {
    final content = _allSteps[_currentStep];
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final canPop = Navigator.of(context).canPop();

    return Scaffold(
      backgroundColor: isDark ? Color(0xFF16221d) : Colors.white,
      appBar: AppBar(
        title: Text(
          'C STRING LIBRARY - INTERACTIVE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Color(0xFF72ffaa) : Colors.teal[900],
            letterSpacing: 1.3,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Color(0xFF202924) : Colors.teal.shade50,
        elevation: 1.5,
        iconTheme: IconThemeData(
            color: isDark ? Colors.greenAccent : Colors.teal),
        leading: canPop
            ? IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        )
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildFlowchart(context),
            Expanded(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (ctx, child) {
                  return FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width < 480 ? 10 : 36,
                            vertical: 20),
                        child: (content.code == null)
                            ? content.explanation
                            : _responsiveSection(
                          explanation: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: content.explanation,
                          ),
                          code: _codeBlock(content.code),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isFirstStep ? null : _prevStep,
                    icon: Icon(Icons.arrow_back),
                    label: Text('Previous'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                      foregroundColor: isDark ? Color(0xFF50ffa6) : Colors.teal[900],
                      backgroundColor: isDark ? Color(0xFF253d30) : Colors.teal.shade100,
                    ),
                  ),
                  if (!_isLastStep)
                    ElevatedButton.icon(
                      onPressed: _nextStep,
                      icon: Icon(Icons.arrow_forward),
                      label: Text('Next'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                        foregroundColor: isDark
                            ? Color(0xFF76ffd9)
                            : Colors.teal[900],
                        backgroundColor: isDark
                            ? Color(0xFF306051)
                            : Colors.teal.shade300,
                      ),
                    ),
                  if (_isLastStep)
                    ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: Icon(Icons.check_circle),
                      label: Text('Finish Now'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                        foregroundColor: isDark ? Colors.greenAccent : Colors.teal[900],
                        backgroundColor: isDark ? Color(0xFF18693e) : Colors.green.shade300,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CStringStepContent {
  final String title;
  final Widget explanation;
  final String? code;
  _CStringStepContent(
      {required this.title, required this.explanation, required this.code});
}
