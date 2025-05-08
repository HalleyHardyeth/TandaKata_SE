import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanda_kata/shared/theme.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              return SummaryItem(data);
            },
          ).toList(),
        ),
      ),
    );
  }
}

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(context) {
    final isCorrectAnswer =
        itemData['user_answer'] == itemData['correct_answer'];

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionsIdentifier(
            itemData['question_index'] as int,
            isCorrectAnswer,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, //dia start dari empty space terdekat
              children: [
                Text(
                  itemData['question'] as String,
                  style: GoogleFonts.poppins(
                    color: darkGreen,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Your answer : ${itemData['user_answer'] as String}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Correct answer : ${itemData['correct_answer'] as String}',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionsIdentifier extends StatelessWidget {
  const QuestionsIdentifier(this.questionIndex, this.isCorrectAnswer,
      {super.key});

  final int questionIndex;
  final bool isCorrectAnswer;

  @override
  Widget build(context) {
    final questionNumber = questionIndex + 1;
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isCorrectAnswer ? darkGreen : yellow,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        questionNumber.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
