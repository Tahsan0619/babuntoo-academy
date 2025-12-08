import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/data_models.dart';
import '../widgets/custom_card.dart';
// import '../widgets/quiz_widget.dart'; // Uncomment if you add quizzes

class ProgrammingLanguagesPage extends StatelessWidget {
  final List<ProgrammingProject> projects = [
    // --- Python Projects ---

    // 1. Small
    ProgrammingProject(
      language: "Python",
      projectTitle: "Simple Calculator",
      description: "A small project demonstrating functions for basic addition.",
      codeSnippet: '''
def add(a, b):
    return a + b

print("2 + 3 =", add(2, 3))
''',
    ),
    // 2. Medium
    ProgrammingProject(
      language: "Python",
      projectTitle: "Mini Web Scraper",
      description: "A medium project using requests and BeautifulSoup to print all H2 headers from a webpage.",
      codeSnippet: '''
import requests
from bs4 import BeautifulSoup

url = "https://example.com"
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

for item in soup.find_all('h2'):
    print(item.text)
''',
    ),
    // 3. Big
    ProgrammingProject(
      language: "Python",
      projectTitle: "Iris Classifier (Machine Learning)",
      description: "A big project training a Random Forest classifier on the iris dataset.",
      codeSnippet: '''
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

data = load_iris()
X_train, X_test, y_train, y_test = train_test_split(data.data, data.target, test_size=0.2)
clf = RandomForestClassifier()
clf.fit(X_train, y_train)
predictions = clf.predict(X_test)
print('Accuracy:', accuracy_score(y_test, predictions))
''',
    ),
    // 4. Small
    ProgrammingProject(
      language: "Python",
      projectTitle: "Number Guessing Game",
      description: "A fun console game where the user guesses a random number.",
      codeSnippet: '''
import random

number = random.randint(1, 100)
while True:
    guess = int(input("Guess a number (1-100): "))
    if guess == number:
        print("Correct!")
        break
    elif guess < number:
        print("Too low, try again.")
    else:
        print("Too high, try again.")
''',
    ),

// 5. Small/Medium
    ProgrammingProject(
      language: "Python",
      projectTitle: "Word Counter",
      description: "Counts the number of words in a user-provided sentence.",
      codeSnippet: '''
sentence = input("Enter a sentence: ")
words = sentence.split()
print("Number of words:", len(words))
''',
    ),

// 6. Medium
    ProgrammingProject(
      language: "Python",
      projectTitle: "To-Do List CLI App",
      description: "Lets users add, view, and mark tasks as complete from the command line.",
      codeSnippet: '''
tasks = []

while True:
    command = input("Add/View/Done/Exit: ").lower()
    if command == "add":
        tasks.append(input("Task: "))
    elif command == "view":
        for i, task in enumerate(tasks):
            print(f"{i+1}. {task}")
    elif command == "done":
        idx = int(input("Task number to mark done: ")) - 1
        if 0 <= idx < len(tasks):
            tasks.pop(idx)
    elif command == "exit":
        break
''',
    ),

// 7. Medium
    ProgrammingProject(
      language: "Python",
      projectTitle: "Simple Contact Book",
      description: "A dictionary-based program to add, search, and display simple contact info.",
      codeSnippet: '''
contacts = {}

while True:
    action = input("Add/Search/View/Exit: ").lower()
    if action == "add":
        name = input("Name: ")
        phone = input("Phone: ")
        contacts[name] = phone
    elif action == "search":
        name = input("Name to search: ")
        print(f"{name}: {contacts.get(name, 'Not found')}")
    elif action == "view":
        for name, phone in contacts.items():
            print(f"{name}: {phone}")
    elif action == "exit":
        break
''',
    ),

// 8. Medium
    ProgrammingProject(
      language: "Python",
      projectTitle: "Weather Fetcher (API)",
      description: "Uses the OpenWeatherMap API to fetch and display weather for a city.",
      codeSnippet: '''
import requests

city = input("Enter city: ")
api_key = "YOUR_API_KEY"
url = f"http://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}&units=metric"
response = requests.get(url).json()
print("Temperature:", response['main']['temp'], "°C")
''',
    ),

// 9. Big
    ProgrammingProject(
      language: "Python",
      projectTitle: "Flashcard Quiz App",
      description: "Quiz app where users can add, test, and remove flashcards.",
      codeSnippet: '''
flashcards = {}

while True:
    mode = input("Add/Test/Delete/Exit: ").lower()
    if mode == "add":
        q = input("Question: ")
        a = input("Answer: ")
        flashcards[q] = a
    elif mode == "test":
        for q, a in flashcards.items():
            ans = input(q + " ")
            print("Correct!" if ans.strip().lower() == a.strip().lower() else f"Wrong, answer is: {a}")
    elif mode == "delete":
        q = input("Question to delete: ")
        flashcards.pop(q, None)
    elif mode == "exit":
        break
''',
    ),

    ProgrammingProject(
      language: "Python",
      projectTitle: "Personal Diary App (Text File)",
      description: "A diary/journal program where users can write diary entries that are saved to and loaded from a text file. User can add new entries or view all past entries.",
      codeSnippet: '''
def add_entry():
    entry = input("Write your diary entry: ")
    with open("diary.txt", "a", encoding="utf-8") as f:
        f.write(entry + "\\n")
    print("Entry saved!")

def view_entries():
    print("\\nYour Diary Entries:")
    try:
        with open("diary.txt", "r", encoding="utf-8") as f:
            for line in f:
                print("-", line.strip())
    except FileNotFoundError:
        print("No entries found.")

while True:
    action = input("add/view/exit: ").strip().lower()
    if action == "add":
        add_entry()
    elif action == "view":
        view_entries()
    elif action == "exit":
        break
''',
    ),

    // --- C Projects ---

    // 1. Small
    ProgrammingProject(
      language: "C",
      projectTitle: "Hello World",
      description: "A classic starter: prints 'Hello, World!' to the console.",
      codeSnippet: '''
#include <stdio.h>

int main() {
    printf("Hello, World!");
    return 0;
}
''',
    ),
    // 2. Medium
    ProgrammingProject(
      language: "C",
      projectTitle: "File I/O Demo",
      description: "A medium project demonstrating reading and writing a simple text file.",
      codeSnippet: '''
#include <stdio.h>

int main() {
    FILE *fp;
    char buffer[100];
    fp = fopen("test.txt", "w");
    fprintf(fp, "Hello File I/O");
    fclose(fp);

    fp = fopen("test.txt", "r");
    fgets(buffer, 100, fp);
    printf("Read from file: %s\\n", buffer);
    fclose(fp);
    return 0;
}
''',
    ),
    // 3. Big
    ProgrammingProject(
      language: "C",
      projectTitle: "Simple Linked List",
      description: "A bigger project implementing a simple integer linked list and printing the nodes.",
      codeSnippet: '''
#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int data;
    struct Node *next;
} Node;

void printList(Node *n) {
    while (n != NULL) {
        printf("%d -> ", n->data);
        n = n->next;
    }
    printf("NULL\\n");
}

int main() {
    Node* head = NULL;
    Node* second = NULL;
    Node* third = NULL;

    head = (Node*)malloc(sizeof(Node));
    second = (Node*)malloc(sizeof(Node));
    third = (Node*)malloc(sizeof(Node));

    head->data = 1;
    head->next = second;

    second->data = 2;
    second->next = third;

    third->data = 3;
    third->next = NULL;

    printList(head);
    return 0;
}
''',
    ),
    // 4. Small
    ProgrammingProject(
      language: "C",
      projectTitle: "Simple Calculator (Menu-driven)",
      description: "A calculator that performs +, -, *, / using switch and user input.",
      codeSnippet: '''
#include <stdio.h>

int main() {
    int choice;
    double a, b;
    printf("Enter two numbers: ");
    scanf("%lf%lf", &a, &b);
    printf("1.Add 2.Subtract 3.Multiply 4.Divide\\nChoose: ");
    scanf("%d", &choice);
    switch (choice) {
        case 1: printf("%.2lf\\n", a+b); break;
        case 2: printf("%.2lf\\n", a-b); break;
        case 3: printf("%.2lf\\n", a*b); break;
        case 4: if (b!=0) printf("%.2lf\\n", a/b); else printf("Div by zero!\\n"); break;
        default: printf("Invalid choice.\\n");
    }
    return 0;
}
''',
    ),

// 5. Small/Medium
    ProgrammingProject(
      language: "C",
      projectTitle: "Number Pattern Printer",
      description: "Prints a user-defined triangle number pattern using nested loops.",
      codeSnippet: '''
#include <stdio.h>

int main() {
    int n;
    printf("Rows: ");
    scanf("%d", &n);
    for(int i=1;i<=n;i++) {
        for(int j=1;j<=i;j++)
            printf("%d ", j);
        printf("\\n");
    }
    return 0;
}
''',
    ),

// 6. Medium
    ProgrammingProject(
      language: "C",
      projectTitle: "Find Prime Numbers (Sieve of Eratosthenes)",
      description: "Lists all prime numbers up to a user-given number using classic sieve.",
      codeSnippet: '''
#include <stdio.h>
#define MAX 1000

int main() {
    int n, isPrime[MAX] = {0};
    printf("Find primes up to: ");
    scanf("%d", &n);
    for(int i=2; i<=n; i++) isPrime[i]=1;
    for(int i=2;i*i<=n;i++)
        if(isPrime[i])
            for(int j=i*i;j<=n;j+=i) isPrime[j]=0;
    for(int i=2;i<=n;i++)
        if(isPrime[i]) printf("%d ", i);
    printf("\\n");
    return 0;
}
''',
    ),

// 7. Medium
    ProgrammingProject(
      language: "C",
      projectTitle: "Student Grades Average",
      description: "Reads grades for multiple students, stores in an array, and prints the class average.",
      codeSnippet: '''
#include <stdio.h>

int main() {
    int n;
    printf("Number of students: ");
    scanf("%d", &n);
    float grades[n], sum = 0;
    for(int i=0;i<n;i++) {
        printf("Grade for student %d: ", i+1);
        scanf("%f", &grades[i]);
        sum += grades[i];
    }
    printf("Class average: %.2f\\n", sum/n);
    return 0;
}
''',
    ),

// 8. Medium
    ProgrammingProject(
      language: "C",
      projectTitle: "Reverse a String (Array)",
      description: "Reverses a user-entered string in place using arrays.",
      codeSnippet: '''
#include <stdio.h>
#include <string.h>

int main() {
    char s[100];
    printf("Enter string: ");
    scanf("%s", s);
    int n = strlen(s);
    for(int i=0;i<n/2;i++) {
        char tmp = s[i];
        s[i] = s[n-1-i];
        s[n-1-i] = tmp;
    }
    printf("Reversed: %s\\n", s);
    return 0;
}
''',
    ),

// 9. Big
    ProgrammingProject(
      language: "C",
      projectTitle: "Tic-Tac-Toe (Console Game)",
      description: "A 2-player text-based tic-tac-toe game using a char array board and input.",
      codeSnippet: '''
#include <stdio.h>

void draw(char b[]) {
    printf("%c|%c|%c\\n-+-+-\\n%c|%c|%c\\n-+-+-\\n%c|%c|%c\\n",
      b[0],b[1],b[2],b[3],b[4],b[5],b[6],b[7],b[8]);
}
int win(char b[]) {
    int wins[8][3]={{0,1,2},{3,4,5},{6,7,8},{0,3,6},{1,4,7},{2,5,8},{0,4,8},{2,4,6}};
    for(int i=0;i<8;i++)
        if(b[wins[i][0]]==b[wins[i][1]] && b[wins[i][1]]==b[wins[i][2]])
            return 1;
    return 0;
}
int main() {
    char board[9] = {'1','2','3','4','5','6','7','8','9'};
    int move, player = 0, moves = 0;
    while(1) {
        draw(board);
        printf("Player %d, move (1-9): ", player+1);
        scanf("%d", &move); move--;
        if(move < 0 || move > 8 || board[move]=='X' || board[move]=='O') {
           printf("Invalid move!\\n"); continue;
        }
        board[move] = player==0?'X':'O';
        moves++;
        if(win(board)) { draw(board); printf("Player %d wins!\\n", player+1); break; }
        if(moves==9)   { draw(board); printf("Tie!\\n"); break; }
        player = 1-player;
    }
    return 0;
}
''',
    ),

// 10. Big
    ProgrammingProject(
      language: "C",
      projectTitle: "Basic Bank Management System (Structs)",
      description: "Manages simple accounts with structs: add, show, deposit, withdraw, and search users.",
      codeSnippet: '''
#include <stdio.h>
#include <string.h>

typedef struct {
    char name[20];
    int account;
    float balance;
} Account;

int main() {
    Account accs[100];
    int n = 0, choice;
    while (1) {
        printf("1.Add 2.Show 3.Deposit 4.Withdraw 5.Find 6.Exit\\nYour choice: ");
        scanf("%d", &choice);
        if (choice==1) {
            printf("Name: "); scanf("%s", accs[n].name);
            printf("Account No: "); scanf("%d", &accs[n].account);
            accs[n].balance = 0; n++;
        } else if (choice==2) {
            for(int i=0;i<n;i++) printf("%d %s %.2f\\n", accs[i].account, accs[i].name, accs[i].balance);
        } else if (choice==3 || choice==4) {
            int ac; float amt; printf("Account No: "); scanf("%d", &ac); printf("Amount: "); scanf("%f", &amt);
            for(int i=0;i<n;i++) if (accs[i].account==ac) {
                if (choice==3) accs[i].balance += amt;
                else if (amt <= accs[i].balance) accs[i].balance -= amt;
                else printf("Insufficient.\\n");
            }
        } else if (choice==5) {
            int ac; printf("Account No: "); scanf("%d", &ac);
            for(int i=0;i<n;i++) if(accs[i].account==ac) printf("%s %.2f\\n", accs[i].name, accs[i].balance);
        } else if (choice==6) break;
    }
    return 0;
}
''',
    ),
  ];

