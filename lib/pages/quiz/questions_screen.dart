import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanda_kata/data/questions.dart';
import 'package:tanda_kata/shared/theme.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(this.onSelectAnswer, {super.key});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;
  String? selectedAnswer;
  List<String>? shuffledAnswers;

  void selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  void nextQuestion() {
    if (selectedAnswer == null) return;

    widget.onSelectAnswer(selectedAnswer!);
    setState(() {
      currentQuestionIndex++;
      selectedAnswer = null;
      shuffledAnswers = null; // Shuffle fresh for next question
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];
    final isLastQuestion = currentQuestionIndex == questions.length - 1;

    // Initialize shuffledAnswers once per question
    shuffledAnswers ??= currentQuestion.getShuffledAnswers();

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: darkGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/sign_image.png', // update with your actual image path
                fit: BoxFit.contain,
                height: 150,
                errorBuilder: (context, error, stackTrace) => const Text(
                  'Image not found',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ...shuffledAnswers!.map((answer) {
              final isSelected = answer == selectedAnswer;
              return AnswerButton(
                answer,
                () => selectAnswer(answer),
                isSelected: isSelected,
              );
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: selectedAnswer == null ? null : nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: yellow,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                isLastQuestion ? 'SEE RESULTS' : 'NEXT QUESTION',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  const AnswerButton(this.answerText, this.onTap,
      {this.isSelected = false, super.key});

  final String answerText;
  final void Function() onTap;
  final bool isSelected;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          backgroundColor: isSelected ? darkGreen : lightGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          answerText,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
