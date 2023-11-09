import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_buddy/constants/color_constants.dart';
import 'package:fit_buddy/constants/route_constants.dart';
import 'package:fit_buddy/models/user.dart';
import 'package:fit_buddy/services/firestore/firestore_service.dart';
import 'package:fit_buddy/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/auth.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = FirestoreService.firestoreService().userService.user;
    Future<String?> openDialog() => showDialog<String?>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Your Input'),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: 'Enter your input'),
              controller: controller,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(controller.text);
                  },
                  child: const Text('SUBMIT'))
            ],
          ),
        );

    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () =>
                      context.goNamed(FitBuddyRouterConstants.settingsPage),
                  icon: Icon(Icons.arrow_back,
                      color: FitBuddyColorConstants.lOnPrimary)),
            ],
          ),
          Center(
            child: Text('Account Settings',
                style: TextStyle(
                    color: FitBuddyColorConstants.lOnPrimary, fontSize: 25)),
          ),
          const SizedBox(height: 35),
          Row(children: [
            ElevatedButton(
                onPressed: () async {
                  final name = await openDialog();
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(Auth().currentUser?.uid)
                      .update({'displayName': name});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Row(
                  children: [
                    Text('Display Name',
                        style: TextStyle(
                            color: FitBuddyColorConstants.lOnPrimary,
                            fontSize: 18)),
                    SizedBox(width: 20),
                    Text(user.name,
                        style: TextStyle(
                            color: FitBuddyColorConstants.lOnSecondary,
                            fontSize: 18)),
                  ],
                ))
          ]),
          Divider(thickness: 2, color: FitBuddyColorConstants.lAccent),
          Row(children: [
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Row(
                  children: [
                    Text('Date of Birth',
                        style: TextStyle(
                            color: FitBuddyColorConstants.lOnPrimary,
                            fontSize: 18)),
                    SizedBox(width: 20),
                    Text(user.age,
                        style: TextStyle(
                            color: FitBuddyColorConstants.lOnSecondary,
                            fontSize: 18)),
                  ],
                ))
          ]),
          Divider(thickness: 2, color: FitBuddyColorConstants.lAccent),
          Row(children: [
            ElevatedButton(
                onPressed: () async {
                  final username = await openDialog();
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(Auth().currentUser?.uid)
                      .update({'username': username});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Row(
                  children: [
                    Text('Username',
                        style: TextStyle(
                            color: FitBuddyColorConstants.lOnPrimary,
                            fontSize: 18)),
                    SizedBox(width: 20),
                    Text(user.username,
                        style: TextStyle(
                            color: FitBuddyColorConstants.lOnSecondary,
                            fontSize: 18)),
                  ],
                ))
          ]),
        ],
      ),
    )));
  }
}
