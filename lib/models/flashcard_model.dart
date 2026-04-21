class Flashcard {
  final String id;
  final String question;
  final String answer;
  final String category;
  final DateTime createdAt;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
    required this.createdAt,
  });

  Flashcard copyWith({
    String? id,
    String? question,
    String? answer,
    String? category,
    DateTime? createdAt,
  }) {
    return Flashcard(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}