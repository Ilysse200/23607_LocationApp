import 'package:hive/hive.dart';

part 'quiz_result.g.dart'; // This file will be generated

@HiveType(typeId: 3) // Ensure typeId is unique
class QuizResult extends HiveObject{
  @HiveField(0)
  final String quizId;

  @HiveField(1)
  final int score;

  @HiveField(2)
  final DateTime completedAt;

  @HiveField(3) // New field for sync status
  bool? isSynced; // Make it nullable and handle null safely in adapter.

  QuizResult({
    required this.quizId,
    required this.score,
    required this.completedAt,
    this.isSynced , // Initialize in constructor, default is false
  });
}
