import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanda_kata/data/flashcard_data.dart';

class FlashcardModel {
  final String imageUrl;
  final String answer;

  FlashcardModel({required this.imageUrl, required this.answer});
}

class FlashcardPage extends StatefulWidget {
  const FlashcardPage({super.key});

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  late final List<FlashcardModel> flashcards;
  int currentIndex = 0;
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
    flashcards = flashcardData
        .where((item) => item['imageUrl'] != null && item['answer'] != null)
        .map((item) => FlashcardModel(
              imageUrl: item['imageUrl'] ?? '',
              answer: item['answer'] ?? '',
            ))
        .toList();
    // Optional: Shuffle the flashcards
  }

  void nextCard() {
    setState(() {
      if (currentIndex < flashcards.length - 1) {
        currentIndex++;
      }
    });
  }

  void prevCard() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashcard = flashcards[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              'Alphabet',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '${currentIndex + 1} out of ${flashcards.length}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => cardKey.currentState?.toggleCard(),
              child: FlipCard(
                key: cardKey,
                flipOnTouch: false,
                direction: FlipDirection.HORIZONTAL,
                front: _buildFrontCard(flashcard),
                back: _buildBackCard(flashcard),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Tap to see the answer!',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.black45,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavButton(Icons.arrow_back_ios, prevCard,
                      isEnabled: currentIndex > 0),
                  _buildNavButton(Icons.arrow_forward_ios, nextCard,
                      isEnabled: currentIndex < flashcards.length - 1),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildFrontCard(FlashcardModel card) {
    return Container(
      width: 300,
      height: 340,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2e7b74), Color(0xFF3b948b)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 6),
            blurRadius: 12,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.network(
              card.imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 100,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard(FlashcardModel card) {
    return Container(
      width: 300,
      height: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2e7b74), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 6),
            blurRadius: 12,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          card.answer,
          style: GoogleFonts.poppins(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2e7b74),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback onPressed,
      {required bool isEnabled}) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isEnabled ? const Color(0xFFFCA83D) : Colors.grey.shade300,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        elevation: isEnabled ? 6 : 0,
      ),
      child: Icon(icon, size: 24),
    );
  }
}
