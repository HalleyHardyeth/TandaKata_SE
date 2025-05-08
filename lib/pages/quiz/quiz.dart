import 'package:flutter/material.dart';
import 'package:tanda_kata/pages/quiz/questions_screen.dart';
import 'package:tanda_kata/data/questions.dart';
import 'package:tanda_kata/pages/quiz/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'questions-screen';

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget;

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(chooseAnswer);
    } else if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(selectedAnswers, restartQuiz);
    } else {
      screenWidget = QuestionsScreen(chooseAnswer); // Default
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: screenWidget, //false
        ),
      ),
    );
  }
}
