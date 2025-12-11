class LogicPuzzle {
  final String title;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  LogicPuzzle({
    required this.title,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class LogicPuzzleState {
  final List<LogicPuzzle> puzzles;
  final int currentPuzzleIndex;
  final int correctAnswers;
  final bool isGameOver;

  LogicPuzzleState({
    required this.puzzles,
    required this.currentPuzzleIndex,
    required this.correctAnswers,
    required this.isGameOver,
  });

  LogicPuzzle get currentPuzzle => puzzles[currentPuzzleIndex];
  bool get isLastPuzzle => currentPuzzleIndex == puzzles.length - 1;
  int get totalPuzzles => puzzles.length;

  LogicPuzzleState copyWith({
    List<LogicPuzzle>? puzzles,
    int? currentPuzzleIndex,
    int? correctAnswers,
    bool? isGameOver,
  }) {
    return LogicPuzzleState(
      puzzles: puzzles ?? this.puzzles,
      currentPuzzleIndex: currentPuzzleIndex ?? this.currentPuzzleIndex,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      isGameOver: isGameOver ?? this.isGameOver,
    );
  }
}

class LogicPuzzleGame {
  static List<LogicPuzzle> generatePuzzles() {
    return [
      LogicPuzzle(
        title: 'What comes next in the sequence?\n2, 4, 8, 16, ?',
        options: ['24', '32', '28', '20'],
        correctIndex: 1,
        explanation: 'Each number is doubled: 2→4→8→16→32',
      ),
      LogicPuzzle(
        title: 'If all cats are animals, and Fluffy is a cat,\nthen Fluffy is:',
        options: [
          'Not an animal',
          'An animal',
          'Maybe an animal',
          'Unknown',
        ],
        correctIndex: 1,
        explanation: 'By logical deduction, if Fluffy is a cat, and all cats are animals, then Fluffy must be an animal.',
      ),
      LogicPuzzle(
        title: 'What is the missing number?\n1, 1, 2, 3, 5, 8, ?',
        options: ['11', '12', '13', '14'],
        correctIndex: 2,
        explanation: 'This is the Fibonacci sequence where each number is the sum of the previous two: 5+8=13',
      ),
      LogicPuzzle(
        title: 'Which shape completes the pattern?\n○ □ △ ○ □ ?',
        options: ['△', '○', '□', '◇'],
        correctIndex: 0,
        explanation: 'The pattern repeats: Circle, Square, Triangle. After □ comes △.',
      ),
      LogicPuzzle(
        title: 'If A=1, B=2, C=3... what is Z?',
        options: ['24', '25', '26', '27'],
        correctIndex: 2,
        explanation: 'Z is the 26th letter of the alphabet, so Z=26.',
      ),
      LogicPuzzle(
        title: 'A car travels 60 km in 1 hour.\nHow far does it travel in 3 hours?',
        options: ['120 km', '180 km', '90 km', '240 km'],
        correctIndex: 1,
        explanation: 'At 60 km/hour, in 3 hours: 60 × 3 = 180 km.',
      ),
      LogicPuzzle(
        title: 'What number is missing?\n5, 10, 15, ?, 25, 30',
        options: ['18', '20', '22', '19'],
        correctIndex: 1,
        explanation: 'This is an arithmetic sequence increasing by 5: 5, 10, 15, 20, 25, 30.',
      ),
      LogicPuzzle(
        title: 'If today is Monday, what day will it be\nin 10 days?',
        options: ['Monday', 'Tuesday', 'Wednesday', 'Thursday'],
        correctIndex: 3,
        explanation: 'Monday + 10 days = Thursday (10 = 1 week + 3 days)',
      ),
    ];
  }
}
