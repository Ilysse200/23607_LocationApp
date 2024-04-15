import 'package:authentication_application/User/states.dart';
import 'package:authentication_application/pages/admin.dart';
import 'package:authentication_application/pages/login_or_register_page.dart';
import 'package:authentication_application/screens/AdminPage.dart';
import 'package:authentication_application/screens/quiz_list_screen.dart';
import 'package:authentication_application/screens/user_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Handling the loading state and any potential errors first
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while the connection state is waiting
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            // Optionally handle errors when the snapshot has an error
            return Center(
              child: Text('An error occurred: ${snapshot.error}', style: TextStyle(color: Colors.red)),
            );
          }

          if (!snapshot.hasData) {
          return LoginOrRegisterPage(); // Redirect to login or register page if not logged in
        }

        // Redirect based on the user role determined by UserActionTracker
        switch (UserActionTracker().lastAction) {
          case 'admin':
            return AdminDashboard(); // Admin specific dashboard
          case 'login':
            return UserDashboard(); // Normal user dashboard
          default:
            return LoginOrRegisterPage(); // Safety fallback
        }
        },
      ),
    );
  }
}
