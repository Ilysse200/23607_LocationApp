import 'package:authentication_application/User/notification_app.dart';
import 'package:authentication_application/screens/QuizResultListScreen.dart';
import 'package:authentication_application/screens/current_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:authentication_application/screens/quiz_list_screen.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('All Quizzes', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizListScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Quiz History', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizResultListScreen()),
                );
              },
            ),
            ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Google Maps'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CurrentLocationScreen()));
                  },
                ),
              ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationFunctionality()));
                  },
             ),
          ],
        ),
      ),
      body: Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Use MainAxisSize.min for best effect in centering
          children: <Widget>[
            Icon(Icons.dashboard, size: 100, color: Colors.white), // Example icon
            Text(
              'Welcome to the User Dashboard!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
