import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SessionManager extends StatefulWidget {
  final Widget child;

  SessionManager({required this.child});

  @override
  _SessionManagerState createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(minutes: 30), () {  // Adjust the timeout duration as necessary
      if (FirebaseAuth.instance.currentUser != null) {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _resetTimer,
      behavior: HitTestBehavior.opaque,
      child: widget.child,
    );
  }

  void _resetTimer() {
    _startTimer();  // Reset the timer on any user interaction
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
