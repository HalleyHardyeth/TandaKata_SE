import 'package:flutter/material.dart';
import 'package:tanda_kata/Screens/StudyMaterial/studyMaterial_screen.dart';
import 'package:tanda_kata/Screens/Welcome/welcome_screen.dart';
import 'package:tanda_kata/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme:
          ThemeData(primaryColor: primaryColor, scaffoldBackgroundColor: card),
      home: const WelcomeScreen(),
    );
  }
}
