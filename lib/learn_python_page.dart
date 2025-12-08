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

const String pythonDocumentation = '''
Python Programming: Complete Beginner’s Documentation

What is Python?
Python is a modern, high-level programming language known for its readability, simplicity, and wide application. Its syntax is clear and easy to learn, making it a great first language. Python is interpreted, which means your code runs line by line—so you get instant feedback and errors are easy to spot. It is widely used in web development, data science, automation, scripting, AI/ML, and more.

Why Learn Python?
- Beginner-friendly: Clean, readable code promotes fast learning.
- Powerful and versatile: Used by Google, YouTube, NASA, and many industries.
- Tons of libraries: For AI, web, cloud, graphics, games, experiments, and more.
- Works everywhere: Windows, Mac, Linux—even your phone!
- Giant community: Tutorials, help, and solutions everywhere.
- Write less, do more: Many tasks need just a few lines.
- Teaches good habits that transfer to other languages.

Core Topics Covered
This section will guide you step-by-step from your first Python code to practical skills, covering all the essentials before advanced OOP and frameworks.

1. Python Program Structure
- A script is just a list of commands executed from top to bottom.
- No mandatory `main()` function, but best practice to use it for larger projects.
- Indentation replaces curly braces to define groups/blocks (typically 4 spaces).
- Use `#` for comments.
- Example:
  print("Hello, World!")

2. Variables & Data Types
- No need to declare types—Python infers them.
- Variable assignment is simple:
  age = 20
  name = "Alice"
  pi = 3.1416
- Main types:
  - int (whole numbers)
  - float (decimals)
  - str (strings of text)
  - bool (True, False)
  - list, tuple, dict, set (collections)
- Use `type()` to see a variable’s type: print(type(age))

3. Input & Output
- Output: print() displays values to the screen.
  print("Score:", score)
- Input: input() gets text from the user. It always returns a string, so cast if needed:
  user_name = input("Enter your name: ")
  age = int(input("Enter your age: "))
- f-Strings for easy formatting:
  print(f"Hello, {user_name}! You are {age} years old.")

4. Operators
- Arithmetic: +, -, *, /, // (integer division), % (modulo), ** (power)
- Comparison: >, <, >=, <=, ==, !=
- Logical: and, or, not
- Assignment: =, +=, -=, *=, /=
- Membership: in, not in
- Example:
  if x % 2 == 0: print("Even")

5. Conditional Statements
- if, elif, else provide branching logic.
- Example:
  if temp > 30:
      print("Hot")
  elif temp > 20:
      print("Warm")
  else:
      print("Cool")
- Ternary expression: result = "Yes" if value > 0 else "No"

6. Loops
- for loop iterates over a sequence (list, string, range).
  for i in range(5):
      print(i)
- while loop: repeats as long as condition is true.
  while n > 0:
      print(n)
      n -= 1
- Use break to exit loop, continue to skip to the next iteration.
- Loops can be nested.

7. Lists, Tuples, Sets, and Dictionaries
- List: ordered, changeable collection: scores = [10, 20, 30]
- Tuple: ordered, unchangeable collection: point = (2, 3)
- Set: unordered, unique items: ids = {2, 3, 5}
- Dictionary: key-value pairs: person = {"name": "Sam", "age": 25}
- Index with [ ]: print(scores[0])
- Methods like .append(), .remove(), .update()
- Use len() for length

8. Strings
- Strings are sequences of characters. Use single or double quotes.
  text = "Hello"
  letter = text[1]  # "e"
- Common methods: .upper(), .lower(), .replace(), .find(), .split(), .join()
- f-Strings for easy inline formatting (f"{var}")

9. Functions
- Define with def keyword:
  def greet(name):
      print(f"Hello, {name}!")
- Return values with return
- Arguments can have defaults: def add(x, y=2): return x + y
- Scope: variables defined inside a function are local.

10. Modules and Imports
- Use import to include modules (libraries).
  import math
  from math import sqrt
- Create your own modules by saving functions in .py files.
- Common modules: math, random, datetime, os, sys, json

11. File Input/Output
- Reading and writing files:
  with open("file.txt", "w") as f:
      f.write("Hello!")
  with open("file.txt") as f:
      content = f.read()
- Modes: "r" (read), "w" (write), "a" (append)
- Use .readlines() or iterate for lines

12. Exception Handling
- Try, except blocks catch errors:
  try:
      x = int(input())
  except ValueError:
      print("Not a number.")
- Optional: else (runs if no error), finally (always runs).

13. List Comprehensions and Lambda
- Short ways to make lists: squares = [x*x for x in range(10)]
- Lambda for small functions: add = lambda a, b: a + b

14. Miscellaneous
- Comments: use # for single-line
- Indentation is crucial: code blocks must be consistently indented
- bool is built-in (True/False)
- None means “nothing” or “no value”
- Slicing: nums[1:3]
- Range: range(0, 10, 2)  # 0,2,4,6,8
- type() and isinstance() for checking types
- Use help() or dir() in the interpreter for documentation

How to Learn
- Try every example in an interpreter (IDLE, Jupyter, online tools, etc).
- Experiment by changing values and adding print statements.
- Solve small challenges (FizzBuzz, calculator, guessing game) as you go.
- Investigate error messages, don’t be afraid of mistakes.

Tips for Success
- Read lots of code—Python has excellent open-source projects.
- Practice every day to cement syntax and patterns.
- Use built-in help and documentation tools.
- Be curious: try modules from the Python Standard Library.
- Make your code readable: variable names, comments, and good structure.
- Ask for help in forums, StackOverflow, or with friends.
- Focus on building: real projects are the best teacher.

Let’s get started!
Now you’re ready to explore the examples and lessons below. Step by step, you’ll master every key topic in Python programming—from “Hello, World!” to working with files, exceptions, and more.

Happy coding!
''';


