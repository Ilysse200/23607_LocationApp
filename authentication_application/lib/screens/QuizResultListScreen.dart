import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Ensure this is imported
import 'package:authentication_application/model/quiz_result.dart';

class QuizResultListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
      ),
      body: ValueListenableBuilder(
        // Listen to the changes in the quizResults box
        valueListenable: Hive.box<QuizResult>('quizResults').listenable(),
        builder: (context, Box<QuizResult> box, _) {
          // Fetch all results stored in the box
          final results = box.values.toList();

          // If no results available, display a message
          if (results.isEmpty) {
            return Center(
              child: Text("No quiz results available."),
            );
          }

          // If results exist, build a list view of all results
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return ListTile(
                title: Text('Quiz ID: ${result.quizId}'),
                subtitle: Text('Score: ${result.score}, Completed At: ${result.completedAt}'),
              );
            },
          );
        },
      ),
    );
  }
}
