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

  noData() {
    return Center(child: Text("You have no data"));
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> isLoggedIn = Firestore().doesUserDocumentExist(user.uid);
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: () => Auth().signOutUser(), icon: Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: isLoggedIn.asStream() ,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data == true) {
                return succes();
            } else {
                return CompleteAccountInformation();
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}