import 'package:flutter/material.dart';
import 'package:quiz_app/screen/Home_screen.dart';
import 'package:quiz_app/screen/Quiz_screen.dart';
import 'package:quiz_app/screen/Results_screen.dart';


void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => HomeScreen(initialHighScore: 0),
        '/quiz': (context) => QuizScreen(highScore: 0,),
        '/results': (context) => ResultsScreen(),
      },
    );
  }
}
