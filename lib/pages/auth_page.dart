import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/pages/login_register_page.dart';
import 'package:fit_buddy/pages/test.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TestPage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}