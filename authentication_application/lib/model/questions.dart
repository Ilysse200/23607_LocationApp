import 'package:hive/hive.dart';
import 'answer_option.dart';

part 'questions.g.dart';

@HiveType(typeId: 4) // Ensure unique typeId
class Question {
  @HiveField(0)
  final String questionText;

  @HiveField(1)
  final List<AnswerOption> answers;

  Question({required this.questionText, required this.answers});
}
