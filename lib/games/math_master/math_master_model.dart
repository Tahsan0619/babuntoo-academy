import 'dart:math';

class MathQuestion {
  final int num1;
  final int num2;
  final String operator;
  final int correctAnswer;
  final List<int> options;

  MathQuestion({
    required this.num1,
    required this.num2,
    required this.operator,
    required this.correctAnswer,
    required this.options,
  });
}

class MathMasterState {
  final List<MathQuestion> questions;
  final int currentQuestionIndex;
  final int score;
  final int timeRemaining;
  final bool isGameOver;

  MathMasterState({
    required this.questions,
    required this.currentQuestionIndex,
    required this.score,
    required this.timeRemaining,
    required this.isGameOver,
  });

  MathQuestion get currentQuestion => questions[currentQuestionIndex];
  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;
  int get totalQuestions => questions.length;

  MathMasterState copyWith({
    List<MathQuestion>? questions,
    int? currentQuestionIndex,
    int? score,
    int? timeRemaining,
    bool? isGameOver,
  }) {
    return MathMasterState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      isGameOver: isGameOver ?? this.isGameOver,
    );
  }
}

class MathMasterGame {
  static final Random _random = Random();

  static List<MathQuestion> generateQuestions({int count = 10}) {
    List<MathQuestion> questions = [];
    final operators = ['+', '-', '*', '÷'];

    for (int i = 0; i < count; i++) {
      final operator = operators[_random.nextInt(operators.length)];
      int num1, num2, answer;

      if (operator == '+') {
        num1 = _random.nextInt(50) + 1;
        num2 = _random.nextInt(50) + 1;
        answer = num1 + num2;
      } else if (operator == '-') {
        num1 = _random.nextInt(50) + 20;
        num2 = _random.nextInt(num1 - 1) + 1;
        answer = num1 - num2;
      } else if (operator == '*') {
        num1 = _random.nextInt(12) + 1;
        num2 = _random.nextInt(12) + 1;
        answer = num1 * num2;
      } else {
        // Division
        num2 = _random.nextInt(12) + 1;
        answer = _random.nextInt(12) + 1;
        num1 = answer * num2;
      }

      final options = _generateWrongOptions(answer);
      questions.add(MathQuestion(
        num1: num1,
        num2: num2,
        operator: operator,
        correctAnswer: answer,
        options: options,
      ));
    }

    return questions;
  }

  static List<int> _generateWrongOptions(int correctAnswer) {
    List<int> options = [correctAnswer];
    int attempts = 0;

    while (options.length < 4 && attempts < 100) {
      final wrong = correctAnswer + (_random.nextInt(20) - 10);
      if (wrong != correctAnswer && !options.contains(wrong) && wrong > 0) {
        options.add(wrong);
      }
      attempts++;
    }

    while (options.length < 4) {
      options.add(_random.nextInt(100) + 1);
    }

    options.shuffle();
    return options;
  }
}
