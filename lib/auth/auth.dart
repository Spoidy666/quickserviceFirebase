import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickservice/Navigation/mainPage.dart';
import 'package:quickservice/loginOrsignup/loginPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Mainpage();
            } else {
              return const Loginpage();
            }
          }),
    );
  }
}

User? getCurrentUser() {
  return FirebaseAuth.instance.currentUser;
}
