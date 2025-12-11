import 'dart:math';

class MemoryCard {
  final String id;
  final String value;
  bool isFlipped;
  bool isMatched;

  MemoryCard({
    required this.id,
    required this.value,
    this.isFlipped = false,
    this.isMatched = false,
  });

  MemoryCard copyWith({
    String? id,
    String? value,
    bool? isFlipped,
    bool? isMatched,
  }) {
    return MemoryCard(
      id: id ?? this.id,
      value: value ?? this.value,
      isFlipped: isFlipped ?? this.isFlipped,
      isMatched: isMatched ?? this.isMatched,
    );
  }
}

class MemoryMatchState {
  final List<MemoryCard> cards;
  final int moves;
  final int matchedPairs;
  final bool isGameOver;
  final int? firstFlippedIndex;
  final int? secondFlippedIndex;
  final bool isChecking;

  MemoryMatchState({
    required this.cards,
    required this.moves,
    required this.matchedPairs,
    required this.isGameOver,
    this.firstFlippedIndex,
    this.secondFlippedIndex,
    this.isChecking = false,
  });

  int get totalPairs => cards.length ~/ 2;

  MemoryMatchState copyWith({
    List<MemoryCard>? cards,
    int? moves,
    int? matchedPairs,
    bool? isGameOver,
    int? firstFlippedIndex,
    int? secondFlippedIndex,
    bool? isChecking,
  }) {
    return MemoryMatchState(
      cards: cards ?? this.cards,
      moves: moves ?? this.moves,
      matchedPairs: matchedPairs ?? this.matchedPairs,
      isGameOver: isGameOver ?? this.isGameOver,
      firstFlippedIndex: firstFlippedIndex ?? this.firstFlippedIndex,
      secondFlippedIndex: secondFlippedIndex ?? this.secondFlippedIndex,
      isChecking: isChecking ?? this.isChecking,
    );
  }
}

class MemoryMatchGame {
  static final List<String> _emojis = [
    '🍎', '🍎',
    '🍊', '🍊',
    '🍌', '🍌',
    '🍉', '🍉',
    '🍓', '🍓',
    '🍒', '🍒',
    '🍑', '🍑',
    '🥝', '🥝',
  ];

  static List<MemoryCard> generateCards() {
    final shuffled = List.of(_emojis);
    shuffled.shuffle();

    return List.generate(
      shuffled.length,
      (index) => MemoryCard(
        id: 'card_$index',
        value: shuffled[index],
      ),
    );
  }
}
