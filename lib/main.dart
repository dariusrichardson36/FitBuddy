import 'package:fit_buddy/pages/auth_page.dart';
import 'package:fit_buddy/pages/home_page.dart';
import 'package:fit_buddy/services/auth.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder(
          stream: Auth().authStateChanges,
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return HomePage();
              }
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return 
                Scaffold(
                  body: Center(
                  child: CircularProgressIndicator(),
              ),
                );
            }
            return AuthPage();
          },
        ),
      ),
    );
  }
// This widget is the root of your application.
}