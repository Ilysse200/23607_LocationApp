import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'quiz.g.dart';

@HiveType(typeId: 0)
class Quiz {
  @HiveField(0)
  String id;
  @HiveField(1)
   String title;
  @HiveField(2)
  List<Question> questions;

  Quiz({required this.id, required this.title, required this.questions});
}

@HiveType(typeId: 1)
class Question {
  @HiveField(0)
  String questionText;
  @HiveField(1)
  final List<AnswerOption> answers;

  Question({required this.questionText, required this.answers});
}

@HiveType(typeId: 2)
class AnswerOption {
  @HiveField(0)
  String text;
  @HiveField(1)
  int score;

  AnswerOption({required this.text, required this.score});
}

// Defining a thorough list of quizzes
final List<Quiz> exampleQuizzes = [
  Quiz(
    id: 'q1',
    title: 'General Knowledge',
    questions: [
      Question(
        questionText: 'What is the capital of France?',
        answers: [
          AnswerOption(text: 'Paris', score: 10),
          AnswerOption(text: 'London', score: 0),
          AnswerOption(text: 'Berlin', score: 0),
          AnswerOption(text: 'Madrid', score: 0),
        ],
      ),
      Question(
        questionText: 'Who painted the Mona Lisa?',
        answers: [
          AnswerOption(text: 'Vincent Van Gogh', score: 0),
          AnswerOption(text: 'Leonardo da Vinci', score: 10),
          AnswerOption(text: 'Pablo Picasso', score: 0),
          AnswerOption(text: 'Claude Monet', score: 0),
        ],
      ),
    ],
  ),
  Quiz(
    id: 'q2',
    title: 'Science and Nature',
    questions: [
      Question(
        questionText: 'What is the chemical symbol for Gold?',
        answers: [
          AnswerOption(text: 'Au', score: 10),
          AnswerOption(text: 'Ag', score: 0),
          AnswerOption(text: 'Pb', score: 0),
          AnswerOption(text: 'Fe', score: 0),
        ],
      ),
      Question(
        questionText: 'How many planets are in the Solar System?',
        answers: [
          AnswerOption(text: 'Eight', score: 10),
          AnswerOption(text: 'Nine', score: 0),
          AnswerOption(text: 'Seven', score: 0),
          AnswerOption(text: 'Ten', score: 0),
        ],
      ),
    ],
  ),
  Quiz(
    id: 'q3',
    title: 'History',
    questions: [
      Question(
        questionText: 'Who was the first President of the United States?',
        answers: [
          AnswerOption(text: 'George Washington', score: 10),
          AnswerOption(text: 'Thomas Jefferson', score: 0),
          AnswerOption(text: 'Abraham Lincoln', score: 0),
          AnswerOption(text: 'John Adams', score: 0),
        ],
      ),
      Question(
        questionText: 'Which empire built the Great Wall of China?',
        answers: [
          AnswerOption(text: 'Ming Dynasty', score: 10),
          AnswerOption(text: 'Qing Dynasty', score: 0),
          AnswerOption(text: 'Han Dynasty', score: 0),
          AnswerOption(text: 'Tang Dynasty', score: 0),
        ],
      ),
      Question(
        questionText: 'Who was the first female Prime Minister of the United Kingdom?',
        answers: [
          AnswerOption(text: 'Margaret Thatcher', score: 10),
          AnswerOption(text: 'Theresa May', score: 0),
          AnswerOption(text: 'Angela Merkel', score: 0),
          AnswerOption(text: 'Jacinda Ardern', score: 0),
        ],
      ),
       Question(
        questionText: 'Which scientist is known for his theory of relativity?',
        answers: [
          AnswerOption(text: 'Albert Einstein', score: 10),
          AnswerOption(text: 'Isaac Newton', score: 0),
          AnswerOption(text: 'Stephen Hawking', score: 0),
          AnswerOption(text: 'Nikola Tesla', score: 0),
        ],
      ),
    ],
  ),
  Quiz(
    id: 'q4',
    title: 'Technology',
    questions: [
      Question(
        questionText: 'What does HTML stand for?',
        answers: [
          AnswerOption(text: 'Hyper Trainer Marking Language', score: 0),
          AnswerOption(text: 'Hyper Text Markup Language', score: 10),
          AnswerOption(text: 'Hyper Texts Mark Language', score: 0),
          AnswerOption(text: 'Hyperlinking Text Markup Language', score: 0),
        ],
      ),
      Question(
        questionText: 'Who is known as the father of the computer?',
        answers: [
          AnswerOption(text: 'Alan Turing', score: 0),
          AnswerOption(text: 'Charles Babbage', score: 10),
          AnswerOption(text: 'Steve Jobs', score: 0),
          AnswerOption(text: 'Bill Gates', score: 0),
        ],
      ),
    ],
  ),
];
