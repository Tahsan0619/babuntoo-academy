import 'package:flutter/material.dart';

enum HangmanGameStatus { playing, won, lost }

class HangmanGameState {
  final String word;
  final String hint;
  final Set<String> guessedLetters;
  final int wrongGuesses;
  final int maxWrongGuesses;
  final HangmanGameStatus status;

  HangmanGameState({
    required this.word,
    required this.hint,
    this.guessedLetters = const {},
    this.wrongGuesses = 0,
    this.maxWrongGuesses = 6,
    this.status = HangmanGameStatus.playing,
  });

  String get displayWord {
    return word
        .split('')
        .map((c) => guessedLetters.contains(c.toUpperCase()) ? c : '_')
        .join(' ');
  }

  bool get isGameOver => status != HangmanGameStatus.playing;
  bool get isWon => status == HangmanGameStatus.won;
  bool get isLost => status == HangmanGameStatus.lost;

  HangmanGameState copyWith({
    Set<String>? guessedLetters,
    int? wrongGuesses,
    HangmanGameStatus? status,
    String? hint,
  }) {
    return HangmanGameState(
      word: word,
      hint: hint ?? this.hint,
      guessedLetters: guessedLetters ?? this.guessedLetters,
      wrongGuesses: wrongGuesses ?? this.wrongGuesses,
      maxWrongGuesses: this.maxWrongGuesses,
      status: status ?? this.status,
    );
  }
}
