import 'package:fit_buddy/constants/color_constants.dart';
import 'package:fit_buddy/constants/route_constants.dart';
import 'package:fit_buddy/models/user.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:fit_buddy/theme/theme_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/auth.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  Widget ui(BuildContext context, User user) {
    String? name;
    String? image;

    // sets name variable and gives default value if NULL.
    if (user.name != null) {
      name = user.name;
    } else {
      name = "Name Unknown";
    }

    // sets image variable and gives default value if NULL.
    if (user.image != null) {
      image = user.image;
    } else {
      image = "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg";
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Container(
              width: 75.0,
              height: 75.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(image!), // Replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name!,
                  style: TextStyle(
                      color: FitBuddyColorConstants.lOnPrimary,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 35),
                Text(
                  '215 Friends',
                  style: TextStyle(
                    color: FitBuddyColorConstants.lOnSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 50),
        Row(
          children: [
            Icon(Icons.person,
                color: FitBuddyColorConstants.lOnPrimary, size: 35),
            SizedBox(width: 15),
            ElevatedButton(
                onPressed: () {
                  context.goNamed(FitBuddyRouterConstants.profilePage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  'Profile',
                  style: TextStyle(
                      color: FitBuddyColorConstants.lOnPrimary, fontSize: 18),
                )),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Icon(Icons.settings,
                color: FitBuddyColorConstants.lOnPrimary, size: 35),
            SizedBox(width: 15),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  'Settings',
                  style: TextStyle(
                      color: FitBuddyColorConstants.lOnPrimary, fontSize: 18),
                )),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Icon(Icons.edit,
                color: FitBuddyColorConstants.lOnPrimary, size: 35),
            SizedBox(width: 15),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  'Log Workout',
                  style: TextStyle(
                      color: FitBuddyColorConstants.lOnPrimary, fontSize: 18),
                )),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Icon(Icons.search, color: Colors.black, size: 35),
            SizedBox(width: 15),
            ElevatedButton(
                onPressed: () {
                  context.goNamed(FitBuddyRouterConstants.searchPage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                )),
          ],
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () => Auth().signOutUser(),
                icon: Icon(Icons.logout_rounded)),
            IconButton(
                onPressed: () => ThemeManager().toggleTheme(),
                icon: Icon(Icons.sunny))
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<User> test = FireStore.FireStore().getUserData();
    
    return SafeArea(
        child: FutureBuilder(
            future: test,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                User? user = snapshot.data;
                if (user != null) {
                  return ui(context, user);
                }
                return Text('User not Found');
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
