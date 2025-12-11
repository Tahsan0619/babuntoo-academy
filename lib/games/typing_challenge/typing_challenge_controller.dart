import 'package:flutter/material.dart';
import 'typing_challenge_model.dart';

class TypingChallengeController extends ChangeNotifier {
  late TypingChallengState _state;

  TypingChallengeController() {
    _initGame();
  }

  TypingChallengState get state => _state;

  void _initGame() {
    final initialWord = TypingChallengeGame.getRandomWord([]);
    _state = TypingChallengState(
      currentWord: initialWord,
      userInput: '',
      correctWords: 0,
      totalWords: 0,
      timeRemaining: 120, // 2 minutes
      isGameOver: false,
      accuracy: 100,
      usedWords: [initialWord],
    );
  }

  void updateInput(String input) {
    if (_state.isGameOver) return;

    if (input.isEmpty) {
      _state = _state.copyWith(userInput: '');
      notifyListeners();
      return;
    }

    // Check if user just typed a space (word complete)
    if (input.endsWith(' ')) {
      final word = input.trim();

      if (word.isNotEmpty) {
        final isCorrect = _state.isWordCorrect;
        int newCorrectWords = _state.correctWords + (isCorrect ? 1 : 0);
        int newTotalWords = _state.totalWords + 1;
        double newAccuracy =
            (newCorrectWords / newTotalWords * 100).clamp(0, 100);

        // Get next word
        final nextWord = TypingChallengeGame.getRandomWord(_state.usedWords);
        final usedWords = [..._state.usedWords, nextWord];

        _state = _state.copyWith(
          currentWord: nextWord,
          userInput: '',
          correctWords: newCorrectWords,
          totalWords: newTotalWords,
          accuracy: newAccuracy,
          usedWords: usedWords,
        );
      }
    } else {
      _state = _state.copyWith(userInput: input);
    }

    notifyListeners();
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
