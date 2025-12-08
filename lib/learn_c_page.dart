import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ProgrammingConcept {
  final String title;
  final String explanation;
  final String code;
  final String codeExplanation;
  ProgrammingConcept({
    required this.title,
    required this.explanation,
    required this.code,
    required this.codeExplanation,
  });
}

const String cDocumentation = '''
C Programming: Complete Beginner’s Documentation

What is C?
C is a foundational, high-level programming language created to help develop operating systems and other powerful applications. It offers a balance between control over the computer’s hardware and portability between systems. C code is usually compiled directly to machine code, which makes it very fast and efficient. It is still widely taught, used, and trusted for dozens of fields.

Why Learn C?
- It’s the basis of many influential languages (C++, Java, C#, Objective-C, PHP, and more).
- Learning C is like “seeing inside the computer”; you’ll understand memory, data, and logic deeply.
- It’s used to build operating systems (Windows, Linux, Unix), device drivers, embedded systems, and compilers.
- C code is fast and uses few resources—great for hardware, microcontrollers, and performance-critical software.
- Programming in C develops valuable problem-solving and debugging skills useful in any language.
- C’s syntax and patterns make it easy to transition to more modern languages in the future.

Core Topics Covered
This section will guide you step-by-step from first program to many practical skills, covering all the essentials before object-oriented or algorithmic complexity.

1. C Program Structure
- Every program starts running at the `main` function.
- Code must be inside functions, and blocks/statements are grouped with curly braces `{}` and `}`.
- Don’t forget: every instruction ends with a semicolon `;`.
- Programs use preprocessor commands (like `#include <stdio.h>`) at the top for features such as input/output.
- Example:
#include <stdio.h>
int main()
{ printf("Hello, World
\\n");


2. Variables & Data Types
- Variables store data temporarily for calculations and logic.
- You must declare a variable’s type before use.
- Main types:
  - `int` for whole numbers (age, count)
  - `float` for decimal values (temperature, average)
  - `double` for more precise/large decimals
  - `char` for a single character ('A', 'x')
- Declaration examples:
int score = 70;
float price = 99.9

- Use `const` or `#define` for values that never change.

3. Input & Output
- Output:
- Use `printf` to print values, formatted text, or variables to the screen.
- Format specifiers: `%d` (int), `%f` (float), `%c` (char), `%s` (string).
- Example: `printf("Result: %d\\n", value);`
- Input:
- Use `scanf` to get user values. Always use `&` (address-of operator).
- Example: `scanf("%f", &price);`
- Beware: improper use can lead to bugs or crashes.

4. Operators
- Arithmetic, for math: `+` (add), `-` (subtract), `*` (multiply), `/` (divide), `%` (remainder).
- Relational, for comparing: `>`, `<`, `>=`, `<=`, `==`, `!=`
- Logical, for combining truth: `&&` (and), `||` (or), `!` (not)
- Bitwise, for low-level manipulation: `&`, `|`, `^`, `~`, `<<`, `>>`
- Assignment variants: `=`, `+=`, `-=`, `*=`, `/=`
- Increment/decrement: `++`, `--` (add/subtract 1, can be prefix or postfix)
- Ternary: `condition ? valueIfTrue : valueIfFalse`
- Example: `int total = a + b * 2;`

5. Conditional Statements
- Control flow lets your code act differently based on values:
- `if` checks a true/false condition
- `else if`/`else` provides alternatives
- `switch-case` quickly selects code based on a variable’s value (especially `int` or `char`):
switch(option) {
case 'y':
printf("Yes!\n");
break;
case 'n':
printf("No!\n");
break;
default:
printf("Unknown!\n");
}
- Ternary operator simplifies quick choices: `int abs = (num>=0) ? num : -num;`

6. Loops
- `for` loops: repeat a fixed number of times.
- Example: `for (int i=0;i<10;i++)`
- `while` loops: continue while condition is true.
- Example: `while (a > 0)`
- `do-while`: always runs once before checking.
- Loops are crucial for tasks like summing numbers, processing arrays, and printing tables.
- Use `break` to exit a loop early, and `continue` to skip to next iteration.
- Loops can be nested (loop inside another loop).

7. Arrays & Strings
- Arrays: collections of values of the same type under one name.
- `int scores[5] = {70, 80, 90, 60, 85};`
- Access with `scores[2]`—indexes start at 0.
- Strings: arrays of chars ending in `\\0` (null).
- `char name[10] = "Alice";`
- Common bug: not reserving enough space for `\\0` at the end.
- Use library functions like `strcpy`, `strlen`, `strcmp` (from `#include <string.h>`).

8. Functions
- Group code you want to re-use or keep organized.
- Each function specifies:
- return type (what it produces)
- name
- parameters (inputs)
- Example: 
float area(float radius) {
return 3.1416 * radius * radius;
}

- Use functions to split programs into logical, testable parts.
- Functions can call other functions (and even themselves—see recursion).

9. Pointers
- A pointer is a variable that holds the address (location in memory) of another variable.
- Declare: `int *ptr;`
- Assign: `ptr = &num;`
- Dereference: `*ptr` is the value stored at the address.
- Use pointers for:
- Efficient function arguments (change caller’s value)
- Dynamic memory (allocating at runtime)
- Working with arrays/strings at a low level
- Always initialize pointers (e.g., `NULL`) to avoid random memory bugs!

10. Structures and Enumerations
- Structures (struct):
- Bundle multiple variables (possibly different types) together.
- Useful for organizing complex data (ex: student with roll, name, and marks).
- Example:  
  struct Student {
    int roll;
    char name;
    float marks;
  };
- **Enumerations (enum):**
- Create custom data types with named integer values.
- Good for setting readable status, state, colors, categories, etc.
  enum Color { RED, GREEN, BLUE };

11. File Input/Output
- C can read from or write to files (not just the screen).
- Use `FILE *fp = fopen("data.txt", "r");`
- `"r"` is read, `"w"` is write, `"a"` is append, etc.
- Use `fprintf`, `fscanf` for formatted writing/reading.
- Always close files with `fclose(fp);`
- Reading/writing files is key for handling large data, logs, or persistent information.

12. Memory Management
- Dynamically allocate memory with:
- `malloc` (allocate uninitialized block)
- `calloc` (allocate zero-initialized block)
- `realloc` (resize existing block)
- Free memory manually with `free(ptr);` to avoid memory leaks.
- Good memory handling is essential for robust programs that won’t crash systems.

13. Constants, Macros, and Preprocessor Directives
- `#define` for macros and symbolic constants.
- `const` to declare immutable variables.
- `#include` to borrow code from standard or custom header files (like libraries).
- Preprocessor directives begin with `#` and are handled before compilation.

14. Miscellaneous
- Comments: use `//` or `/* ... */` to make your code readable and maintainable.
- Scope: local variables work only inside their function/block; global variables work everywhere.
- Type casting: use `(type)value` to convert types - caution with precision loss!
- Standard libraries include lots of ready-made functions for math (`math.h`), input/output (`stdio.h`), memory handling (`stdlib.h`), strings (`string.h`), character handling (`ctype.h`), and more.
- Passing command-line arguments to `main(int argc, char *argv[])` allows more flexible input.
- Be careful of input buffer and buffer overflows: always check input sizes and array bounds.

How to Learn
- Don’t just read: try to write, compile, and run every sample.
- Tweak values and code; experiment and see what happens.
- Use online tools like https://www.onlinegdb.com/online_c_compiler/ to practice C code instantly.
- Build small, meaningful mini-projects (like calculators, data sorters, games) as you learn.
- Debugging is OK! Errors are a learning tool—read error messages, Google them, and try again.

Tips for Success
- Practice and repetition are critical—code daily, not just read.
- Don’t fear mistakes: making (and fixing) errors is the best way to learn C.
- Look up the documentation for libraries and functions—it's a major real-world skill!
- Ask questions from teachers, friends, and online communities—nobody learns alone.
- Make your code readable: use good names, indentation, and lots of comments.
- Remember safety: free what you allocate, watch your array bounds, always initialize variables.
- The more you experiment, the better you’ll get—for a new programmer, curiosity matters most!

Let’s get started!
Now you are ready to explore the examples and lessons below. Step by step, you’ll master each key topic in C programming—from first print statement to working with files, memory, and more.

Happy coding!
''';



