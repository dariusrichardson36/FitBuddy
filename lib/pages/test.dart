

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/services/auth.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  TestPage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () => Auth().signOutUser(), icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text("Logged In ${user.email!}"),
      ),
    );
  }
}