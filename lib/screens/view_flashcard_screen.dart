import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/index.dart';

class ViewFlashcardScreen extends StatefulWidget {
  final String question;
  final String answer;
  final String category;

  const ViewFlashcardScreen({
    super.key,
    required this.question,
    required this.answer,
    required this.category,
  });

  @override
  State<ViewFlashcardScreen> createState() => _ViewFlashcardScreenState();
}

class _ViewFlashcardScreenState extends State<ViewFlashcardScreen> {
  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();

  void _flip() {
    if (_cardKey.currentState != null) {
      _cardKey.currentState!.toggleCard();
    }
  }

  /// SINGLE card widget used for both front & back
  Widget _buildCard({required String text, required bool isBack}) {
    final Color headerColor =
        isBack ? Colors.green.shade700 : Colors.blue.shade700;

    return Card(
      elevation: 16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors:
                isBack
                    ? [Colors.green.shade50, Colors.white]
                    : [Colors.blue.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // HEADER CHIP (QUESTION / ANSWER)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [
                    headerColor.withOpacity(0.85),
                    headerColor.withOpacity(0.55),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                isBack ? "ANSWER" : "QUESTION",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            const SizedBox(height: 12),

            //CATEGORY
            if (widget.category.isNotEmpty && widget.category != "General")
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(
                  widget.category,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // MAIN TEXT
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    height: 1.4,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            //  HINT TEXT BOTTOM
            Text(
              isBack ? "Tap to flip back" : "Tap to flip",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
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
          "Flashcard",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
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
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A6CF7), Color(0xFF7F56D9), Color(0xFF9E7BEE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // FLIP CARD
                Expanded(
                  child: GestureDetector(
                    onTap: _flip,
                    child: FlipCard(
                      key: _cardKey,
                      flipOnTouch: false,
                      front: _buildCard(text: widget.question, isBack: false),
                      back: _buildCard(text: widget.answer, isBack: true),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // BOTTOM BUTTONS
                Row(
                  children: [
                    Expanded(
                      child: AppButtons.primaryButton(
                        onPressed: _flip,
                        text: "Flip",
                        icon: Icons.flip,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButtons.secondaryButton(
                        onPressed: () => Navigator.pop(context),
                        text: "Close",
                        icon: Icons.close,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
