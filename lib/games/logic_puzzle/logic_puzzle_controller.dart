import 'package:flutter/material.dart';
import 'logic_puzzle_model.dart';

class LogicPuzzleController extends ChangeNotifier {
  late LogicPuzzleState _state;
  bool _showExplanation = false;

  LogicPuzzleController() {
    _initGame();
  }

  LogicPuzzleState get state => _state;
  bool get showExplanation => _showExplanation;

  void _initGame() {
    final puzzles = LogicPuzzleGame.generatePuzzles();
    _state = LogicPuzzleState(
      puzzles: puzzles,
      currentPuzzleIndex: 0,
      correctAnswers: 0,
      isGameOver: false,
    );
    _showExplanation = false;
  }

  void answerQuestion(int selectedIndex) {
    if (_state.isGameOver) return;

    final isCorrect = selectedIndex == _state.currentPuzzle.correctIndex;
    int newCorrectAnswers = _state.correctAnswers + (isCorrect ? 1 : 0);

    _showExplanation = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 800), () {
      if (_state.isLastPuzzle) {
        // Game over
        _state = _state.copyWith(
          correctAnswers: newCorrectAnswers,
          isGameOver: true,
        );
      } else {
        // Next puzzle
        _state = _state.copyWith(
          currentPuzzleIndex: _state.currentPuzzleIndex + 1,
          correctAnswers: newCorrectAnswers,
        );
        _showExplanation = false;
      }
      notifyListeners();
    });
  }

  void nextPuzzle() {
    if (_state.isGameOver) return;

    if (_state.isLastPuzzle) {
      _state = _state.copyWith(isGameOver: true);
    } else {
      _state = _state.copyWith(
        currentPuzzleIndex: _state.currentPuzzleIndex + 1,
      );
      _showExplanation = false;
    }
    notifyListeners();
  }

  void newGame() {
    _initGame();
    notifyListeners();
  }
}
