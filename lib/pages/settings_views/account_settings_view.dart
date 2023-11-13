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
    String? experience;
    String? email;
    String? gender;
    String? liftingStyle;
    String? goals;

    if (user.gymExperience != null) experience = user.gymExperience;

    if (user.email != null) email = user.email;
    else email = "null";

    if (user.gender != null) gender = user.gender;
    else gender = "null";

    if (user.liftingStyle != null) liftingStyle = user.liftingStyle;

    if (user.gymGoals!= null) goals = user.gymGoals;

    // Dialog popup that alows the user to enter in a text box.
    Future<String?> openDialog(String title, String hinttext) => showDialog<String?>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(hintText: hinttext),
          controller: controller,
        ),
        
        actions: [
          TextButton(
            onPressed: () { Navigator.of(context).pop(controller.text); },
            child: const Text('SUBMIT')
          )
        ],
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
          child: Column(
            children: [
              // Back button that takes the user to the settings home page.
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.goNamed(FitBuddyRouterConstants.settingsPage),
                    icon: Icon(Icons.arrow_back,
                      color: FitBuddyColorConstants.lOnPrimary
                    )
                  ),
                ],
              ),

              // Page Title
              Center(
                child: Text(
                  'Account Settings',
                  style: TextStyle (
                    color: FitBuddyColorConstants.lOnPrimary, fontSize: 25
                  )
                ),
              ),

              const SizedBox(height: 35),

              // Displays current Display Name and allows the user to change it.
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final name = await openDialog("Change Display Name", "Enter your new Display Name");
                      FirebaseFirestore.instance
                        .collection('users')
                        .doc(Auth().currentUser?.uid)
                        .update({'displayName': name});
                    },
                    icon: Icon(
                      Icons.restart_alt,
                      color: FitBuddyColorConstants.lOnPrimary
                    )
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Display Name',
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnPrimary,
                            fontSize: 18
                          )
                        ),

                        Text(
                          user.name,
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnSecondary,
                            fontSize: 14
                          )
                        ),
                      ],
                    ),
                  )
                ]
              ),

              Divider(thickness: 2, color: FitBuddyColorConstants.lAccent),

              // Displays current Username and allows the user to change it.
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final username = await openDialog("Change Username", "Enter your new Username");
                      FirebaseFirestore.instance
                        .collection('users')
                        .doc(Auth().currentUser?.uid)
                        .update({'username': username});
                    },
                    icon: Icon(
                      Icons.restart_alt,
                      color: FitBuddyColorConstants.lOnPrimary
                    )
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnPrimary,
                            fontSize: 18
                          )
                         ),

                        Text(
                          user.username,
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnSecondary,
                            fontSize: 14
                          )
                        ),
                      ],
                    ),
                  )
                ]     
              ),

              Divider(thickness: 2, color: FitBuddyColorConstants.lAccent),

              // Displays current Email and allows the user to change it.
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final email = await openDialog("Change Email", "Enter your new Email");
                      FirebaseFirestore.instance
                        .collection('users')
                        .doc(Auth().currentUser?.uid)
                        .set({'email': email},SetOptions(merge: true));
                    },
                    icon: Icon(
                      Icons.restart_alt,
                      color: FitBuddyColorConstants.lOnPrimary
                    )
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnPrimary,
                            fontSize: 18
                          )
                        ),

                        Text(
                          email!,
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnSecondary,
                            fontSize: 14
                          )
                        ),
                      ],
                    ),
                  )
                ]
              ),

              Divider(thickness: 2, color: FitBuddyColorConstants.lAccent),

              // Displays current Gender and allows the user to change it.
              Row(  
                children: [
                  IconButton(
                    onPressed: () async {
                      final gender = await openDialog("Change Gender", "Enter your new Gender");
                      FirebaseFirestore.instance
                        .collection('users')
                        .doc(Auth().currentUser?.uid)
                        .set({'gender': gender},SetOptions(merge: true));
                    },
                    icon: Icon(
                      Icons.restart_alt,
                      color: FitBuddyColorConstants.lOnPrimary
                    )
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gender',
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnPrimary,
                            fontSize: 18
                          )
                        ),

                        Text(
                          gender!,
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnSecondary,
                            fontSize: 14
                          )
                        ),
                      ],
                    ),
                  )
                ]
              ),

              Divider(thickness: 2, color: FitBuddyColorConstants.lAccent),

              // Displays current Date of Birth and allows the user to change it.
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.restart_alt,
                      color: FitBuddyColorConstants.lOnPrimary
                    )
                  ),
            
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date of Birth',
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnPrimary,
                            fontSize: 18
                          )
                        ),

                        Text(
                          user.age,
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnSecondary,
                            fontSize: 14
                          )
                        ),
                      ],
                    ),
                  )
                ]
              ),

              Divider(thickness: 2, color: FitBuddyColorConstants.lAccent),

              // Displays current Lifting Style and allows the user to change it.
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.restart_alt,
                      color: FitBuddyColorConstants.lOnPrimary
                    )
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lifting Style',
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnPrimary,
                            fontSize: 18
                          )
                        ),

                        Text(
                          liftingStyle!,
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnSecondary,
                            fontSize: 14
                          )
                        ),
                      ],
                    ),
                  )
                ]
              ),

              Divider(thickness: 2, color: FitBuddyColorConstants.lAccent),

              // Displays current Gym Goals and allows the user to change it.
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.restart_alt,
                      color: FitBuddyColorConstants.lOnPrimary
                    )
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gym Goals',
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnPrimary,
                            fontSize: 18
                          )
                        ),

                        Text(
                          goals!,
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnSecondary,
                            fontSize: 14
                          )
                        ),
                      ],
                    ),
                  )
                ]
              ),

              Divider(thickness: 2, color: FitBuddyColorConstants.lAccent),

              // Displays current Gym Experience and allows the user to change it.
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.restart_alt,
                      color: FitBuddyColorConstants.lOnPrimary
                    )
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gym Experience',
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnPrimary,
                            fontSize: 18
                          )
                        ),

                        Text(
                          experience!,
                          style: TextStyle(
                            color: FitBuddyColorConstants.lOnSecondary,
                            fontSize: 14
                          )
                        ),
                      ],
                    ),
                  )
                ]
              ),
            ],
          ),
        )
      )
    );
  }
}