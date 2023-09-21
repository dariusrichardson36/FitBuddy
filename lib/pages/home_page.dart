import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/pages/complete_account_page.dart';
import 'package:fit_buddy/services/auth.dart';
import 'package:flutter/material.dart';
import '../services/firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  succes() {
    return Center(child: Text("Logged In ${user.email!}"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: () => Auth().signOutUser(), icon: Icon(Icons.logout))
        ],
      ),
      body: Center(child: Text("Logged In ${user.email!}"))
    );
  }
}