import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';


class QuizScreen extends StatefulWidget {
  const QuizScreen({required this.highScore});
 final int highScore;

 

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  late Timer timer;
  int timeLeft = 15;
  late int highScore;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          nextQuestion();
        }
      });
    });
  }

  void nextQuestion() {
    timer.cancel();
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        timeLeft = 15;
      });
      startTimer();
    } else {
      // Update high score if the current score is greater
      highScore = score > highScore ? score : highScore;

      // Navigate to results screen and return the high score
      Navigator.pushReplacementNamed(
        context,
        '/results',
        arguments: {'score': score, 'highScore': highScore},
      ).then((value) {
        Navigator.pop(context, highScore);
      });
    }
  }

  void checkAnswer(String selectedOption) {
    if (questions[currentQuestionIndex]['answer'] == selectedOption) {
      score++;
    }
    nextQuestion();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        highScore = ModalRoute.of(context)!.settings.arguments as int;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: const Text(
          'Take Quiz',
          style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Time Left: $timeLeft seconds', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Text('Score: $score', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Text('Progress: ${currentQuestionIndex + 1}/${questions.length}',
                style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            Text(currentQuestion['question'], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            ...currentQuestion['options'].map<Widget>((option) {
              return Center(
                child: ElevatedButton(
                  onPressed: () => checkAnswer(option),
                  child: Text(option,style: TextStyle(color: Colors.black),),
                  style: ElevatedButton.styleFrom(
      backgroundColor: Colors.yellow[700], // Background color of the button
       // Text color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
    ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
