import 'package:flutter/material.dart';
import 'math_master_model.dart';

class MathMasterController extends ChangeNotifier {
  late MathMasterState _state;
  late DateTime _gameStartTime;
  late DateTime _lastTimerUpdate;

  MathMasterController() {
    _initGame();
  }

  MathMasterState get state => _state;

  void _initGame() {
    final questions = MathMasterGame.generateQuestions(count: 10);
    _state = MathMasterState(
      questions: questions,
      currentQuestionIndex: 0,
      score: 0,
      timeRemaining: 180, // 3 minutes
      isGameOver: false,
    );
    _gameStartTime = DateTime.now();
    _lastTimerUpdate = DateTime.now();
  }

  void answerQuestion(int selectedAnswer) {
    if (_state.isGameOver) return;

    final isCorrect = selectedAnswer == _state.currentQuestion.correctAnswer;
    int newScore = _state.score;
    if (isCorrect) {
      newScore += 10;
    }

    if (_state.isLastQuestion) {
      // Game over
      _state = _state.copyWith(
        score: newScore,
        isGameOver: true,
      );
      notifyListeners();
    } else {
      // Next question
      _state = _state.copyWith(
        currentQuestionIndex: _state.currentQuestionIndex + 1,
        score: newScore,
      );
      notifyListeners();
    }
  }

  void updateTimer(int remaining) {
    if (remaining <= 0) {
      _state = _state.copyWith(timeRemaining: 0, isGameOver: true);
    } else {
      _state = _state.copyWith(timeRemaining: remaining);
    }
    notifyListeners();
  }

  void newGame() {
    _initGame();
    notifyListeners();
  }
}
