import 'package:flutter/material.dart';
import 'buttons.dart';

class NavigationControls extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const NavigationControls({
    super.key,
    required this.onPrevious,
    required this.onNext,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // 🔹 PREVIOUS BUTTON – same style as pehle
            Expanded(
              child: AppButtons.secondaryButton(
                onPressed: onPrevious,
                text: 'Previous',
                icon: Icons.arrow_back,
                isSmall: true,
              ),
            ),

            const SizedBox(width: 12),

            // 🔹 MIDDLE EDIT / DELETE SECTION – same UI
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: onEdit,
                    tooltip: 'Edit Flashcard',
                    color: Colors.blue.shade600,
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.grey.shade300,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: onDelete,
                    tooltip: 'Delete Flashcard',
                    color: Colors.red.shade600,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // 🔹 NEXT BUTTON – same style as pehle
            Expanded(
              child: AppButtons.primaryButton(
                onPressed: onNext,
                text: 'Next',
                icon: Icons.arrow_forward,
                isSmall: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
