import 'package:flutter/material.dart';
import 'hangman_model.dart';
import 'hangman_utils.dart';

class HangmanController extends ChangeNotifier {
  late HangmanGameState _state;

  HangmanController() {
    newGame();
  }

  HangmanGameState get state => _state;

  void newGame() {
    WordHint newWord = getRandomWord();
    _state = HangmanGameState(word: newWord.word, hint: newWord.hint);
    notifyListeners();
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
      }
    } else {
      wrongGuesses++;
      if (wrongGuesses >= _state.maxWrongGuesses) {
        status = HangmanGameStatus.lost;
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
