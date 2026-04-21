import 'package:flutter/material.dart';

class ProgressIndicatorCard extends StatelessWidget {
  final int currentIndex;
  final int totalCards;

  const ProgressIndicatorCard({
    super.key,
    required this.currentIndex,
    required this.totalCards,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: totalCards == 0
                  ? 0
                  : (currentIndex + 1) / totalCards,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.blue.shade700, // SAME COLOR
              ),
              minHeight: 8,
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Card ${currentIndex + 1} of $totalCards",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  totalCards == 0
                      ? "0%"
                      : "${(((currentIndex + 1) / totalCards) * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700, // SAME COLOR
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
