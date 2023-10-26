import 'package:fit_buddy/components/FitBuddyProfileUI.dart';
import 'package:fit_buddy/models/user.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<User> test = FireStore.FireStore().getUserData();

    return FutureBuilder(
        future: test,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            User? user = snapshot.data;
            if (user != null) {
              return FitBuddyProfileUI(userData: user);
            }
            return Text('User not Found');
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
