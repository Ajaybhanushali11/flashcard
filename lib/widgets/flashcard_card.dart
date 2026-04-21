import 'package:flutter/material.dart';
import 'buttons.dart';

class FlashcardCard extends StatelessWidget {
  final String question;
  final String answer;
  final String category;
  final bool showAnswer;

  final VoidCallback onToggleAnswer;
  final VoidCallback onFullScreen;

  const FlashcardCard({
    super.key,
    required this.question,
    required this.answer,
    required this.category,
    required this.showAnswer,
    required this.onToggleAnswer,
    required this.onFullScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔹 HEADER: QUESTION / ANSWER
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color:
                      showAnswer ? Colors.green.shade100 : Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  showAnswer ? "ANSWER" : "QUESTION",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color:
                        showAnswer
                            ? Colors.green.shade800
                            : Colors.blue.shade800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 Scrollable content
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    // 🔹 Category chip
                    if (category.isNotEmpty && category != "General")
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.blue.shade200),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 20),

                    // 🔹 Question / Answer Text
                    Text(
                      showAnswer ? answer : question,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 Bottom Buttons Row
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  Expanded(
                    child: AppButtons.secondaryButton(
                      onPressed: onToggleAnswer,
                      text: showAnswer ? "Hide Answer" : "Show Answer",
                      icon:
                          showAnswer ? Icons.visibility_off : Icons.visibility,
                      isSmall: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButtons.primaryButton(
                      onPressed: onFullScreen,
                      text: "Full Screen",
                      icon: Icons.fullscreen,
                      isSmall: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
