import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:authentication_application/widgets/quiz.dart';
import 'package:authentication_application/Superior/quiz_edit.dart';

class QuizManagementScreen extends StatefulWidget {
  final bool isDeleting;

  QuizManagementScreen({required this.isDeleting});

  @override
  _QuizManagementScreenState createState() => _QuizManagementScreenState();
}

class _QuizManagementScreenState extends State<QuizManagementScreen> {
  late Box<Quiz> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Quiz>('quizzes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isDeleting ? 'Delete Quizzes' : 'Edit Quizzes'),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Quiz> box, _) {
          var quizzes = box.values.toList();
          if (quizzes.isEmpty) return Center(child: Text('No quizzes available'));

          return ListView.builder(
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              Quiz quiz = quizzes[index];
              return ListTile(
                title: Text(quiz.title),
                trailing: IconButton(
                  icon: Icon(widget.isDeleting ? Icons.delete : Icons.edit),
                  onPressed: () => widget.isDeleting
                      ? _showDeleteDialog(context, quiz)
                      : _editQuiz(context, quiz),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Quiz quiz) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this quiz titled "${quiz.title}"?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                box.delete(quiz.id); // Delete by ID
                Navigator.of(context).pop();
                setState(() {}); // Ensure the list updates after deletion
              },
            ),
          ],
        );
      },
    );
  }

  void _editQuiz(BuildContext context, Quiz quiz) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditQuizView(
          quizId: quiz.id,
          quizBox: box,
        ),
      ),
    );
  }
}
