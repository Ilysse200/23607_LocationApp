import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:authentication_application/widgets/quiz.dart';
import 'package:authentication_application/screens/quiz_screen.dart';

class QuizListScreen extends StatelessWidget {
  QuizListScreen({Key? key}) : super(key: key);

  Future<bool> _showResumeDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Resume Quiz?'),
        content: Text('Do you want to resume the quiz from where you left off?'),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
        ],
      ),
    ) ?? false; // Handle null (when dialog is dismissed)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select a Quiz')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Quiz>('quizzes').listenable(),
        builder: (context, Box<Quiz> box, _) {
          final quizzes = box.values.toList();

          if (quizzes.isEmpty) {
            return Center(child: Text('No quizzes available'));
          }

          return ListView.builder(
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              final quiz = quizzes[index];
              return ListTile(
                title: Text(quiz.title),
                onTap: () async {
                  // Safely check if the quizProgress box exists
                  Box? progressBox;
                  try {
                    progressBox = Hive.box('quizProgress');
                  } catch (e) {
                    // Handle the error or initialize the box here if not found
                    progressBox = await Hive.openBox('quizProgress');
                  }
                  var progress = progressBox.get(quiz.id);
                  bool resume = progress != null ? await _showResumeDialog(context) : false;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(quiz: quiz, resume: resume, initialProgress: progress),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