class LearnCPage extends StatelessWidget {
  final List<ProgrammingConcept> concepts = [
    // --- BASICS ---
    ProgrammingConcept(
      title: "Variables",
      explanation: "Variables store data for computation. Each variable in C must be declared with a data type.",
      code: '''
#include <stdio.h>
int main() {
    int age = 20;
    float weight = 62.5;
    char grade = 'A';
    printf("Age: %d\\n", age);
    printf("Weight: %.1f\\n", weight);
    printf("Grade: %c\\n", grade);
    return 0;
}
''',
      codeExplanation: 'This program demonstrates using int, float, and char variables. printf prints their values.',
    ),
    ProgrammingConcept(
      title: "Data Types",
      explanation: "C uses int, float, double, char for numbers and character data.",
      code: '''
int a = 5;
float b = 7.31;
double c = 6.1234;
char d = 'X';
''',
      codeExplanation: 'Different data types for whole numbers, decimals, and characters.',
    ),
    ProgrammingConcept(
      title: "Constants",
      explanation: "Define fixed values using #define or the const keyword to prevent reassignment.",
      code: '''
#define PI 3.14
const int MAX = 100;
printf("%.2f\\n", PI);
printf("%d\\n", MAX);
''',
      codeExplanation: 'PI is a macro constant. MAX is a const variable. Both cannot be changed after definition.',
    ),
    ProgrammingConcept(
      title: "Arithmetic Operators",
      explanation: "C supports +, -, *, /, % for addition, subtraction, multiplication, division, and modulus.",
      code: '''
int a = 6, b = 3;
printf("%d\\n", a + b); // 9
printf("%d\\n", a - b); // 3
printf("%d\\n", a * b); // 18
printf("%d\\n", a / b); // 2
printf("%d\\n", a % b); // 0
''',
      codeExplanation: 'Shows all arithmetic operators in action.',
    ),
    ProgrammingConcept(
      title: "Relational & Logical Operators",
      explanation: "Compare values with >, <, ==, !=. Combine logic with &&, ||, !.",
      code: '''
int a = 10, b = 15;
printf("%d\\n", a > b);         // 0 (false)
printf("%d\\n", a < b);         // 1 (true)
printf("%d\\n", a == b);        // 0 (false)
printf("%d\\n", (a < b) && (a != 0)); // 1
printf("%d\\n", !(a == b));     // 1
''',
      codeExplanation: 'Relational returns 1 for true/0 for false. Logical combine results.',
    ),
    ProgrammingConcept(
      title: "Type Casting",
      explanation: "Convert one data type to another using type casting. Useful for mathematical computations.",
      code: '''
int a = 5, b = 2;
float result = (float)a / b;
printf("%.2f\\n", result);
''',
      codeExplanation: 'Casts a to float so division produces a floating point result instead of integer division.',
    ),
    ProgrammingConcept(
      title: "Ternary Operator",
      explanation: "Use (condition) ? value1 : value2 as a shorthand for if-else.",
      code: '''
int num = 9;
printf("%s\\n", (num % 2 == 0) ? "Even" : "Odd");
''',
      codeExplanation: 'Prints "Even" if num is even, otherwise "Odd".',
    ),
    // --- CONTROL FLOW ---
    ProgrammingConcept(
      title: "If, Else, Else If",
      explanation: "Use if, else if, else to check multiple conditions.",
      code: '''
int score = 78;
if (score >= 90)
    printf("Excellent\\n");
else if (score >= 60)
    printf("Passed\\n");
else
    printf("Try Again\\n");
''',
      codeExplanation: 'Detects which range score belongs to and prints a message.',
    ),
    ProgrammingConcept(
      title: "Switch Statement",
      explanation: "Switch handles many fixed options for a single variable.",
      code: '''
char grade = 'B';
switch (grade) {
    case 'A':
        printf("Outstanding\\n");
        break;
    case 'B':
        printf("Very Good\\n");
        break;
    case 'C':
        printf("Good\\n");
        break;
    default:
        printf("Needs Improvement\\n");
}
''',
      codeExplanation: 'Checks which grade and prints matching feedback.',
    ),
    ProgrammingConcept(
      title: "For Loop",
      explanation: "Use for to repeat code a known number of times.",
      code: '''
for (int i = 1; i <= 5; i++) {
    printf("%d ", i);
}
''',
      codeExplanation: 'Prints numbers 1 to 5 using a for loop.',
    ),
    ProgrammingConcept(
      title: "While & Do-While Loops",
      explanation: "while runs as long as condition is true. do-while runs at least once.",
      code: '''
int n = 1;
while (n <= 3) {
    printf("%d ", n);
    n++;
}

int m = 1;
do {
    printf("%d ", m);
    m++;
} while (m <= 3);
''',
      codeExplanation: 'Both loops print 1 2 3, do-while always runs at least once.',
    ),
    ProgrammingConcept(
      title: "Nested Loops",
      explanation: "Loops can be nested inside each other, commonly used for patterns and matrices.",
      code: '''
for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 2; j++) {
        printf("%d %d\\n", i, j);
    }
}
''',
      codeExplanation: 'Outer loop runs 3 times; inner loop runs 2 times for each outer iteration.',
    ),
    ProgrammingConcept(
      title: "Break & Continue",
      explanation: "break exits a loop early. continue skips to the next iteration.",
      code: '''
for (int i = 1; i <= 5; i++) {
    if (i == 3) continue;
    if (i == 5) break;
    printf("%d ", i);
}
''',
      codeExplanation: 'Skips printing 3, stops the loop when i reaches 5.',
    ),
    ProgrammingConcept(
      title: "Increment and Decrement",
      explanation: "C uses ++ to increment and -- to decrement values, either before or after the variable.",
      code: '''
int x = 5;
printf("%d\\n", x++); // 5, then x becomes 6
printf("%d\\n", ++x); // x becomes 7, then prints 7
''',
      codeExplanation: 'x++ (post-increment) returns value first, then adds 1. ++x (pre-increment) adds 1 first.',
    ),
    // --- ARRAYS & STRINGS ---
    ProgrammingConcept(
      title: "Arrays",
      explanation: "Arrays store multiple values of the same data type in contiguous memory locations.",
      code: '''
int nums[5] = {1, 2, 3, 4, 5};
for (int i = 0; i < 5; i++) {
    printf("%d ", nums[i]);
}
''',
      codeExplanation: 'Defines an integer array with five elements and prints them one by one.',
    ),
    ProgrammingConcept(
      title: "Multi-dimensional Arrays",
      explanation: "Arrays can have more than one dimension (like a matrix).",
      code: '''
int mat[2][3] = {{1,2,3},{4,5,6}};
printf("%d\\n", mat[1][2]); // 6
''',
      codeExplanation: 'Accesses elements using two indices.',
    ),
    ProgrammingConcept(
      title: "Strings",
      explanation: "Strings in C are arrays of characters ending with '\\0'. Use %s in printf for strings.",
      code: '''
#include <stdio.h>
int main() {
    char name[20] = "Tania";
    printf("Name: %s\\n", name);
    return 0;
}
''',
      codeExplanation: 'Defines and prints a string. Always allocate enough space for string and null terminator.',
    ),
    ProgrammingConcept(
      title: "String Functions",
      explanation: "C offers built-in functions for handling strings in <string.h>.",
      code: '''
#include <string.h>
char s1[10] = "abc";
char s2[10] = "def";
strcat(s1, s2); // s1 becomes "abcdef"
''',
      codeExplanation: 'strcat appends s2 to s1.',
    ),
    ProgrammingConcept(
      title: "Character Functions",
      explanation: "Functions from <ctype.h> help check/convert character properties.",
      code: '''
#include <ctype.h>
char c = 'a';
printf("%c\\n", toupper(c)); // 'A'
''',
      codeExplanation: 'toupper converts lowercase to uppercase.',
    ),
    ProgrammingConcept(
      title: "Prevent Buffer Overflows",
      explanation: "Always use bounds when reading or writing arrays/strings.",
      code: '''
char buf[10];
fgets(buf, sizeof(buf), stdin); // Reads up to 9 chars safely
''',
      codeExplanation: 'fgets prevents overflow by limiting characters read.',
    ),
    ProgrammingConcept(
      title: "Escape Sequences",
      explanation: "Special character sequences for formatting output.",
      code: '''
printf("Hello\\nWorld\\tTabbed\\n");
''',
      codeExplanation: '\\n for newline, \\t for tab, \\\\ for backslash, etc.',
    ),
    // --- POINTERS ---
    ProgrammingConcept(
      title: "Pointer Basics",
      explanation: "Pointers store memory addresses. Use & to get the address, * to access the value.",
      code: '''
int n = 7;
int* ptr = &n;
printf("Value: %d\\n", *ptr); // Prints 7
''',
      codeExplanation: 'int* declares a pointer to int. ptr stores the address of n. *ptr fetches the value at that address.',
    ),
    ProgrammingConcept(
      title: "Pointer Arithmetic",
      explanation: "Pointers can be incremented/decremented to traverse arrays.",
      code: '''
int a[3] = {1,2,3};
int *p = a;
printf("%d\\n", *(p+1)); // 2
''',
      codeExplanation: 'Pointers move by size of data type they point to.',
    ),
    ProgrammingConcept(
      title: "Null Pointer",
      explanation: "NULL is used to indicate a pointer does not point anywhere.",
      code: '''
int *p = NULL;
if (p == NULL)
    printf("Pointer is null\\n");
''',
      codeExplanation: 'Good practice to initialize pointers to NULL until assigned.',
    ),
    // --- FUNCTIONS ---
    ProgrammingConcept(
      title: "Functions",
      explanation: "Reusable code blocks defined with return type, name, parameters.",
      code: '''
int multiply(int x, int y) {
    return x * y;
}
int main() {
    int prod = multiply(4, 5);
    printf("%d\\n", prod);
    return 0;
}
''',
      codeExplanation: 'Defines and uses a function to multiply two integers.',
    ),
    ProgrammingConcept(
      title: "Passing by Value vs Reference",
      explanation: "By default, C passes arguments by value. Use pointers to achieve pass-by-reference.",
      code: '''
void increment(int *n) {
    (*n)++;
}
''',
      codeExplanation: 'The pointer allows function to change the value in the caller\'s memory.',
    ),
    ProgrammingConcept(
      title: "Recursion",
      explanation: "A function that calls itself to solve a problem in smaller steps.",
      code: '''
int factorial(int n) {
    if (n <= 1) return 1;
    else return n * factorial(n - 1);
}
''',
      codeExplanation: 'Calculates factorial of a number using recursion.',
    ),
    ProgrammingConcept(
      title: "Static Variables",
      explanation: "static variables inside functions retain their value between function calls.",
      code: '''
void printCount() {
    static int count = 0;
    count++;
    printf("%d\\n", count);
}
''',
      codeExplanation: 'Every call to printCount increases static count; retains value between calls.',
    ),
    ProgrammingConcept(
      title: "Void Type",
      explanation: "void is used for functions that don’t return any value.",
      code: '''
void greet() {
    printf("Hello\\n");
}
''',
      codeExplanation: 'greet() function neither returns value nor accepts arguments.',
    ),
    // --- MEMORY & DYNAMIC ALLOCATION ---
    ProgrammingConcept(
      title: "Dynamic Memory Allocation",
      explanation: "malloc, calloc, realloc, and free are used to allocate and free memory at runtime.",
      code: '''
#include <stdlib.h>
int *arr = malloc(5 * sizeof(int));
arr[0] = 10;
free(arr);
''',
      codeExplanation: 'Allocates space for five integers, assigns value, then frees the memory.',
    ),
    ProgrammingConcept(
      title: "sizeof Operator",
      explanation: "sizeof returns the number of bytes a data type or variable occupies in memory.",
      code: '''
printf("%zu\\n", sizeof(int));    // Size of int
printf("%zu\\n", sizeof(double)); // Size of double
''',
      codeExplanation: 'Prints memory size for different data types.',
    ),
    ProgrammingConcept(
      title: "Macros with Arguments",
      explanation: "#define can make function-like macros.",
      code: '''
#define SQUARE(x) ((x)*(x))
printf("%d\\n", SQUARE(6)); // 36
''',
      codeExplanation: 'Macro computes square of a number.',
    ),
    ProgrammingConcept(
      title: "Memory Copy & Set (memcpy, memset)",
      explanation: "memcpy copies memory blocks, memset sets memory bytes.",
      code: '''
#include <string.h>
char buf[8];
memset(buf, 'a', 7); // Fill first 7 bytes with 'a'
buf[7] = '\\0';      // Null-terminate
''',
      codeExplanation: 'Fills a buffer with the letter \'a\'.',
    ),
    // --- STRUCTURES AND ENUMS ---
    ProgrammingConcept(
      title: "Structures (struct)",
      explanation: "struct groups different related data types together under one name.",
      code: '''
struct Student {
    int id;
    char name[20];
};

struct Student s = {101, "Sabina"};
printf("%d %s\\n", s.id, s.name);
''',
      codeExplanation: 'Defines Student structure and prints its data members.',
    ),
    ProgrammingConcept(
      title: "Array of Structures",
      explanation: "You can store multiple structures using arrays.",
      code: '''
struct Student { int marks; };
struct Student group[2] = {{75}, {80}};
printf("%d\\n", group[1].marks); // 80
''',
      codeExplanation: 'Access members using dot and index.',
    ),
    ProgrammingConcept(
      title: "Enumerations (enum)",
      explanation: "enum defines a set of named integer constants for clearer code.",
      code: '''
enum Color { RED, GREEN, BLUE };
enum Color c = GREEN;
printf("%d\\n", c); // 1
''',
      codeExplanation: 'Enums start at 0 by default. GREEN is assigned value 1.',
    ),
    ProgrammingConcept(
      title: "Typedef",
      explanation: "typedef gives a new name (alias) to an existing data type.",
      code: '''
typedef unsigned long ulong;
ulong a = 10000;
''',
      codeExplanation: 'Defines ulong as a new name for unsigned long.',
    ),
    // --- FILES & I/O ---
    ProgrammingConcept(
      title: "Input & Output",
      explanation: "Use scanf and printf for user input and output in C. scanf reads from keyboard, printf prints to screen.",
      code: '''
#include <stdio.h>
int main() {
    int age;
    printf("Enter your age: ");
    scanf("%d", &age);
    printf("You are %d years old\\n", age);
    return 0;
}
''',
      codeExplanation: 'scanf takes integer input and stores it in variable age. Remember the & before the variable name.',
    ),
    ProgrammingConcept(
      title: "File Operations (Basic)",
      explanation: "C can read/write files using FILE pointer and fopen, fclose, fprintf, fscanf, etc.",
      code: '''
#include <stdio.h>
int main() {
    FILE *fp = fopen("demo.txt", "w");
    fprintf(fp, "C Programming!");
    fclose(fp);
    return 0;
}
''',
      codeExplanation: 'Opens demo.txt for writing, writes a message, and closes file.',
    ),
    ProgrammingConcept(
      title: "Command Line Arguments",
      explanation: "main can accept arguments from the command line using int argc, char *argv[].",
      code: '''
int main(int argc, char *argv[]) {
    printf("Program name: %s\\n", argv[0]);
    return 0;
}
''',
      codeExplanation: 'argc counts arguments, argv lists them. argv[0] is program name.',
    ),
    ProgrammingConcept(
      title: "Command Line Arguments Usage",
      explanation: "Command line arguments can be used for flexible program input.",
      code: '''
int main(int argc, char *argv[]) {
    if (argc > 1) {
        printf("Argument: %s\\n", argv[1]);
    }
    return 0;
}
''',
      codeExplanation: 'Prints the first argument after the program name.',
    ),
    // --- OTHER FUNDAMENTALS ---
    ProgrammingConcept(
      title: "Scope & Lifetime",
      explanation: "A variable’s scope is where it is accessible (local/global). Lifetime is how long the variable exists during execution.",
      code: '''
int globalVar = 10; // Global variable

void show() {
    int localVar = 5; // Local variable
    printf("%d\\n", localVar);
}
''',
      codeExplanation: 'globalVar is accessible everywhere, localVar only inside show().',
    ),
    ProgrammingConcept(
      title: "Preprocessor Directives",
      explanation: "Commands like #include and #define are handled before compilation. Used for including headers and macros.",
      code: '''
#include <stdio.h>
#define MSG "Hello, C!"
int main() {
    printf("%s\\n", MSG);
    return 0;
}
''',
      codeExplanation: '#include adds standard libs. #define creates a constant macro. Both processed before actual compilation.',
    ),
    ProgrammingConcept(
      title: "Goto Statement",
      explanation: "goto allows jumping to a labeled statement (rarely recommended).",
      code: '''
int n = 1;
start:
printf("%d ", n);
n++;
if (n <= 3) goto start;
''',
      codeExplanation: 'Repeats printing 1 2 3 using goto and label.',
    ),
    // --- ADVANCED / BONUS ---
    ProgrammingConcept(
      title: "Bitwise Operators",
      explanation: "C provides operators like &, |, ^, ~, <<, >> for bit manipulation.",
      code: '''
int a = 5, b = 3;
printf("%d\\n", a & b);  // 1 (AND)
printf("%d\\n", a | b);  // 7 (OR)
printf("%d\\n", a ^ b);  // 6 (XOR)
printf("%d\\n", ~a);     // -6 (NOT)
printf("%d\\n", a << 1); // 10 (Left shift)
printf("%d\\n", b >> 1); // 1 (Right shift)
''',
      codeExplanation: 'Shows bitwise manipulation of integers.',
    ),
    // --- MISC / INPUT HANDLING ---
    ProgrammingConcept(
      title: "Character I/O (getchar, putchar)",
      explanation: "getchar() reads a single character from input, putchar() prints one character.",
      code: '''
char c;
c = getchar();
putchar(c);
''',
      codeExplanation: 'Reads one character and immediately prints it.',
    ),
    ProgrammingConcept(
      title: "Input Buffer Clearing",
      explanation: "Input buffer may contain leftover characters. Use getchar or fflush to clear.",
      code: '''
int c;
while ((c = getchar()) != '\\n' && c != EOF) {}
''',
      codeExplanation: 'This clears all input until a newline is found.',
    ),
    ProgrammingConcept(
      title: "Comments",
      explanation: "Use // for single-line, /* ... */ for multi-line comments. Comments are ignored by the compiler.",
      code: '''
// Single line comment
/* Multi-line
   comment */
printf("Hello!\\n"); // Prints greeting
''',
      codeExplanation: 'Comments increase code clarity, but don’t affect the output.',
    ),

    // --- PYTHON & BONUS/PRACTICE/UNIVERSAL CONCEPTS ---
    ProgrammingConcept(
      title: "Input Validation",
      explanation: "Use isdigit() on strings to check if user input is a whole number.",
      code: '''
while True:
    age = input("Enter your age: ")
    if age.isdigit():
        print("Your age is", age)
        break
    else:
        print("Please enter a valid number!")
''',
      codeExplanation: 'Loops until the user enters a valid integer using input validation.',
    ),

    ProgrammingConcept(
      title: "Multiple Assignment & Swapping",
      explanation: "Assign or swap multiple variables on one line.",
      code: '''
a, b, c = 1, 2, 3
a, b = b, a
print(a, b, c)  # 2 1 3
''',
      codeExplanation: 'Efficient packing/unpacking and value swapping.',
    ),

    ProgrammingConcept(
      title: "Unpacking Lists",
      explanation: "Assign multiple items from a list or tuple to variables at once.",
      code: '''
data = [5, 7, 9]
x, y, z = data
print(x, y, z)  # 5 7 9
''',
      codeExplanation: 'Unpacks three items from a list into three separate variables.',
    ),

    ProgrammingConcept(
      title: "For-Else Loop",
      explanation: "The else clause of a for-loop only runs if loop completes without break.",
      code: '''
nums = [2, 4, 6]
for n in nums:
    if n % 2 != 0:
        print("Found odd!")
        break
else:
    print("All numbers are even.")
''',
      codeExplanation: 'The else part only runs if the loop does not encounter a break.',
    ),

    ProgrammingConcept(
      title: "Using any() and all()",
      explanation: "Checks if any/all items in an iterable are True.",
      code: '''
values = [0, 1, 2]
print(any(values))  # True
print(all(values))  # False
''',
      codeExplanation: 'any() is True if at least one True; all() True if all are True/Truthy.',
    ),

    ProgrammingConcept(
      title: "The pass Statement",
      explanation: "pass does nothing—used as a placeholder for code you will write later.",
      code: '''
for _ in range(3):
    pass  # Placeholder for a future action
''',
      codeExplanation: 'Program runs without error, even though the loop body is empty.',
    ),

    ProgrammingConcept(
      title: "Enumerate in Loops",
      explanation: "enumerate() provides index and item during iteration.",
      code: '''
colors = ['red', 'green', 'blue']
for i, c in enumerate(colors, 1):
    print(i, c)
''',
      codeExplanation: 'Prints index and color starting with 1.',
    ),

    ProgrammingConcept(
      title: "zip() to Pair Lists",
      explanation: "zip() combines elements from multiple lists in parallel.",
      code: '''
names = ['A', 'B']
scores = [70, 80]
for name, score in zip(names, scores):
    print(name, score)
''',
      codeExplanation: 'Pairs up names with scores during iteration.',
    ),

    ProgrammingConcept(
      title: "Sorting Lists",
      explanation: "You can sort in place or get a sorted copy.",
      code: '''
nums = [4, 1, 3]
nums.sort()
print(nums)           # [1, 3, 4]
print(sorted(nums, reverse=True)) # [4, 3, 1]
''',
      codeExplanation: 'sort() changes the list itself; sorted() returns a new list.',
    ),

    ProgrammingConcept(
      title: "Filtering with filter()",
      explanation: "filter() keeps only items matching a test function.",
      code: '''
numbers = [1, 2, 3, 4]
evens = list(filter(lambda x: x % 2 == 0, numbers))
print(evens)  # [2, 4]
''',
      codeExplanation: 'filter() with lambda returns even numbers only.',
    ),

    ProgrammingConcept(
      title: "Mapping with map()",
      explanation: "map() applies a function to each item in an iterable.",
      code: '''
nums = [2, 3, 4]
cubes = list(map(lambda n: n**3, nums))
print(cubes)  # [8, 27, 64]
''',
      codeExplanation: 'Cubes each element in the list.',
    ),

    ProgrammingConcept(
      title: "Read File Line by Line",
      explanation: "Best way to process large files one line at a time.",
      code: '''
with open("data.txt") as f:
    for line in f:
        print(line.strip())
''',
      codeExplanation: 'Reads and prints each line after stripping whitespace.',
    ),

    ProgrammingConcept(
      title: "Command Line Arguments",
      explanation: "Use sys.argv to get arguments passed on the command line.",
      code: '''
import sys
print(sys.argv)
''',
      codeExplanation: 'sys.argv is a list: first item is filename, others are arguments.',
    ),

    ProgrammingConcept(
      title: "Checking Variable Existence",
      explanation: "Is a variable defined? Try/except NameError is safe way.",
      code: '''
try:
    print(x)
except NameError:
    print("x does not exist!")
''',
      codeExplanation: 'Catches undefined variable error gracefully.',
    ),

    ProgrammingConcept(
      title: "Min, Max, Sum Functions",
      explanation: "Quickly get smallest, largest, or total of numbers in a list.",
      code: '''
values = [2, 5, 3]
print(min(values), max(values), sum(values))
''',
      codeExplanation: 'Prints the minimum, maximum, and sum in one line.',
    ),
  ];


