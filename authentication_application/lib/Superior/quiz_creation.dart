import 'package:authentication_application/widgets/quiz.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class QuizCreationView extends StatefulWidget {
  @override
  _QuizCreationViewState createState() => _QuizCreationViewState();
}

class _QuizCreationViewState extends State<QuizCreationView> {
  final _formKey = GlobalKey<FormState>();
  List<Question> _questions = [];
  String _quizTitle = '';  // To store quiz title

  void _addQuestion() {
    setState(() {
      _questions.add(Question(questionText: '', answers: []));
    });
  }

  void _createQuiz() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newQuiz = Quiz(id: DateTime.now().toString(), title: _quizTitle, questions: _questions);
      final quizzesBox = Hive.box<Quiz>('quizzes');
      quizzesBox.add(newQuiz);
      Navigator.pop(context);  // Optionally return to the previous screen after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Quiz')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Quiz Title'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a quiz title' : null,
                onSaved: (value) => _quizTitle = value ?? '',
              ),
              ..._questions.map((question) {
                return Column(
                  children: [
                    TextFormField(
                      initialValue: question.questionText,
                      decoration: InputDecoration(labelText: 'Question'),
                      validator: (value) => value == null || value.isEmpty ? 'Please enter a question' : null,
                      onChanged: (value) => question.questionText = value,
                    ),
                    ...question.answers.asMap().entries.map((entry) {
                      int idx = entry.key;
                      AnswerOption answer = entry.value;
                      return Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: answer.text,
                              decoration: InputDecoration(labelText: 'Answer Option'),
                              validator: (value) => value == null || value.isEmpty ? 'Please enter an answer option' : null,
                              onChanged: (value) => answer.text = value,
                            ),
                          ),
                          Checkbox(
                            value: answer.score > 0,
                            onChanged: (bool? value) {
                              setState(() {
                                // Reset all scores to zero
                                question.answers.forEach((element) { element.score = 0; });
                                // Set selected answer's score to 10 or a meaningful value
                                answer.score = value == true ? 10 : 0;
                              });
                            },
                          ),
                        ],
                      );
                    }).toList(),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                question.answers.add(AnswerOption(text: '', score: 0));
                              });
                            },
                            child: Text('Add Answer Option'),
                          ),
                        ),
                        SizedBox(width: 10),
                        if (question.answers.length > 1)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  question.answers.removeLast();
                                });
                              },
                              child: Text('Remove Last Answer'),
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              }).toList(),
              ElevatedButton(
                onPressed: _addQuestion,
                child: Text('Add Question'),
              ),
              ElevatedButton(
                onPressed: _createQuiz,
                child: Text('Create Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
