import 'challenge_model.dart';

final List<Problem> problems = [
  Problem(
    title: 'C Basics: Print Hello World',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'What function does a C program start with?',
        options: ['start()', 'main()', 'init()', 'begin()'],
        correctIndex: 1,
        explanation: 'Every C program execution begins from the main() function.',
      ),
      MCQQuestion(
        prompt: 'Which function is used to print output in C?',
        options: ['print()', 'echo()', 'printf()', 'cout'],
        correctIndex: 2,
        explanation: 'printf() is the standard function for output in C.',
      ),
      MCQQuestion(
        prompt: 'How do you write a single line comment in C?',
        options: ['-- comment', '// comment', '# comment', '/* comment */'],
        correctIndex: 1,
        explanation: 'Single-line comments in C start with //. Multiline comments use /* ... */',
      ),
      MCQQuestion(
        prompt: 'Which header file is needed for printf()?',
        options: ['stdlib.h', 'stdio.h', 'conio.h', 'string.h'],
        correctIndex: 1,
        explanation: 'Include stdio.h with #include <stdio.h> to use printf().',
      ),
      MCQQuestion(
        prompt: 'What symbol ends statements in C?',
        options: ['.', ';', ':', ','],
        correctIndex: 1,
        explanation: 'Every statement in C ends with a semicolon (;).',
      ),
      // Add up to 10 MCQs here for each problem.
    ],
  ),
  Problem(
    title: 'C Variables & Types',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'How do you declare an integer variable named x?',
        options: ['int x;', 'integer x;', 'x int;', 'var x;'],
        correctIndex: 0,
        explanation: 'Format: type name; → int x;',
      ),
      MCQQuestion(
        prompt: 'What is the type for floating point numbers in C?',
        options: ['double', 'string', 'int', 'float'],
        correctIndex: 3,
        explanation: 'Use float for fractional numbers.',
      ),
      MCQQuestion(
        prompt: 'Which statement assigns 5 to y in C?',
        options: ['5 = y;', 'y == 5;', 'y = 5;', 'y: 5'],
        correctIndex: 2,
        explanation: 'Assignment in C: variable = value;',
      ),
      MCQQuestion(
        prompt: 'What keyword is used for a constant in C?',
        options: ['const', 'static', 'final', 'constant'],
        correctIndex: 0,
        explanation: 'Use const int PI = 3 for constants.',
      ),
      MCQQuestion(
        prompt: 'What printf format specifier prints an integer?',
        options: ['%i', '%c', '%d', '%x'],
        correctIndex: 2,
        explanation: 'Use %d for integer printing.',
      ),
    ],
  ),
  Problem(
    title: 'C Operators',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'Which operator is used for division in C?',
        options: ['%', '/', '*', '--'],
        correctIndex: 1,
        explanation: 'Use / for division.',
      ),
      MCQQuestion(
        prompt: 'What does a % b give you in C?',
        options: ['Division', 'Multiplication', 'Remainder', 'Exponentiation'],
        correctIndex: 2,
        explanation: '% produces the remainder after division.',
      ),
      MCQQuestion(
        prompt: 'Which operator is used for incrementing by 1?',
        options: ['--', '++', '+=', '!!'],
        correctIndex: 1,
        explanation: '++ increases a variable’s value by 1.',
      ),
      MCQQuestion(
        prompt: 'How do you check equality in C?',
        options: ['=', '==', '!=', '<>'],
        correctIndex: 1,
        explanation: '== checks for equality, = is assignment.',
      ),
      MCQQuestion(
        prompt: 'Which is a logical AND operator in C?',
        options: ['&', '&&', '|', 'and'],
        correctIndex: 1,
        explanation: '&& is logical AND in C.',
      ),
    ],
  ),
  Problem(
    title: 'C Conditionals',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'Which of the following is correct?',
        options: [
          'if score > 60 {',
          'if (score > 60)',
          'if [score > 60]',
          'if score > 60 then'
        ],
        correctIndex: 1,
        explanation: 'C syntax: if (condition)',
      ),
      MCQQuestion(
        prompt: 'What keyword follows if for an alternative?',
        options: ['else', 'elseif', 'elif', 'maybe'],
        correctIndex: 0,
        explanation: 'else provides an alternate block.',
      ),
      MCQQuestion(
        prompt: 'Which keyword checks another condition after if?',
        options: ['elseif', 'elif', 'else if', 'else'],
        correctIndex: 2,
        explanation: 'else if checks a new condition after if.',
      ),
      MCQQuestion(
        prompt: 'How do you compare two variables a and b for not equal?',
        options: ['a != b', 'a =! b', 'a <> b', 'a NOT b'],
        correctIndex: 0,
        explanation: '!= means “not equal”.',
      ),
      MCQQuestion(
        prompt: 'What is the result of (3 > 5) ? 10 : 20 ?',
        options: ['10', '20', '3', '5'],
        correctIndex: 1,
        explanation: 'Since 3 > 5 is false, result is 20.',
      ),
    ],
  ),
  Problem(
    title: 'C Loops',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'Which loop is best for known number of iterations?',
        options: ['for', 'while', 'do-while', 'foreach'],
        correctIndex: 0,
        explanation: 'for is standard for a fixed number of repeats.',
      ),
      MCQQuestion(
        prompt: 'What is the output of: for(int i=1;i<=3;i++){ printf("%d",i); }',
        options: ['123', '321', '111', 'Error'],
        correctIndex: 0,
        explanation: 'Loops print 1 2 3.',
      ),
      MCQQuestion(
        prompt: 'Which statement skips current loop iteration?',
        options: ['break', 'next', 'skip', 'continue'],
        correctIndex: 3,
        explanation: 'continue skips to next iteration.',
      ),
      MCQQuestion(
        prompt: 'How many times does a do-while loop always run?',
        options: ['0', '1', 'Infinite', 'Depends'],
        correctIndex: 1,
        explanation: 'do-while always runs at least once.',
      ),
      MCQQuestion(
        prompt: 'What would while(0) do?',
        options: ['Run forever', 'Run once', 'Never run', 'Error'],
        correctIndex: 2,
        explanation: 'Condition false at start, never loops.',
      ),
    ],
  ),
  Problem(
    title: 'C Arrays',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'How do you declare an int array of 5 elements?',
        options: ['int arr[5];', 'array arr[5];', 'int arr(5);', 'arr int[5];'],
        correctIndex: 0,
        explanation: 'Format: type name[size];',
      ),
      MCQQuestion(
        prompt: 'What is the index of the first element?',
        options: ['1', '0', '-1', 'first'],
        correctIndex: 1,
        explanation: 'C arrays are 0-indexed.',
      ),
      MCQQuestion(
        prompt: 'Which accesses the second value of arr?',
        options: ['arr(2)', 'arr[2]', 'arr(1)', 'arr[1]'],
        correctIndex: 3,
        explanation: 'arr[1] is the second element.',
      ),
      MCQQuestion(
        prompt: 'How to initialize an array with values?',
        options: [
          'int arr[] = {1,2,3};',
          'int arr = [1,2,3];',
          'array int arr = {1,2,3};',
          'int arr = {1,2,3};'
        ],
        correctIndex: 0,
        explanation: 'Use curly braces for values.',
      ),
      MCQQuestion(
        prompt: 'What happens if you access arr[5] in int arr[5]?',
        options: [
          'Returns 0',
          'Returns garbage',
          'Out of bounds error/undefined behavior',
          'Always prints arr[0]'
        ],
        correctIndex: 2,
        explanation: 'Index 5 is out of bounds: undefined behavior in C.',
      ),
    ],
  ),
  Problem(
    title: 'C Strings',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'How are strings stored in C?',
        options: ['int arrays', 'char arrays', 'float arrays', 'string objects'],
        correctIndex: 1,
        explanation: 'Strings in C are arrays of char.',
      ),
      MCQQuestion(
        prompt: 'Which ends every string in C?',
        options: ['\\0', '#', '.', 'blank'],
        correctIndex: 0,
        explanation: 'Null character \\0 terminates C strings.',
      ),
      MCQQuestion(
        prompt: 'Which function gets string input from user?',
        options: ['scanf()', 'gets()', 'fgets()', 'input()'],
        correctIndex: 2,
        explanation: 'fgets is safest for string input.',
      ),
      MCQQuestion(
        prompt: 'How to print a string variable s?',
        options: ['printf("%d", s);', 'printf("%s", s);', 'print(s);', 'echo s;'],
        correctIndex: 1,
        explanation: 'Use %s for strings in printf.',
      ),
      MCQQuestion(
        prompt: 'Which library contains string functions?',
        options: ['string.h', 'stdio.h', 'stdlib.h', 'math.h'],
        correctIndex: 0,
        explanation: 'Include <string.h> for string functions.',
      ),
    ],
  ),
  Problem(
    title: 'C Functions',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'How do you declare a function returning int?',
        options: [
          'function int add()',
          'int add()',
          'fun add()',
          'add() int'
        ],
        correctIndex: 1,
        explanation: 'Format: returnType name()',
      ),
      MCQQuestion(
        prompt: 'Where does every C program execute from?',
        options: ['main()', 'start()', 'run()', 'entry()'],
        correctIndex: 0,
        explanation: 'Execution begins at main().',
      ),
      MCQQuestion(
        prompt: 'Which keyword sends back a result from a function?',
        options: ['return', 'send', 'output', 'yield'],
        correctIndex: 0,
        explanation: 'return gives back the value.',
      ),
      MCQQuestion(
        prompt: 'Can you define a function after main() in C?',
        options: [
          'No, never',
          'Yes, if declared before main()',
          'Yes, always',
          'Not without static'
        ],
        correctIndex: 1,
        explanation: 'You can declare (prototype) functions first.',
      ),
      MCQQuestion(
        prompt: 'Which parameter type allows value to be changed in caller?',
        options: ['call by value', 'call by copy', 'call by pointer/address', 'call by name'],
        correctIndex: 2,
        explanation: 'Pointers enable modification of variables.',
      ),
    ],
  ),
  Problem(
    title: 'C Pointers',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'What does int *p mean?',
        options: [
          'p is an int',
          'p is a pointer to int',
          'p is a double',
          'p is a char pointer'
        ],
        correctIndex: 1,
        explanation: '* shows it is a pointer.',
      ),
      MCQQuestion(
        prompt: 'How do you get the address of a variable x?',
        options: [
          'x*',
          '*.x',
          '&x',
          'address x'
        ],
        correctIndex: 2,
        explanation: '&x gives the address.',
      ),
      MCQQuestion(
        prompt: 'How to access the value pointed by pointer p?',
        options: [
          '*p',
          '&p',
          'p',
          '+p'
        ],
        correctIndex: 0,
        explanation: '*p gives the value at address p.',
      ),
      MCQQuestion(
        prompt: 'What is a null pointer?',
        options: [
          'Points to 0 address',
          'Points to some data',
          'Never used',
          'Points to 1'
        ],
        correctIndex: 0,
        explanation: 'A null pointer points to address 0 (NULL).',
      ),
      MCQQuestion(
        prompt: 'Can pointers be used to traverse arrays?',
        options: ['No', 'Yes', 'Only for int', 'Only for char'],
        correctIndex: 1,
        explanation: 'Pointers are often used for arrays in C.',
      ),
    ],
  ),
  Problem(
    title: 'C Preprocessor',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'What symbol starts a preprocessor directive?',
        options: ['%', '*', '#', '@'],
        correctIndex: 2,
        explanation: 'All preprocessor lines start with #.',
      ),
      MCQQuestion(
        prompt: 'How to include standard input/output library?',
        options: [
          '#include <stdio.h>',
          'import stdio;',
          '#import stdio.h',
          '#include stdio.h'
        ],
        correctIndex: 0,
        explanation: 'Syntax: #include <filename>',
      ),
      MCQQuestion(
        prompt: 'Which replaces code before compilation?',
        options: ['macro', 'function', 'variable', 'datatype'],
        correctIndex: 0,
        explanation: 'Macros are replaced before compilation.',
      ),
      MCQQuestion(
        prompt: 'Which symbol is used for header files?',
        options: ['"', '\'', '<>', '[]'],
        correctIndex: 2,
        explanation: '< > are for standard headers.',
      ),
      MCQQuestion(
        prompt: 'What does #define MAX 10 mean?',
        options: [
          'Sets a variable',
          'Defines a symbolic constant',
          'Creates an int',
          'Compiles MAX'
        ],
        correctIndex: 1,
        explanation: 'Replaces MAX with 10 before compilation.',
      ),
    ],
  ),
  Problem(
    title: 'C File I/O',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'Which C type stores a file stream?',
        options: ['FILE*', 'file', 'IntFile', 'stream'],
        correctIndex: 0,
        explanation: 'FILE* is used for files.',
      ),
      MCQQuestion(
        prompt: 'Which opens a file named data.txt for writing?',
        options: [
          'fopen("data.txt", "w");',
          'open("data.txt", "w");',
          'fopen("data.txt", "rw");',
          'file_open("data.txt")'
        ],
        correctIndex: 0,
        explanation: 'fopen() opens the file and returns pointer.',
      ),
      MCQQuestion(
        prompt: 'Which closes a file in C?',
        options: [
          'fileclose(fp);',
          'fclose(fp);',
          'close(fp);',
          'end(fp);'
        ],
        correctIndex: 1,
        explanation: 'fclose() properly closes a file.',
      ),
      MCQQuestion(
        prompt: 'What does printf() output go to?',
        options: ['File', 'Standard input', 'Standard output (screen)', 'Network'],
        correctIndex: 2,
        explanation: 'printf() prints to standard output by default.',
      ),
      MCQQuestion(
        prompt: 'Which function writes formatted data to a file?',
        options: ['printf()', 'fprintf()', 'fwrite()', 'strcpy()'],
        correctIndex: 1,
        explanation: 'fprintf() is like printf but for files.',
      ),
    ],
  ),
  Problem(
    title: 'C Scope & Lifetime',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'Where is a local variable accessible?',
        options: ['Anywhere', 'Within its function/block', 'Only in main()', 'Header file'],
        correctIndex: 1,
        explanation: 'Local variables are valid only inside their block.',
      ),
      MCQQuestion(
        prompt: 'What does static keyword do for a variable in function?',
        options: [
          'Makes it global',
          'Persists value between calls',
          'Deletes it',
          'Nothing'
        ],
        correctIndex: 1,
        explanation: 'static makes variable retain value between calls.',
      ),
      MCQQuestion(
        prompt: 'What is the default initial value for uninitialized global variables?',
        options: ['1', '0', 'undefined', 'random'],
        correctIndex: 1,
        explanation: 'Globals default to 0.',
      ),
      MCQQuestion(
        prompt: 'Global variables are declared ...?',
        options: ['Inside a function', 'Outside any function', 'Only in main()', 'Inside a loop'],
        correctIndex: 1,
        explanation: 'Globals are outside all functions.',
      ),
      MCQQuestion(
        prompt: 'If a function declares a variable with the same name as a global, which is used inside?',
        options: ['Global', 'Local', 'None', 'Error'],
        correctIndex: 1,
        explanation: 'The local variable hides the global inside that block.',
      ),
    ],
  ),
  Problem(
    title: 'C Constants & Macros',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'What does const int x = 5; do?',
        options: [
          'Creates a constant variable',
          'Creates a macro',
          'Declares a pointer',
          'Creates a string'
        ],
        correctIndex: 0,
        explanation: 'const makes x immutable.',
      ),
      MCQQuestion(
        prompt: 'How do you write a macro for PI as 3.14?',
        options: [
          '#define PI 3.14',
          'const PI = 3.14;',
          '#macro PI = 3.14',
          'macro PI(3.14)'
        ],
        correctIndex: 0,
        explanation: 'Syntax: #define NAME value',
      ),
      MCQQuestion(
        prompt: 'Where are macros replaced?',
        options: [
          'Before compilation (preprocessing)',
          'During runtime',
          'In linker',
          'Never'
        ],
        correctIndex: 0,
        explanation: 'Macros are replaced at preprocessing.',
      ),
      MCQQuestion(
        prompt: 'What is the advantage of macros?',
        options: [
          'Faster execution and code readability',
          'Slower compilation',
          'Security',
          'No advantages'
        ],
        correctIndex: 0,
        explanation: 'Macros enhance code clarity and speed, but beware of bugs.',
      ),
      MCQQuestion(
        prompt: 'Which keyword is NOT used to define a constant in C?',
        options: ['const', '#define', 'constant', 'All of these are valid'],
        correctIndex: 2,
        explanation: 'No keyword "constant" in C.',
      ),
    ],
  ),
  Problem(
    title: 'C Enum & Struct',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'What type does enum Color {RED, GREEN, BLUE}; create?',
        options: ['Array', 'Struct', 'Enumeration type', 'Macro'],
        correctIndex: 2,
        explanation: 'enum defines an enumeration.',
      ),
      MCQQuestion(
        prompt: 'Which accesses age in struct Student s?',
        options: [
          's->age',
          's:age',
          's.age',
          'Student.age'
        ],
        correctIndex: 2,
        explanation: 'Use . for struct members.',
      ),
      MCQQuestion(
        prompt: 'What is the starting integer value of first enum item by default?',
        options: ['0', '1', '-1', 'It must be set'],
        correctIndex: 0,
        explanation: 'Enums start at 0 by default.',
      ),
      MCQQuestion(
        prompt: 'How to declare a struct variable?',
        options: [
          'struct Point p;',
          'Point p;',
          'struct(p) p;',
          'p:struct Point'
        ],
        correctIndex: 0,
        explanation: 'Syntax: struct StructName var;',
      ),
      MCQQuestion(
        prompt: 'Can structs contain arrays as members?',
        options: ['No', 'Yes', 'Only pointers', 'Only ints'],
        correctIndex: 1,
        explanation: 'Struct members can be arrays.',
      ),
    ],
  ),
  Problem(
    title: 'C Miscellaneous',
    language: 'C',
    questions: [
      MCQQuestion(
        prompt: 'Which escape sequence prints a new line?',
        options: ['\\t', '\\n', '\\b', '\\r'],
        correctIndex: 1,
        explanation: '\\n is the newline character.',
      ),
      MCQQuestion(
        prompt: 'Which function reads a single character from input?',
        options: ['scanf()', 'fgetc()', 'getchar()', 'gets()'],
        correctIndex: 2,
        explanation: 'getchar() reads from standard input.',
      ),
      MCQQuestion(
        prompt: 'How to write a multi-line comment in C?',
        options: [
          '/* comment */',
          '/# comment #/',
          '// comment //',
          '""" comment """'
        ],
        correctIndex: 0,
        explanation: 'Use /* ... */ for multiline comments.',
      ),
      MCQQuestion(
        prompt: 'Which header contains mathematical functions?',
        options: ['math.h', 'algorithm.h', 'ctype.h', 'stdlib.h'],
        correctIndex: 0,
        explanation: '<math.h> is for mathematical operations.',
      ),
      MCQQuestion(
        prompt: 'What does return 0; in main() mean?',
        options: [
          'Successful program termination',
          'Error in program',
          'Return value is undefined',
          'main() runs indefinitely'
        ],
        correctIndex: 0,
        explanation: 'By convention, return 0 means program ended successfully.',
      ),
    ],
  ),
  Problem(
    title: 'Python Basics: Hello World',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'What keyword displays output in Python?',
        options: ['echo', 'printf', 'print', 'cout'],
        correctIndex: 2,
        explanation: 'Use print() for output in Python.',
      ),
      MCQQuestion(
        prompt: 'Is indentation important in Python?',
        options: ['yes', 'sometimes', 'only in functions', 'no'],
        correctIndex: 0,
        explanation: 'Indentation defines Python code blocks.',
      ),
      MCQQuestion(
        prompt: 'How do you write a comment in Python?',
        options: ['// comment', '# comment', '" comment "', '-- comment'],
        correctIndex: 1,
        explanation: 'Single-line comments in Python begin with #.',
      ),
      MCQQuestion(
        prompt: 'How do you assign value 10 to x in Python?',
        options: ['x = 10', 'int x = 10', 'x := 10', 'x == 10'],
        correctIndex: 0,
        explanation: 'Assignment in Python: variable = value.',
      ),
      MCQQuestion(
        prompt: 'Which type is the number 7 (no quotes)?',
        options: ['str', 'char', 'int', 'float'],
        correctIndex: 2,
        explanation: '7 is an integer type.',
      ),
    ],
  ),
  Problem(
    title: 'Python: Variables & Types',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'Assign string "hello" to variable msg.',
        options: ['msg: hello', 'msg = hello', "msg = 'hello'", 'let msg = "hello"'],
        correctIndex: 2,
        explanation: 'Assignment in Python: variable = value, with quotes for string.',
      ),
      MCQQuestion(
        prompt: 'What is the type of 3.14 in Python?',
        options: ['str', 'float', 'int', 'decimal'],
        correctIndex: 1,
        explanation: '3.14 is float in Python.',
      ),
      MCQQuestion(
        prompt: "Which function returns length of string s?",
        options: ['size(s)', 'str.len(s)', 'len(s)', 'count(s)'],
        correctIndex: 2,
        explanation: 'len(s) returns length.',
      ),
      MCQQuestion(
        prompt: 'Which is the "not equal to" operator in Python?',
        options: ['<>', '!=', '~=', '=='],
        correctIndex: 1,
        explanation: '!= is not equal in Python.',
      ),
      MCQQuestion(
        prompt: 'What is True and False in Python?',
        options: ['Error', 'True', 'False', 'None'],
        correctIndex: 2,
        explanation: 'True and False returns False.',
      ),
    ],
  ),
  Problem(
    title: 'Python Operators',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'What operator is used for exponentiation?',
        options: ['^', '**', '%', '//'],
        correctIndex: 1,
        explanation: '** is the exponentiation operator in Python.',
      ),
      MCQQuestion(
        prompt: 'What is the output of 7 // 3?',
        options: ['2.33', '2', '3', '1'],
        correctIndex: 1,
        explanation: '// performs integer (floor) division.',
      ),
      MCQQuestion(
        prompt: 'Which logical operator means "and" in Python?',
        options: ['&&', 'and', '&', '||'],
        correctIndex: 1,
        explanation: 'and is the logical AND operator in Python.',
      ),
      MCQQuestion(
        prompt: 'What does the % operator do?',
        options: ['Modulo (remainder)', 'Power', 'Division', 'Concatenation'],
        correctIndex: 0,
        explanation: '% gives the remainder of division.',
      ),
      MCQQuestion(
        prompt: 'What will print(3 == 3 and 4 == 5) output?',
        options: ['True', 'False', 'Error', 'None'],
        correctIndex: 1,
        explanation: 'AND returns True only if both are True.',
      ),
    ],
  ),
  Problem(
    title: 'Python Conditionals',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'What is the syntax for an if statement?',
        options: ['if (x > 0):', 'if x > 0', 'if x > 0 then:', 'if x > 0 {}'],
        correctIndex: 0,
        explanation: 'Python uses colon and indentation to define blocks.',
      ),
      MCQQuestion(
        prompt: 'How do you check if x equals 5?',
        options: ['x == 5', 'x = 5', 'x := 5', 'x === 5'],
        correctIndex: 0,
        explanation: '== is the comparison operator for equality.',
      ),
      MCQQuestion(
        prompt: 'What keyword is used for else-if in Python?',
        options: ['else if', 'elif', 'elseif', 'else: if'],
        correctIndex: 1,
        explanation: 'Python uses elif for else-if chains.',
      ),
      MCQQuestion(
        prompt: 'What value is then executed if none of the if/elif conditions match?',
        options: ['else block', 'null block', 'default block', 'end'],
        correctIndex: 0,
        explanation: 'else runs when all previous conditions are False.',
      ),
      MCQQuestion(
        prompt: 'What does this print? print("Yes" if 10 > 5 else "No")',
        options: ['Yes', 'No', 'Error', '10 > 5'],
        correctIndex: 0,
        explanation: 'Ternary operator prints "Yes" when condition is True.',
      ),
    ],
  ),
  Problem(
    title: 'Python Loops',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'How to loop over a list nums?',
        options: ['for n in nums:', 'foreach nums as n:', 'loop nums:', 'for (n in nums)'],
        correctIndex: 0,
        explanation: 'Python uses for-in for loops.',
      ),
      MCQQuestion(
        prompt: 'What does the range(5) function do?',
        options: ['Creates list [0..4]', 'Creates list [1..5]', 'Counts down from 5', 'Generates random numbers'],
        correctIndex: 0,
        explanation: 'range(5) produces numbers 0 to 4.',
      ),
      MCQQuestion(
        prompt: 'How to write an infinite loop with while?',
        options: ['while True:', 'while 1:', 'while all:', 'while infinity:'],
        correctIndex: 0,
        explanation: 'while True loops forever until broken.',
      ),
      MCQQuestion(
        prompt: 'What does the continue statement do?',
        options: ['Skips to next iteration', 'Exits the loop', 'Pauses execution', 'Restarts program'],
        correctIndex: 0,
        explanation: 'continue moves loop to next iteration immediately.',
      ),
      MCQQuestion(
        prompt: 'How can you loop through a dictionary d\'s keys?',
        options: ['for k in d:', 'for k in d.keys():', 'for k, v in d.items():', 'All of the above'],
        correctIndex: 3,
        explanation: 'All ways are valid to iterate keys or items of dict.',
      ),
    ],
  ),
  Problem(
    title: 'Python Functions',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'How do you define a function in Python?',
        options: ['def func():', 'function func() {}', 'func() =>', 'def func {}'],
        correctIndex: 0,
        explanation: 'Use def and colon, followed by indented block.',
      ),
      MCQQuestion(
        prompt: 'How to return value from a function?',
        options: ['return value', 'send value', 'yield value', 'print value'],
        correctIndex: 0,
        explanation: 'Use return keyword to output value.',
      ),
      MCQQuestion(
        prompt: 'What happens if no return statement?',
        options: ['None is returned', '0 is returned', 'Error', 'Program crashes'],
        correctIndex: 0,
        explanation: 'Functions without return implicitly return None.',
      ),
      MCQQuestion(
        prompt: 'How to give default parameter?',
        options: ['def f(x=1):', 'def f(x): x=1', 'def f[x=1]:', 'def f(x=1) {}'],
        correctIndex: 0,
        explanation: 'Specify default value in function definition.',
      ),
      MCQQuestion(
        prompt: 'What is a lambda?',
        options: ['An anonymous function', 'A variable', 'A loop', 'A class'],
        correctIndex: 0,
        explanation: 'Lambda creates short anonymous functions.',
      ),
    ],
  ),
  Problem(
    title: 'Python Lists & Tuples',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'Which of these defines a list?',
        options: ['[1, 2, 3]', '(1, 2, 3)', '{1, 2, 3}', '"123"'],
        correctIndex: 0,
        explanation: 'Lists use square brackets [].',
      ),
      MCQQuestion(
        prompt: 'Which of these is immutable?',
        options: ['List', 'Tuple', 'Dictionary', 'Set'],
        correctIndex: 1,
        explanation: 'Tuples cannot be changed after creation.',
      ),
      MCQQuestion(
        prompt: 'How to add an element to a list?',
        options: ['list.append(x)', 'list.add(x)', 'list.insert(x)', 'list.push(x)'],
        correctIndex: 0,
        explanation: 'append() adds an element at the end.',
      ),
      MCQQuestion(
        prompt: 'How to access third element in list l?',
        options: ['l[2]', 'l(3)', 'l[3]', 'l{2}'],
        correctIndex: 0,
        explanation: 'Indexing is zero-based.',
      ),
      MCQQuestion(
        prompt: 'What does slicing l[1:4] do?',
        options: [
          'Gets elements from indexes 1 to 3',
          'Gets elements from indexes 1 to 4',
          'Gets elements 1,4',
          'Errors'
        ],
        correctIndex: 0,
        explanation: 'Slicing takes elements up to but excluding end index.',
      ),
    ],
  ),
  Problem(
    title: 'Python Strings',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'Which symbol is used for string literals?',
        options: ["'", '"', '`', 'All'],
        correctIndex: 3,
        explanation: 'Single, double, or triple quotes create strings.',
      ),
      MCQQuestion(
        prompt: 'What does str.lower() do?',
        options: ['Converts to lowercase', 'Converts to uppercase', 'Splits string', 'Removes spaces'],
        correctIndex: 0,
        explanation: 'Converts string characters to lowercase.',
      ),
      MCQQuestion(
        prompt: 'How to concatenate strings a and b?',
        options: ['a + b', 'a & b', 'a . b', 'str.cat(a,b)'],
        correctIndex: 0,
        explanation: 'Use + to concatenate strings.',
      ),
      MCQQuestion(
        prompt: 'How are raw string literals created?',
        options: ['r"string"', '"string"', "'string'", 'R/string/'],
        correctIndex: 0,
        explanation: 'Prefix r before string to make raw strings.',
      ),
      MCQQuestion(
        prompt: 'Which method counts substrings?',
        options: ['count()', 'index()', 'find()', 'match()'],
        correctIndex: 0,
        explanation: 'count() returns number of occurrences.',
      ),
    ],
  ),
  Problem(
    title: 'Python Dictionaries & Sets',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'Which symbol creates a dictionary?',
        options: ['{}', '[]', '()', '<>'],
        correctIndex: 0,
        explanation: 'Dictionaries use curly braces {}.',
      ),
      MCQQuestion(
        prompt: 'How to add key "age" to dict d?',
        options: ['d["age"] = 20', 'd.add("age", 20)', 'd.append("age", 20)', 'd.put("age", 20)'],
        correctIndex: 0,
        explanation: 'Assign value to a key directly.',
      ),
      MCQQuestion(
        prompt: 'Sets store...',
        options: ['Ordered unique elements', 'Unordered unique elements', 'Duplicate elements', 'Key-value pairs'],
        correctIndex: 1,
        explanation: 'Sets hold unique elements without order.',
      ),
      MCQQuestion(
        prompt: 'How to remove an element e from set s?',
        options: ['s.remove(e)', 's.delete(e)', 's.pop(e)', 's.erase(e)'],
        correctIndex: 0,
        explanation: 'remove() deletes a specific element.',
      ),
      MCQQuestion(
        prompt: 'How to check if x is in set s?',
        options: ['x in s', 's.index(x)', 's.find(x)', 's.has(x)'],
        correctIndex: 0,
        explanation: 'Use "in" to check membership.',
      ),
    ],
  ),
  Problem(
    title: 'Python Input & Output',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'What does input() return?',
        options: ['string', 'int', 'float', 'boolean'],
        correctIndex: 0,
        explanation: 'input() always returns a string.',
      ),
      MCQQuestion(
        prompt: 'How to convert input string to integer?',
        options: ['int(input())', 'float(input())', 'str(input())', 'bool(input())'],
        correctIndex: 0,
        explanation: 'Wrap input() with int() to get an integer.',
      ),
      MCQQuestion(
        prompt: 'Which function writes output to screen?',
        options: ['echo', 'print', 'write', 'display'],
        correctIndex: 1,
        explanation: 'print() outputs to console.',
      ),
      MCQQuestion(
        prompt: 'f-strings require prefix?',
        options: ['f', 's', 'str', 'pr'],
        correctIndex: 0,
        explanation: 'Prefix string with f or F for formatting.',
      ),
      MCQQuestion(
        prompt: 'How to print without newline at end?',
        options: ['print(..., end="")', 'print(..., no_newline=True)', 'print(..., newline=False)', 'print(..., suffix=None)'],
        correctIndex: 0,
        explanation: 'Use end="" parameter to avoid newline.',
      ),
    ],
  ),
  Problem(
    title: 'Python Exception Handling',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'Which keyword handles exceptions?',
        options: ['try', 'catch', 'handle', 'except'],
        correctIndex: 3,
        explanation: 'Use try-except blocks; except catches exceptions.',
      ),
      MCQQuestion(
        prompt: 'Which keyword always runs after try?',
        options: ['finally', 'else', 'end', 'complete'],
        correctIndex: 0,
        explanation: 'finally runs regardless of exceptions.',
      ),
      MCQQuestion(
        prompt: 'How to catch multiple exceptions?',
        options: ['except (TypeError, ValueError):', 'catch TypeError or ValueError:', 'except TypeError && ValueError:', 'handle TypeError, ValueError:'],
        correctIndex: 0,
        explanation: 'Use tuple of exceptions in except.',
      ),
      MCQQuestion(
        prompt: 'What happens if exception not caught?',
        options: ['Program crashes', 'Program continues', 'Prints warning', 'Ignores exception'],
        correctIndex: 0,
        explanation: 'Uncaught exception terminates program.',
      ),
      MCQQuestion(
        prompt: 'Which keyword runs if no exception?',
        options: ['else', 'finally', 'then', 'except'],
        correctIndex: 0,
        explanation: 'else runs if try succeeds without exceptions.',
      ),
    ],
  ),
  Problem(
    title: 'Python Modules',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'How to import entire math module?',
        options: ['import math', 'include math', 'using math', 'require math'],
        correctIndex: 0,
        explanation: 'import statement imports whole module.',
      ),
      MCQQuestion(
        prompt: 'How to import sqrt function only?',
        options: ['from math import sqrt', 'import math.sqrt', 'import sqrt from math', 'include sqrt'],
        correctIndex: 0,
        explanation: 'Use from-import syntax for specific functions.',
      ),
      MCQQuestion(
        prompt: 'How to access pi constant from math?',
        options: ['math.pi', 'pi()', 'pi', 'math->pi'],
        correctIndex: 0,
        explanation: 'Access constants with module dot attribute.',
      ),
      MCQQuestion(
        prompt: 'How to create your own module?',
        options: ['Save .py file and import it', 'Write code in main', 'Use importlib', 'Not possible'],
        correctIndex: 0,
        explanation: 'Python modules are just .py files you can import.',
      ),
      MCQQuestion(
        prompt: 'Which function lists module contents?',
        options: ['dir()', 'list()', 'contents()', 'help()'],
        correctIndex: 0,
        explanation: 'dir(module_or_object) lists available attributes.',
      ),
    ],
  ),
  Problem(
    title: 'Python List Comprehensions',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'What is list comprehension used for?',
        options: ['Creating new lists in concise syntax', 'Loops that modify list', 'Conditional operators', 'None'],
        correctIndex: 0,
        explanation: 'It shortens the code for creating filtered or mapped lists.',
      ),
      MCQQuestion(
        prompt: 'What does this do? [x for x in range(5) if x%2==0]',
        options: ['List even numbers 0-4', 'List odds', 'List all numbers', 'Error'],
        correctIndex: 0,
        explanation: 'Filters only even numbers in 0 to 4.',
      ),
      MCQQuestion(
        prompt: 'How to square numbers in a list comprehension?',
        options: ['[x**2 for x in numbers]', '[x*2 for x in numbers]', '[x^2 for x in numbers]', 'map(x**2)'],
        correctIndex: 0,
        explanation: 'Use x**2 for squaring numbers.',
      ),
      MCQQuestion(
        prompt: 'Can list comprehensions have multiple for clauses?',
        options: ['Yes', 'No', 'Only if nested', 'Sometimes'],
        correctIndex: 0,
        explanation: 'Multiple for loops are allowed for flattening or Cartesian products.',
      ),
      MCQQuestion(
        prompt: 'What does ["hello".upper() for _ in range(3)] return?',
        options: ['[HELLO, HELLO, HELLO]', '[hello, hello, hello]', 'Error', '[]'],
        correctIndex: 0,
        explanation: 'Applies .upper() to string three times.',
      ),
    ],
  ),
  Problem(
    title: 'Python Boolean & None',
    language: 'Python',
    questions: [
      MCQQuestion(
        prompt: 'What is the value of None?',
        options: ['It means “no value”', 'It is 0', 'It is False', 'It is a string'],
        correctIndex: 0,
        explanation: 'None indicates absence of a value.',
      ),
      MCQQuestion(
        prompt: 'Which of these is a boolean literal?',
        options: ['True', 'true', 'FALSE', 'yes'],
        correctIndex: 0,
        explanation: 'True with uppercase T is the proper boolean.',
      ),
      MCQQuestion(
        prompt: 'What will bool("") evaluate to?',
        options: ['False', 'True', 'None', 'Error'],
        correctIndex: 0,
        explanation: 'Empty string is Falsey.',
      ),
      MCQQuestion(
        prompt: 'What is the type of False?',
        options: ['bool', 'int', 'str', 'NoneType'],
        correctIndex: 0,
        explanation: 'False is a Boolean.',
      ),
      MCQQuestion(
        prompt: 'What does "is" operator check?',
        options: ['Object identity', 'Equality', 'Type', 'Value content'],
        correctIndex: 0,
        explanation: 'is checks whether two variables refer to same object.',
      ),
    ],
  ),
];
