import 'package:flutter/material.dart';

enum HangmanGameStatus { playing, won, lost }

enum HangmanDifficulty { easy, medium, hard }

class HangmanGameState {
  final String word;
  final String hint;
  final Set<String> guessedLetters;
  final int wrongGuesses;
  final int maxWrongGuesses;
  final HangmanGameStatus status;
  final HangmanDifficulty difficulty;
  final int score;
  final int totalRoundsWon;
  final int totalRoundsLost;

  HangmanGameState({
    required this.word,
    required this.hint,
    this.guessedLetters = const {},
    this.wrongGuesses = 0,
    this.maxWrongGuesses = 6,
    this.status = HangmanGameStatus.playing,
    this.difficulty = HangmanDifficulty.easy,
    this.score = 0,
    this.totalRoundsWon = 0,
    this.totalRoundsLost = 0,
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

  int get remainingGuesses => maxWrongGuesses - wrongGuesses;

  // Calculate score based on difficulty and remaining guesses
  int calculateRoundScore() {
    if (!isWon) return 0;
    
    int baseScore = difficulty == HangmanDifficulty.easy
        ? 50
        : difficulty == HangmanDifficulty.medium
            ? 100
            : 150;
    
    int bonusScore = remainingGuesses * 10;
    return baseScore + bonusScore;
  }

  HangmanGameState copyWith({
    Set<String>? guessedLetters,
    int? wrongGuesses,
    HangmanGameStatus? status,
    String? hint,
    HangmanDifficulty? difficulty,
    int? score,
    int? totalRoundsWon,
    int? totalRoundsLost,
  }) {
    return HangmanGameState(
      word: word,
      hint: hint ?? this.hint,
      guessedLetters: guessedLetters ?? this.guessedLetters,
      wrongGuesses: wrongGuesses ?? this.wrongGuesses,
      maxWrongGuesses: this.maxWrongGuesses,
      status: status ?? this.status,
      difficulty: difficulty ?? this.difficulty,
      score: score ?? this.score,
      totalRoundsWon: totalRoundsWon ?? this.totalRoundsWon,
      totalRoundsLost: totalRoundsLost ?? this.totalRoundsLost,
    );
  }
}