  ProgrammingLanguagesPage({Key? key}) : super(key: key);

  Color _headlineColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF40C4FF)
          : AppColors.primary(context);

  Color _subtitleColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF90FFE2)
          : (Colors.teal[700] ?? Colors.teal);

  Color _mainTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFFB2FF59)
          : AppColors.mainText(context);

  Color _codeBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF212B28)
          : Colors.grey[200]!;

  Color _codeFontColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFFB2FF59)
          : Colors.black87;

  Color _dialogBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF131D1C)
          : AppColors.background(context);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = deviceWidth * 0.05;
    final double cardPadding = deviceWidth * 0.04;
    final double iconSize = deviceWidth * 0.07 + 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Programming Languages',
          style: AppTextStyles.appBar(context).copyWith(color: _headlineColor(context)),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background(context),
        elevation: 0,
        iconTheme: IconThemeData(color: _headlineColor(context)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10),
        child: ListView.separated(
          separatorBuilder: (_, __) => SizedBox(height: cardPadding * 0.6),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return CustomCard(
              leading: Icon(Icons.code, size: iconSize, color: _headlineColor(context)),
              title: "${project.language}: ${project.projectTitle}",
              subtitle: project.description,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(
                      project.projectTitle,
                      style: TextStyle(
                        color: _headlineColor(context),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Language: ${project.language}",
                            style: TextStyle(
                              color: _subtitleColor(context),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _codeBg(context),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SelectableText(
                                project.codeSnippet,
                                style: TextStyle(
                                  fontFamily: 'SourceCodePro',
                                  fontSize: 14,
                                  color: _codeFontColor(context),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(
                          'Close',
                          style: TextStyle(
                            color: _headlineColor(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    backgroundColor: _dialogBg(context),
                  ),
                );
              },
            );
          },
        ),
      ),
      backgroundColor: AppColors.background(context),
    );
  }
}