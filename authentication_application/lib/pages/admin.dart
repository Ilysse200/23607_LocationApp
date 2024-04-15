import 'package:authentication_application/Superior/quiz_creation.dart';
import 'package:authentication_application/screens/quiz_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Adjust these imports to match the actual file paths in your project
import 'package:authentication_application/Superior/quiz_creation.dart';
import 'package:authentication_application/screens/QuizResultListScreen.dart'  as quizResults;



class AdminFunctions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuizCreationView())),
            child: Text('Create Quiz'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuizListScreen())),
            child: Text('View Quiz List'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => quizResults.QuizResultListScreen())),
           child: Text('View Quiz Results'),
),
        ],
      ),
    );
  }
}
