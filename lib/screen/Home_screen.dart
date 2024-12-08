import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final int initialHighScore;

  const HomeScreen({super.key, required this.initialHighScore});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int highScore;

  @override
  void initState() {
    super.initState();
    highScore = widget.initialHighScore;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is int) {
      setState(() {
        highScore = arguments;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: const Center(child: Text('Quiz App',style: TextStyle(fontWeight: FontWeight.bold),)),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150,),
            const Text('Welcome to the Quiz!',
             style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700)),
            const SizedBox(height: 30),
            Text('High Score: $highScore', style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
            const SizedBox(height: 250),

          
           GestureDetector(
              onTap: () async {
                // Start quiz and get updated high score
                final result = await Navigator.pushNamed(
                  context,
                  '/quiz',
                  arguments: highScore,
                );

                if (result != null && result is int) {
                  setState(() {
                    highScore = result;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 120),
                decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Start Quiz",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
     
            
          ],
        ),
      ),
    );
  }
}
