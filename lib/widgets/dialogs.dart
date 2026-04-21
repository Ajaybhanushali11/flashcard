import 'package:flutter/material.dart';

import 'buttons.dart';

class AppDialogs {
  /// Reusable delete confirmation dialog for flashcards
  static Future<void> showDeleteFlashcardDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
    String title = 'Delete Flashcard',
    String message =
        'Are you sure you want to delete this flashcard? This action cannot be undone.',
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.warning, size: 48, color: Colors.orange),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    // CANCEL BUTTON (same style as secondary button)
                    Expanded(
                      child: AppButtons.secondaryButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        text: 'Cancel',
                        icon: Icons.cancel,
                        isSmall: false,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // DELETE BUTTON (red, jaise pehle tha)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Pehle dialog band
                            Navigator.of(dialogContext).pop();
                            // Phir actual delete logic
                            onConfirm();
                          },
                          icon: const Icon(Icons.delete, size: 20),
                          label: const Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade600,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
