import 'package:flutter/material.dart';
import 'challenge_model.dart';
import 'challenge_data.dart';

class ChallengeController extends ChangeNotifier {
  int _problemIndex = -1;
  int _questionIndex = 0;
  String _feedback = '';
  bool _showExplanation = false;
  List<bool> _stepsCorrect = [];

  int get problemIndex => _problemIndex;
  int get questionIndex => _questionIndex;
  String get feedback => _feedback;
  bool get showExplanation => _showExplanation;
  List<bool> get stepsCorrect => _stepsCorrect;
  bool get hasStarted => _problemIndex >= 0;

  Problem get currentProblem => problems[_problemIndex];
  MCQQuestion get currentQuestion => currentProblem.questions[_questionIndex];
  int get totalSteps => hasStarted ? currentProblem.questions.length : 0;

  void pickProblem(int index) {
    _problemIndex = index;
    _questionIndex = 0;
    _feedback = '';
    _showExplanation = false;
    _stepsCorrect = List.filled(problems[index].questions.length, false);
    notifyListeners();
  }

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == currentQuestion.correctIndex) {
      _feedback = '✅ Correct!';
      _showExplanation = false;
      _stepsCorrect[_questionIndex] = true;
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 800), () {
        nextQuestion();
      });
    } else {
      _feedback = '❌ Incorrect!';
      _showExplanation = true;
      _stepsCorrect[_questionIndex] = false;
      notifyListeners();
    }
  }

  void nextQuestion() {
    if (_questionIndex < currentProblem.questions.length - 1) {
      _questionIndex++;
    } else {
      // Challenge complete: return to list
      _problemIndex = -1;
    }
    _feedback = '';
    _showExplanation = false;
    notifyListeners();
  }

  void previousQuestion() {
    if (_questionIndex > 0) {
      _questionIndex--;
      _feedback = '';
      _showExplanation = false;
      notifyListeners();
    }
  }

  void reset() {
    _problemIndex = -1;
    _questionIndex = 0;
    _feedback = '';
    _showExplanation = false;
    _stepsCorrect = [];
    notifyListeners();
  }
}
