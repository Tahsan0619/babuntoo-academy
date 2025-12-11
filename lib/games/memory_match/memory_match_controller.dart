import 'package:flutter/material.dart';
import 'memory_match_model.dart';

class MemoryMatchController extends ChangeNotifier {
  late MemoryMatchState _state;

  MemoryMatchController() {
    _initGame();
  }

  MemoryMatchState get state => _state;

  void _initGame() {
    final cards = MemoryMatchGame.generateCards();
    _state = MemoryMatchState(
      cards: cards,
      moves: 0,
      matchedPairs: 0,
      isGameOver: false,
      firstFlippedIndex: null,
      secondFlippedIndex: null,
      isChecking: false,
    );
  }

  void flipCard(int index) {
    if (_state.isGameOver || _state.isChecking) return;
    if (_state.cards[index].isMatched || _state.cards[index].isFlipped) return;
    
    final updatedCards = List<MemoryCard>.from(_state.cards);
    updatedCards[index] = updatedCards[index].copyWith(isFlipped: true);

    if (_state.firstFlippedIndex == null) {
      // First card flip
      _state = MemoryMatchState(
        cards: updatedCards,
        moves: _state.moves,
        matchedPairs: _state.matchedPairs,
        isGameOver: _state.isGameOver,
        firstFlippedIndex: index,
        secondFlippedIndex: null,
        isChecking: false,
      );
      notifyListeners();
    } else if (_state.secondFlippedIndex == null) {
      // Second card flip
      _state = MemoryMatchState(
        cards: updatedCards,
        moves: _state.moves,
        matchedPairs: _state.matchedPairs,
        isGameOver: _state.isGameOver,
        firstFlippedIndex: _state.firstFlippedIndex,
        secondFlippedIndex: index,
        isChecking: true,
      );
      notifyListeners();
      _checkForMatch();
    }
  }

  void _checkForMatch() {
    Future.delayed(const Duration(milliseconds: 600), () {
      final first = _state.firstFlippedIndex;
      final second = _state.secondFlippedIndex;
      
      if (first == null || second == null) return;

      final updatedCards = List<MemoryCard>.from(_state.cards);
      final newMoves = _state.moves + 1;

      if (updatedCards[first].value == updatedCards[second].value) {
        // Match found
        updatedCards[first] = updatedCards[first].copyWith(
          isMatched: true,
          isFlipped: true,
        );
        updatedCards[second] = updatedCards[second].copyWith(
          isMatched: true,
          isFlipped: true,
        );

        final newMatchedPairs = _state.matchedPairs + 1;
        final isGameOver = newMatchedPairs == _state.totalPairs;

        _state = MemoryMatchState(
          cards: updatedCards,
          moves: newMoves,
          matchedPairs: newMatchedPairs,
          isGameOver: isGameOver,
          firstFlippedIndex: null,
          secondFlippedIndex: null,
          isChecking: false,
        );
      } else {
        // No match - flip back
        updatedCards[first] = updatedCards[first].copyWith(isFlipped: false);
        updatedCards[second] = updatedCards[second].copyWith(isFlipped: false);

        _state = MemoryMatchState(
          cards: updatedCards,
          moves: newMoves,
          matchedPairs: _state.matchedPairs,
          isGameOver: false,
          firstFlippedIndex: null,
          secondFlippedIndex: null,
          isChecking: false,
        );
      }

      notifyListeners();
    });
  }

  void newGame() {
    _initGame();
    notifyListeners();
  }
}
