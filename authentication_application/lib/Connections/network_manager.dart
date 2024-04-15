import 'package:authentication_application/model/quiz_result.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';

class NetworkManager {
  final connectivityStream = Connectivity().onConnectivityChanged;

  void init() {
    connectivityStream.listen((status) {
      if (status != ConnectivityResult.none) {
        syncLocalDataWithServer();
      }
    });
  }

  Future<void> syncLocalDataWithServer() async {
    var box = Hive.box<QuizResult>('quizResults');
    var unsyncedResults = box.values.where((result) => result.isSynced != true).toList();

    for (var result in unsyncedResults) {
      try {
        await uploadResultToServer(result);
        result.isSynced = true;
        await box.put(result.key, result);
      } catch (e) {
        print("Failed to sync data: $e");
      }
    }
  }

  Future<void> uploadResultToServer(QuizResult result) async {
    // Here you'd implement the API call or Firebase update logic
    // For example, using a Firebase call:
    // Firestore.instance.collection('results').add(result.toMap());
    print("Data synced for result ID: ${result.key}");
  }
}
