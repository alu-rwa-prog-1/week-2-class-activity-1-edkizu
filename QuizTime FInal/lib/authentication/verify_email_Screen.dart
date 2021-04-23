import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiztime_app/categories.dart';
import 'authentication.dart';
import 'package:quiztime_app/screens/profile_screen.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final authenticateUser = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  // Used to set states for initialisation
  void initState() {
    // Get current user
    user = authenticateUser.currentUser;
    // Send Email to user to verify address
    user.sendEmailVerification();
    // Setting up periodic checks for whether user's email is Verified
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "A verification email has been sent to ${user.displayName}. Please Verify!"),
      ),
    );
  }

  // Function to check if an email is verified.
  Future<void> checkEmailVerified() async {
    user = authenticateUser.currentUser;
    // Refreshes user
    await user.reload();
    // If email is Verified...
    if (user.emailVerified) {
      // Move to Categories page...
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Categories()));
    }
  }
}