  LearnCPage({Key? key}) : super(key: key);

  // Helper: get appropriate text color for context and "mode"
  Color _mainTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Color(0xFFB2FF59) : Colors.black87;
  }

  Color _secondaryTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Color(0xFFB2FFDB) : Colors.black54;
  }

  Color _headlineTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Color(0xFF40C4FF) : Colors.teal[900]!;
  }

  Color _subtitleTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Color(0xFF90FFE2) : Colors.teal[700] ?? Colors.teal;
  }

  Color _cardBackground(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Color(0xFF232929) : Colors.yellow[50]!;
  }

  Color _conceptCardBackground(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Color(0xFF101918) : AppColors.background(context);
  }

  Color _codeBackground(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Color(0xFF212B28) : Colors.grey[200]!;
  }

  Color _codeFontColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Color(0xFFB2FF59) : Colors.black87;
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = deviceWidth * 0.05;
    final cardPadding = deviceWidth * 0.04;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Learn C Programming',
          style: AppTextStyles.appBar(context).copyWith(
            color: _mainTextColor(context),
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background(context),
        elevation: 0,
        iconTheme: IconThemeData(color: _mainTextColor(context)),
      ),
      backgroundColor: AppColors.background(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
        child: ListView.separated(
          itemCount: concepts.length + 1, // +1 so documentation is at top
          separatorBuilder: (_, __) => SizedBox(height: cardPadding * 0.6),
          itemBuilder: (context, index) {
            if (index == 0) {
              // Documentation at the top
              return Card(
                color: _cardBackground(context),
                margin: EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: SelectableText(
                    cDocumentation,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SourceCodePro',
                      color: _mainTextColor(context),
                    ),
                  ),
                ),
              );
            }
            final c = concepts[index - 1];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: _conceptCardBackground(context),
              child: Padding(
                padding: EdgeInsets.all(cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.title,
                      style: AppTextStyles.headline(context).copyWith(
                        color: _headlineTextColor(context),
                        fontSize: deviceWidth < 400 ? 16 : 20,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 10),
                    Text(
                      c.explanation,
                      style: AppTextStyles.body(context).copyWith(
                        color: _mainTextColor(context),
                        fontSize: deviceWidth < 400 ? 13 : 15,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _codeBackground(context),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SelectableText(
                          c.code,
                          style: TextStyle(
                            fontFamily: 'SourceCodePro',
                            fontSize: 14,
                            color: _codeFontColor(context),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      c.codeExplanation,
                      style: AppTextStyles.subtitle(context).copyWith(
                        color: _subtitleTextColor(context),
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}