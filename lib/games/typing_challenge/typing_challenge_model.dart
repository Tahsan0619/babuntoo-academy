const List<String> typingWords = [
  'flutter', 'dart', 'programming', 'challenge', 'accuracy',
  'keyboard', 'responsive', 'animation', 'gradient', 'listener',
  'provider', 'scrollview', 'gesture', 'material', 'scaffold',
  'context', 'widget', 'stateful', 'stateless', 'theme',
  'algorithm', 'function', 'variable', 'constant', 'parameter',
  'database', 'network', 'security', 'performance', 'optimize',
  'framework', 'library', 'package', 'dependency', 'version',
  'compile', 'debug', 'release', 'build', 'deployment',
];

class TypingChallengState {
  final String currentWord;
  final String userInput;
  final int correctWords;
  final int totalWords;
  final int timeRemaining;
  final bool isGameOver;
  final double accuracy;
  final List<String> usedWords;

  TypingChallengState({
    required this.currentWord,
    required this.userInput,
    required this.correctWords,
    required this.totalWords,
    required this.timeRemaining,
    required this.isGameOver,
    required this.accuracy,
    required this.usedWords,
  });

  bool get isWordCorrect => userInput.toLowerCase() == currentWord.toLowerCase();

  TypingChallengState copyWith({
    String? currentWord,
    String? userInput,
    int? correctWords,
    int? totalWords,
    int? timeRemaining,
    bool? isGameOver,
    double? accuracy,
    List<String>? usedWords,
  }) {
    return TypingChallengState(
      currentWord: currentWord ?? this.currentWord,
      userInput: userInput ?? this.userInput,
      correctWords: correctWords ?? this.correctWords,
      totalWords: totalWords ?? this.totalWords,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      isGameOver: isGameOver ?? this.isGameOver,
      accuracy: accuracy ?? this.accuracy,
      usedWords: usedWords ?? this.usedWords,
    );
  }
}

class TypingChallengeGame {
  static String getRandomWord(List<String> usedWords) {
    String word;
    do {
      word = typingWords[(usedWords.length) % typingWords.length];
    } while (usedWords.contains(word));
    return word;
  }
}
