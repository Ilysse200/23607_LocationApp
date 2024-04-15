// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  const Result({Key? key, required this.resultScore, required this.resetHandler}) : super(key: key);

  // Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore >= 41) {
      resultText = 'You are awesome!';
      print(resultScore);
    } else if (resultScore >= 31) {
      resultText = 'Pretty likeable!';
      print(resultScore);
    } else if (resultScore >= 21) {
      resultText = 'You need to work more!';
    } else if (resultScore >= 1) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
      print(resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhrase,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ), // Text
          Text(
            'Score $resultScore',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ), // Text
          TextButton(
            onPressed: () {
              // Pop until reaching the first route
              Navigator.of(context).popUntil((route) => route.isFirst);
              
              // Optionally, navigate to a specific named route
              // Navigator.of(context).pushReplacementNamed('/mainQuizScreen');
              
              // Calling resetHandler if you still need to reset any state
              resetHandler();
            },
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(14),
              child: const Text(
                'Restart Quiz',
                style: TextStyle(color: Colors.white), // Adjusted for better visibility
              ),
            ),
          ),
        ], // <Widget>[]
      ), // Column
    ); // Center
  }
}
