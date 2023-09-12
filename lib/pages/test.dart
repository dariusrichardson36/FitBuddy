

import 'package:fit_buddy/auth.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () => Auth().signOutUser(), icon: Icon(Icons.logout))
      ],),
      body: Center(
        child: Text("Logged In"),
      ),
    );
  }

}