import 'package:flutter/material.dart';
import 'hangman_model.dart';
import 'hangman_utils.dart';

class HangmanController extends ChangeNotifier {
  late HangmanGameState _state;
  HangmanDifficulty _selectedDifficulty = HangmanDifficulty.easy;
  bool _showDifficultySelection = true;

  HangmanController() {
    newGame();
  }

  HangmanGameState get state => _state;
  HangmanDifficulty get selectedDifficulty => _selectedDifficulty;
  bool get showDifficultySelection => _showDifficultySelection;

  void selectDifficulty(HangmanDifficulty difficulty) {
    _selectedDifficulty = difficulty;
    _showDifficultySelection = false;
    startNewGame();
  }

  void startNewGame() {
    WordHint newWord = getRandomWord();
    _state = HangmanGameState(
      word: newWord.word,
      hint: newWord.hint,
      difficulty: _selectedDifficulty,
    );
    notifyListeners();
  }

  void newGame() {
    if (_showDifficultySelection) {
      return;
    }
    startNewGame();
  }

  void resetGame() {
    _showDifficultySelection = true;
    newGame();
  }

  void guessLetter(String letter) {
    if (_state.isGameOver) return;

    String upperLetter = letter.toUpperCase();
    if (_state.guessedLetters.contains(upperLetter)) return;

    final newGuessed = Set<String>.from(_state.guessedLetters)..add(upperLetter);
    int wrongGuesses = _state.wrongGuesses;
    HangmanGameStatus status = HangmanGameStatus.playing;

    if (_state.word.contains(upperLetter)) {
      if (isWordGuessed(_state.word, newGuessed)) {
        status = HangmanGameStatus.won;
        int roundScore = _state.copyWith(
          guessedLetters: newGuessed,
          status: status,
        ).calculateRoundScore();
        
        _state = _state.copyWith(
          guessedLetters: newGuessed,
          wrongGuesses: wrongGuesses,
          status: status,
          score: _state.score + roundScore,
          totalRoundsWon: _state.totalRoundsWon + 1,
        );
        notifyListeners();
        return;
      }
    } else {
      wrongGuesses++;
      if (wrongGuesses >= _state.maxWrongGuesses) {
        status = HangmanGameStatus.lost;
        _state = _state.copyWith(
          guessedLetters: newGuessed,
          wrongGuesses: wrongGuesses,
          status: status,
          totalRoundsLost: _state.totalRoundsLost + 1,
        );
        notifyListeners();
        return;
      }
    }

    _state = _state.copyWith(
      guessedLetters: newGuessed,
      wrongGuesses: wrongGuesses,
      status: status,
    );
    notifyListeners();
  }
}
