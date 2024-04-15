import 'package:hive/hive.dart';

class QuizProgress {
  void saveProgress(String quizId, Map<String, dynamic> progress) {
    var box = Hive.box('quizProgress');
    box.put(quizId, progress);
  }

  Map<String, dynamic>? loadProgress(String quizId) {
    var box = Hive.box('quizProgress');
    return box.get(quizId);
  }
}
