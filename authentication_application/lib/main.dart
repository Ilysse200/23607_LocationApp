import 'package:authentication_application/Connections/network_manager.dart';
import 'package:authentication_application/User/session.dart';
import 'package:authentication_application/model/quiz_result.dart';
import 'package:authentication_application/pages/auth_page.dart';
import 'package:authentication_application/pages/login_or_register_page.dart';
import 'package:authentication_application/pages/register_page.dart';
import 'package:authentication_application/widgets/quiz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 

    // Sign out any existing user for testing purposes.
  
  );
  await FirebaseAuth.instance.signOut();
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive and get the application documents directory.
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  
  // Register all necessary adapters including Quiz, Question, and AnswerOption.
  Hive.registerAdapter(QuizAdapter());
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(AnswerOptionAdapter());
  Hive.registerAdapter(QuizResultAdapter());

  // Open the 'quizzes' box.
  await Hive.openBox<Quiz>('quizzes');

   await Hive.openBox<QuizResult>('quizResults');

   await Hive.openBox('quizProgress'); // Open the quizProgress box
  
  // Load quizzes into the box if it's empty.
  await addQuizzesIfNeeded();
  runApp(const MyApp());

  NetworkManager().init(); //Initialize network manager after app is running

  firebaseCloudMessagingListeners(); // Initialize Firebase Cloud Messaging
}

FirebaseMessaging messaging = FirebaseMessaging.instance;

void firebaseCloudMessagingListeners() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}

Future<void> addQuizzesIfNeeded() async {
  final Box<Quiz> quizBox = Hive.box<Quiz>('quizzes');

  //await quizBox.clear();
  if (quizBox.isEmpty) {
    // Assuming 'exampleQuizzes' is defined within your 'quiz.dart' and accessible here
    for (Quiz quiz in exampleQuizzes) {
      await quizBox.add(quiz);
    }
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SessionManager(
      child: AuthPage(),
    ),
    );
  }
}