class LearnPythonPage extends StatelessWidget {
  final List<ProgrammingConcept> concepts = [
    // ---- BASICS ----
    ProgrammingConcept(
      title: "Variables",
      explanation: "Python variables are created by assignment. No need for explicit declaration.",
      code: '''
age = 20
weight = 62.5
grade = 'A'

print("Age:", age)
print("Weight:", weight)
print("Grade:", grade)
''',
      codeExplanation: 'Variables are created automatically with the type Python detects from the right-side value.',
    ),
    ProgrammingConcept(
      title: "Data Types",
      explanation: "Main types: int, float, str, bool, list, tuple, dict.",
      code: '''
a = 5         # int
b = 7.31      # float
c = "Hello"   # str
flag = True   # bool
nums = [1,2,3]   # list
point = (4,5)    # tuple
user = {"name": "Alice", "age": 21}  # dict
''',
      codeExplanation: 'Each example shows a common built-in type.',
    ),
    ProgrammingConcept(
      title: "Input & Output",
      explanation: "Use input() to read user input (always a string). Use print() for output.",
      code: '''
name = input("Enter your name: ")
age = input("Your age? ")
print("Hi", name)
print("You are", age, "years old.")
''',
      codeExplanation: 'Reads user data and prints personalized greetings. Note input() always returns a string.',
    ),
    // ---- OPERATORS & EXPRESSIONS ----
    ProgrammingConcept(
      title: "Arithmetic Operators",
      explanation: "Python supports + - * / // % ** for calculations.",
      code: '''
x = 6; y = 3
print(x + y)   # 9
print(x - y)   # 3
print(x * y)   # 18
print(x / y)   # 2.0
print(x // y)  # 2
print(x % y)   # 0
print(x ** y)  # 216
''',
      codeExplanation: 'Includes integer division (//) and exponentiation (**).',
    ),
    ProgrammingConcept(
      title: "Relational & Logical Operators",
      explanation: "Relational: >, <, >=, <=, ==, !=; Logical: and, or, not.",
      code: '''
x = 10; y = 15
print(x > y)      # False
print(x < y)      # True
print(x == y)     # False
print((x < y) and (x != 0))    # True
print(not (x == y))            # True
''',
      codeExplanation: 'Comparison returns True or False; logical operators combine/negate.',
    ),
    ProgrammingConcept(
      title: "Ternary Operator",
      explanation: "Conditional expression: value_if_true if condition else value_if_false.",
      code: '''
num = 9
print("Even" if num % 2 == 0 else "Odd")
''',
      codeExplanation: 'A one-liner for simple conditionals, e.g., even/odd test.',
    ),
    // ---- CONTROL FLOW ----
    ProgrammingConcept(
      title: "If, Elif, Else",
      explanation: "Python uses indentation to define blocks for conditionals.",
      code: '''
score = 78
if score >= 90:
    print("Excellent")
elif score >= 60:
    print("Passed")
else:
    print("Try Again")
''',
      codeExplanation: 'Determines feedback based on score using nested if/elif/else.',
    ),
    ProgrammingConcept(
      title: "Switch Alternative",
      explanation: "No built-in switch; use if-elif, or match-case (Python 3.10+).",
      code: '''
grade = "B"
if grade == "A":
    print("Outstanding")
elif grade == "B":
    print("Very Good")
elif grade == "C":
    print("Good")
else:
    print("Needs Improvement")
''',
      codeExplanation: 'if-elif replaces switch logic in Python.',
    ),
    ProgrammingConcept(
      title: "Loops: For and While",
      explanation: "Use for for known repeats/iteration, while for repeated checks.",
      code: '''
for i in range(1, 6):
    print(i, end=" ")

x = 1
while x <= 3:
    print(x, end=" ")
    x += 1
''',
      codeExplanation: 'Prints 1-5 via for, and 1 2 3 via while.',
    ),
    // ---- DATA STRUCTURES ----
    ProgrammingConcept(
      title: "Lists",
      explanation: "Lists are ordered, changeable, and can contain elements of any type.",
      code: '''
nums = [10, 20, 30]
nums.append(40)
nums[0] = 5
print(nums)     # [5, 20, 30, 40]
print(nums[2])  # 30
''',
      codeExplanation: 'Shows how to add, change, and access elements in a Python list.',
    ),
    ProgrammingConcept(
      title: "Tuples",
      explanation: "Tuples are like lists, but unchangeable (immutable).",
      code: '''
point = (3, 4)
# point[0] = 7   # Error! Tuples cannot be changed
print(point[1])  # 4
''',
      codeExplanation: 'Tuples are a good choice for fixed collections of values.',
    ),
    ProgrammingConcept(
      title: "Dictionaries",
      explanation: "Dictionaries store key-value pairs for fast lookup.",
      code: '''
user = {"name": "Arif", "age": 22}
print(user["name"])          # Arif
user["city"] = "Dhaka"
print(user)                  # {'name': 'Arif', 'age': 22, 'city': 'Dhaka'}
''',
      codeExplanation: 'Shows creation, lookup, and editing of a dictionary.',
    ),
    ProgrammingConcept(
      title: "Sets",
      explanation: "Sets are unordered collections of unique elements.",
      code: '''
a = {1, 2, 3}
b = {2, 3, 4}
print(a | b)  # Union: {1, 2, 3, 4}
print(a & b)  # Intersection: {2, 3}
''',
      codeExplanation: 'Set operations for union and intersection.',
    ),
    // ---- STRINGS ----
    ProgrammingConcept(
      title: "String Methods",
      explanation: "Python provides many functions for working with strings.",
      code: '''
s = "hi python"
print(s.upper())     # HI PYTHON
print(s.title())     # Hi Python
print(s.replace("h", "H"))  # Hi Python
print(len(s))        # 9
''',
      codeExplanation: 'String functions for uppercase, title case, replacement, and length.',
    ),
    ProgrammingConcept(
      title: "Slicing",
      explanation: "Extract portions of lists, strings, or tuples using slices.",
      code: '''
text = "Bangladesh"
print(text[0:6])     # Bangla
nums = [0, 1, 2, 3, 4, 5]
print(nums[2:5])     # [2, 3, 4]
''',
      codeExplanation: 'Slicing uses [start:end] notation (end index not included).',
    ),
    // ---- ADVANCED BUILT-IN OPERATIONS/UTILITIES ----
    ProgrammingConcept(
      title: "Range",
      explanation: "range creates sequences of numbers for looping.",
      code: '''
for n in range(2, 8, 2):
    print(n)
''',
      codeExplanation: 'Prints 2, 4, 6 (start, stop, step).',
    ),
    ProgrammingConcept(
      title: "List Comprehensions",
      explanation: "A short way to create a new list from another list.",
      code: '''
squares = [x*x for x in range(5)]
print(squares)   # [0, 1, 4, 9, 16]
''',
      codeExplanation: 'Generates a list of squares for 0 to 4.',
    ),
    ProgrammingConcept(
      title: "Enumerate and Zip",
      explanation: "enumerate() gets index and value; zip() combines multiple lists.",
      code: '''
colors = ["red", "green", "blue"]
for idx, color in enumerate(colors):
    print(idx, color)

a = [1, 2]
b = ['a', 'b']
for x, y in zip(a, b):
    print(x, y)
''',
      codeExplanation: 'enumerate and zip are useful in loops working with lists.',
    ),
    ProgrammingConcept(
      title: "Lambda (Anonymous Functions)",
      explanation: "Functions without names, often used for quick, small operations.",
      code: '''
add = lambda x, y: x + y
print(add(2, 3))  # 5

nums = [1, 2, 3, 4]
doubled = list(map(lambda n: n*2, nums))
print(doubled)    # [2, 4, 6, 8]
''',
      codeExplanation: 'Lambda expressions as shortcuts for very short functions.',
    ),
    // ---- FUNCTIONS & EXCEPTION HANDLING ----
    ProgrammingConcept(
      title: "Functions",
      explanation: "Define reusable code blocks with def, return values with return.",
      code: '''
def multiply(x, y):
    return x * y

result = multiply(4, 5)
print(result)
''',
      codeExplanation: 'Defines and uses a function to multiply two numbers.',
    ),
    ProgrammingConcept(
      title: "Exception Handling",
      explanation: "Use try/except to handle runtime errors gracefully.",
      code: '''
try:
    n = int(input("Enter a number: "))
    print(100 / n)
except ZeroDivisionError:
    print("Cannot divide by zero!")
except ValueError:
    print("That wasn't a number!")
''',
      codeExplanation: 'Handles specific errors from user input.',
    ),
    // ---- MODULES/FILES ----
    ProgrammingConcept(
      title: "File Handling",
      explanation: "Read and write files easily with open(), and the with-as context.",
      code: '''
with open("hello.txt", "w") as file:
    file.write("Python is easy!")

with open("hello.txt") as file:
    content = file.read()
    print(content)
''',
      codeExplanation: 'Writes to and then reads from a text file.',
    ),
    ProgrammingConcept(
      title: "Modules and Imports",
      explanation: "Import modules to use extra functionality (math, random, etc).",
      code: '''
import math
print(math.sqrt(25))  # 5.0

from random import randint
print(randint(1, 10))  # Random integer 1-10
''',
      codeExplanation: 'Shows how to import whole modules or specific functions.',
    ),
    // ---- DEVELOPER UTILITIES ----
    ProgrammingConcept(
      title: "None and Boolean Values",
      explanation: "None is the absence of a value. True and False are booleans.",
      code: '''
a = None
if a is None:
    print("Nothing assigned!")

flag = True
if flag:
    print("Yes, it's true.")
''',
      codeExplanation: 'None signals “no value”. Boolean allows if-tests.',
    ),
    ProgrammingConcept(
      title: "Docstrings and Help",
      explanation: "Triple-quoted strings at the start of a function describe its purpose.",
      code: '''
def area_circle(r):
    """Return the area of a circle with radius r."""
    return 3.1416 * r * r

print(area_circle.__doc__)
help(area_circle)
''',
      codeExplanation: 'Python can show your docstring to users with help() or .__doc__.',
    ),
  ];


  LearnPythonPage({Key? key}) : super(key: key);

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
          'Learn Python Programming',
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
          itemCount: concepts.length + 1,
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
                    pythonDocumentation,
                    style: TextStyle(
                      fontFamily: 'SourceCodePro',
                      fontSize: 15,
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