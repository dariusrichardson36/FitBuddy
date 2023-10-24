//import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/components/FitBuddyProfileUI.dart';
import 'package:fit_buddy/constants/color_constants.dart';
import 'package:fit_buddy/constants/route_constants.dart';
import 'package:fit_buddy/models/user.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<User> test = FireStore.FireStore().getUserData();

    return FutureBuilder(
        future: test,
        builder: (context, snapshot) {
          User? user = snapshot.data;
          if (user != null) {
            return FitBuddyProfileUI(userData: user);
          }
          return Text('User not Found');
        });
  }
}
