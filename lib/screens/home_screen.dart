import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../animations/custom_animations.dart';
import '../provider/flashcard_provider.dart';
import '../widgets/index.dart'; // all widgets from parts
import 'add_edit_screen.dart';
import 'view_flashcard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openViewScreen(BuildContext context, String q, String a, String c) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => ViewFlashcardScreen(question: q, answer: a, category: c),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        title: Text(
          "Flashcards",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),

      //  Gradient Background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A6CF7), Color(0xFF7F56D9), Color(0xFF9E7BEE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Consumer<FlashcardProvider>(
            builder: (context, provider, child) {
              if (provider.flashcards.isEmpty) {
                return _emptyState();
              }
              return _content(context, provider);
            },
          ),
        ),
      ),

      floatingActionButton: FadeInWidget(
        duration: const Duration(milliseconds: 900),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
            gradient: const LinearGradient(
              colors: [Color(0xFF4A6CF7), Color(0xFF7F56D9)],
            ),
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddEditScreen()),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SlideInWidget(
          begin: const Offset(0, 1),
          duration: const Duration(milliseconds: 800),
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.95),
                    Colors.blue.shade50.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 80,
                    color: Colors.blue.shade600,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "No Flashcards Yet!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Tap the + button to create your first flashcard",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.blue.shade600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // main _content
  Widget _content(BuildContext context, FlashcardProvider provider) {
    if (provider.flashcards.isEmpty || provider.currentFlashcard == null) {
      return const Center(
        child: Text(
          'No flashcards yet.\nTap + button to add your first card!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }
    final card = provider.currentFlashcard!;

    return Column(
      children: [
        // Progress
        ProgressIndicatorCard(
          currentIndex: provider.currentIndex,
          totalCards: provider.flashcards.length,
        ),

        // Flashcard
        Expanded(
          child: GestureDetector(
            onTap:
                () => _openViewScreen(
                  context,
                  card.question,
                  card.answer,
                  card.category,
                ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FadeInWidget(
                duration: const Duration(milliseconds: 400),
                child: FlashcardCard(
                  question: card.question,
                  answer: card.answer,
                  category: card.category,
                  showAnswer: provider.showAnswer,
                  onToggleAnswer: provider.toggleAnswer,
                  onFullScreen: () {
                    _openViewScreen(
                      context,
                      card.question,
                      card.answer,
                      card.category,
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        // Navigation controls
        NavigationControls(
          onPrevious: provider.previousCard,
          onNext: provider.nextCard,
          onEdit: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddEditScreen(flashcard: card)),
            );
          },
          onDelete: () {
            AppDialogs.showDeleteFlashcardDialog(
              context: context,
              onConfirm: () {
                provider.deleteFlashcard(card.id);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Flashcard deleted successfully"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
