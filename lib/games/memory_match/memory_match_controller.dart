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
    );
  }

  void flipCard(int index) {
    if (_state.isGameOver || _state.isChecking) return;
    if (_state.cards[index].isMatched) return;
    if (index == _state.firstFlippedIndex || index == _state.secondFlippedIndex) {
      return;
    }

    final updatedCards = List.of(_state.cards);
    updatedCards[index] = updatedCards[index].copyWith(isFlipped: true);

    if (_state.firstFlippedIndex == null) {
      _state = _state.copyWith(
        cards: updatedCards,
        firstFlippedIndex: index,
      );
    } else if (_state.secondFlippedIndex == null) {
      _state = _state.copyWith(
        cards: updatedCards,
        secondFlippedIndex: index,
        isChecking: true,
      );
      _checkForMatch();
    }

    notifyListeners();
  }

  void _checkForMatch() {
    Future.delayed(const Duration(milliseconds: 600), () {
      final first = _state.firstFlippedIndex!;
      final second = _state.secondFlippedIndex!;

      if (_state.cards[first].value == _state.cards[second].value) {
        // Match found
        final updatedCards = List.of(_state.cards);
        updatedCards[first] = updatedCards[first].copyWith(isMatched: true);
        updatedCards[second] = updatedCards[second].copyWith(isMatched: true);

        final newMatchedPairs = _state.matchedPairs + 1;
        final isGameOver = newMatchedPairs == _state.totalPairs;

        _state = _state.copyWith(
          cards: updatedCards,
          matchedPairs: newMatchedPairs,
          moves: _state.moves + 1,
          firstFlippedIndex: null,
          secondFlippedIndex: null,
          isChecking: false,
          isGameOver: isGameOver,
        );
      } else {
        // No match
        final updatedCards = List.of(_state.cards);
        updatedCards[first] = updatedCards[first].copyWith(isFlipped: false);
        updatedCards[second] = updatedCards[second].copyWith(isFlipped: false);

        _state = _state.copyWith(
          cards: updatedCards,
          moves: _state.moves + 1,
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
