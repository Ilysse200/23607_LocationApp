import 'package:authentication_application/Superior/quiz_selection.dart';
import 'package:flutter/material.dart';

import 'package:authentication_application/Superior/quiz_creation.dart';

// Admin Dashboard Screen
class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuizCreationView())),
            child: Text('Create Quiz'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuizManagementScreen(isDeleting: false))),
            child: Text('Edit Quiz'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuizManagementScreen(isDeleting: true))),
            child: Text('Delete Quiz'),
          ),
        ],
      ),
    );
  }
}
