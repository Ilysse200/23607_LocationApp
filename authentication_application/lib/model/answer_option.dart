import 'package:hive/hive.dart';

part 'answer_option.g.dart';

@HiveType(typeId: 5) // Ensure unique typeId
class AnswerOption {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final int score;

  AnswerOption({required this.text, required this.score});
}
