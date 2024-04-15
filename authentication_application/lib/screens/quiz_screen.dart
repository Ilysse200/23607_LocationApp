import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:authentication_application/widgets/answer.dart';
import 'package:authentication_application/widgets/question.dart' as qst;
import 'package:authentication_application/widgets/quiz.dart';
import 'package:authentication_application/widgets/result.dart';
import 'package:authentication_application/model/quiz_result.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;
  final bool resume;
  final Map<String, dynamic>? initialProgress;

  QuizScreen({Key? key, required this.quiz, this.resume = false, this.initialProgress}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late int _questionIndex;
  late int _totalScore;

  @override
  void initState() {
    super.initState();
    if (widget.resume && widget.initialProgress != null) {
      _questionIndex = widget.initialProgress!['questionIndex'] ?? 0;
      _totalScore = widget.initialProgress!['totalScore'] ?? 0;
    } else {
      _questionIndex = 0;
      _totalScore = 0;
    }
  }

  void _resetQuiz() {
    Navigator.of(context).pop();
  }

  void _answerQuestion(int score) {
    if (_questionIndex < widget.quiz.questions.length - 1) {
      setState(() {
        _totalScore += score;
        _questionIndex++;
        // Save progress here
        Hive.box('quizProgress').put(widget.quiz.id, {'questionIndex': _questionIndex, 'totalScore': _totalScore});
      });
    } else {
      setState(() {
        _totalScore += score;
      });
      _saveQuizResult();
    }
  }

  Future<void> _saveQuizResult() async {
    final Box<QuizResult> resultsBox = await Hive.openBox<QuizResult>('quizResults');
    final quizResult = QuizResult(
      quizId: widget.quiz.id,
      score: _totalScore,
      completedAt: DateTime.now(),
    );
    await resultsBox.add(quizResult);
    Hive.box('quizProgress').delete(widget.quiz.id); // Clear progress after completing the quiz
    if (mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Result(resultScore: _totalScore, resetHandler: _resetQuiz)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
      ),
      body: _questionIndex < widget.quiz.questions.length
          ? Column(
              children: [
                qst.QuestionWidget(widget.quiz.questions[_questionIndex].questionText),
                ...(widget.quiz.questions[_questionIndex].answers.map((answer) {
                  return Answer(
                    () => _answerQuestion(answer.score),
                    answer.text,
                  );
                }).toList()),
              ],
            )
          : Container(),
    );
  }
}
