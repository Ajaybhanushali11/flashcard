import 'package:flashcardapp/provider/flashcard_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/flashcard_model.dart';
import '../widgets/index.dart'; // new widget system (buttons, textfields, dialogs)

class AddEditScreen extends StatefulWidget {
  final Flashcard? flashcard;

  const AddEditScreen({super.key, this.flashcard});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.flashcard != null) {
      _questionController.text = widget.flashcard!.question;
      _answerController.text = widget.flashcard!.answer;
      _categoryController.text = widget.flashcard!.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.flashcard != null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit Flashcard' : 'Add Flashcard',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.8,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,

        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        actions:
            isEdit
                ? [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        if (widget.flashcard == null) return;
                        _onDeleteFlashcard(widget.flashcard!.id);
                      },
                    ),
                  ),
                ]
                : null,
      ),

      //  SAME GRADIENT AS HOME
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4A6CF7), Color(0xFF7F56D9), Color(0xFF9E7BEE)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Form(
                  key: _formKey,

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //  Question
                      AppTextFields.primaryTextField(
                        controller: _questionController,
                        labelText: 'Question',
                        hintText: 'Enter your question...',
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a question';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      //  Answer
                      AppTextFields.primaryTextField(
                        controller: _answerController,
                        labelText: 'Answer',
                        hintText: 'Enter the answer...',
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter an answer';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      //  Category (optional)
                      AppTextFields.primaryTextField(
                        controller: _categoryController,
                        labelText: 'Category (optional)',
                        hintText: 'e.g., Math, GK, English',
                        maxLines: 1,
                        validator: null, // optional
                      ),

                      const SizedBox(height: 24),

                      // BUTTONS (Cancel + Save) – using AppButtons
                      Row(
                        children: [
                          Expanded(
                            child: AppButtons.secondaryButton(
                              onPressed: () => Navigator.pop(context),
                              text: 'Cancel',
                              icon: Icons.cancel,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppButtons.primaryButton(
                              onPressed: _saveFlashcard,
                              text: isEdit ? 'Update' : 'Add',
                              icon: isEdit ? Icons.save : Icons.add,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // SAVE FLASHCARD
  Future<void> _saveFlashcard() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final provider = Provider.of<FlashcardProvider>(context, listen: false);

      final String category =
          _categoryController.text.trim().isEmpty
              ? 'General'
              : _categoryController.text.trim();

      if (widget.flashcard == null) {
        await provider.addFlashcard(
          _questionController.text.trim(),
          _answerController.text.trim(),
          category,
        );
      } else {
        final updated = widget.flashcard!.copyWith(
          question: _questionController.text.trim(),
          answer: _answerController.text.trim(),
          category: category,
        );
        await provider.updateFlashcard(updated);
      }

      Navigator.pop(context);
    } catch (e) {
      // Optionally show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving flashcard: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // DELETE FLASHCARD USING AppDialogs
  void _onDeleteFlashcard(String id) {
    AppDialogs.showDeleteFlashcardDialog(
      context: context,
      onConfirm: () {
        Provider.of<FlashcardProvider>(
          context,
          listen: false,
        ).deleteFlashcard(id);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Flashcard deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context); // screen se back
      },
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    _categoryController.dispose();
    super.dispose();
  }
}
