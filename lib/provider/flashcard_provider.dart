import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/flashcard_model.dart';

class FlashcardProvider with ChangeNotifier {
  List<Flashcard> _flashcards = [];
  int _currentIndex = 0;
  bool _showAnswer = false;

  List<Flashcard> get flashcards => _flashcards;
  int get currentIndex => _currentIndex;
  bool get showAnswer => _showAnswer;
  Flashcard? get currentFlashcard =>
      _flashcards.isNotEmpty ? _flashcards[_currentIndex] : null;

  static const String _storageKey = 'flashcards_data';

  FlashcardProvider() {
    _loadFlashcards();
  }

  // Load flashcards from SharedPreferences
  Future<void> _loadFlashcards() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? flashcardsJson = prefs.getString(_storageKey);

      if (flashcardsJson != null) {
        final List<dynamic> parsedList = json.decode(flashcardsJson);
        _flashcards =
            parsedList.map((item) {
              return Flashcard(
                id: item['id'],
                question: item['question'],
                answer: item['answer'],
                category: item['category'],
                createdAt: DateTime.parse(item['createdAt']),
              );
            }).toList();
        notifyListeners();
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error loading flashcards: $error');
      }
    }
  }

  // Save flashcards to SharedPreferences
  Future<void> _saveFlashcards() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> flashcardsMap =
          _flashcards.map((card) {
            return {
              'id': card.id,
              'question': card.question,
              'answer': card.answer,
              'category': card.category,
              'createdAt': card.createdAt.toIso8601String(),
            };
          }).toList();

      await prefs.setString(_storageKey, json.encode(flashcardsMap));
    } catch (error) {
      if (kDebugMode) {
        print('Error saving flashcards: $error');
      }
    }
  }

  Future<void> addFlashcard(
    String question,
    String answer,
    String category,
  ) async {
    final newFlashcard = Flashcard(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      question: question,
      answer: answer,
      category: category.isEmpty ? 'General' : category,
      createdAt: DateTime.now(),
    );

    _flashcards.insert(0, newFlashcard);
    await _saveFlashcards();
    notifyListeners();
  }

  Future<void> updateFlashcard(Flashcard flashcard) async {
    final index = _flashcards.indexWhere((f) => f.id == flashcard.id);
    if (index != -1) {
      _flashcards[index] = flashcard;
      await _saveFlashcards();
      notifyListeners();
    }
  }

  Future<void> deleteFlashcard(String id) async {
    _flashcards.removeWhere((f) => f.id == id);
    if (_currentIndex >= _flashcards.length) {
      _currentIndex = _flashcards.length - 1;
    }
    await _saveFlashcards();
    notifyListeners();
  }

  void nextCard() {
    if (_flashcards.isNotEmpty) {
      _currentIndex = (_currentIndex + 1) % _flashcards.length;
      _showAnswer = false;
      notifyListeners();
    }
  }

  void previousCard() {
    if (_flashcards.isNotEmpty) {
      _currentIndex =
          (_currentIndex - 1 + _flashcards.length) % _flashcards.length;
      _showAnswer = false;
      notifyListeners();
    }
  }

  void toggleAnswer() {
    _showAnswer = !_showAnswer;
    notifyListeners();
  }

  void resetView() {
    _showAnswer = false;
    notifyListeners();
  }

  void jumpToCard(int index) {
    if (index >= 0 && index < _flashcards.length) {
      _currentIndex = index;
      _showAnswer = false;
      notifyListeners();
    }
  }

  // Clear all flashcards
  Future<void> clearAllFlashcards() async {
    _flashcards.clear();
    _currentIndex = 0;
    _showAnswer = false;
    await _saveFlashcards();
    notifyListeners();
  }
}
