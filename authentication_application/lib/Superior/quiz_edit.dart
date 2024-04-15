import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:authentication_application/widgets/quiz.dart'; // Ensure this path is correct

class EditQuizView extends StatefulWidget {
  final String quizId;
  final Box<Quiz> quizBox;

  EditQuizView({required this.quizId, required this.quizBox});

  @override
  _EditQuizViewState createState() => _EditQuizViewState();
}

class _EditQuizViewState extends State<EditQuizView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late List<TextEditingController> _questionControllers;
  late Quiz quiz;

  @override
  void initState() {
    super.initState();
    quiz = widget.quizBox.get(widget.quizId) ?? Quiz(id: widget.quizId, title: '', questions: []);
    _titleController = TextEditingController(text: quiz.title);
    _questionControllers = quiz.questions.map((question) =>
        TextEditingController(text: question.questionText)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Quiz'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Quiz Title'),
            ),
            ..._questionControllers.asMap().entries.map((entry) {
              int idx = entry.key;
              TextEditingController ctrl = entry.value;
              return TextFormField(
                controller: ctrl,
                decoration: InputDecoration(labelText: 'Question ${idx + 1}'),
              );
            }).toList(),
            ElevatedButton(
              onPressed: () => saveChanges(),
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void saveChanges() {
  if (_formKey.currentState == null) {
    print("Form state is null");
    return;
  }

  if (_formKey.currentState!.validate()) {
    Quiz existingQuiz = widget.quizBox.get(widget.quizId) ?? Quiz(id: widget.quizId, title: '', questions: []);
    existingQuiz.title = _titleController.text;
    for (int i = 0; i < existingQuiz.questions.length; i++) {
      existingQuiz.questions[i].questionText = _questionControllers[i].text;
    }

    widget.quizBox.put(widget.quizId, existingQuiz);
    Navigator.pop(context);
  }
}
}