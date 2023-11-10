import 'package:fit_buddy/constants/color_constants.dart';
import 'package:fit_buddy/models/user.dart';
import 'package:fit_buddy/pages/profile_feed_view.dart';
import 'package:fit_buddy/services/firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/route_constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void dispose() {
    super.dispose();
    FirestoreService.firestoreService().profileTimelineService.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = FirestoreService.firestoreService().userService.user;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon:
                            const Icon(Icons.arrow_back_ios_rounded, size: 30),
                        onPressed: () {
                          context.goNamed(FitBuddyRouterConstants.homePage);
                        },
                      ),
                      Text(
                        user.name,
                        style: TextStyle(
                            color: FitBuddyColorConstants.lOnPrimary,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                  Row(
                    children: [
                      // User profile picture in top left
                      Container(
                        width: 75.0,
                        height: 75.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                user.image), // Replace with your image URL
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_a_photo_rounded,
                          ),
                          constraints: const BoxConstraints(),
                          color: FitBuddyColorConstants.lOnPrimary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row of badges on display + button to change order.
                          Row(
                            children: [
                              const Icon(Icons.military_tech,
                                  color: Colors.amber),
                              Icon(Icons.military_tech,
                                  color: Colors.blueGrey[100]),
                              Icon(Icons.military_tech,
                                  color: Colors.orange[900]),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add,
                                      color:
                                          FitBuddyColorConstants.lOnPrimary)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.restart_alt,
                                      color:
                                          FitBuddyColorConstants.lOnPrimary)),
                            ],
                          ),
                        ],
                      ),
                      // Button that brings you back to the home page.
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      // Button to see all the User's Posts.
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(
                            'Posts',
                            style: TextStyle(
                                color: FitBuddyColorConstants.lOnPrimary,
                                fontSize: 32),
                          )),
                      // Button to only see highlighted posts.
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(
                            'Highlights',
                            style: TextStyle(
                                color: FitBuddyColorConstants.lOnPrimary,
                                fontSize: 32),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 270),
                      // Button to search user's posts
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search,
                              color: FitBuddyColorConstants.lOnPrimary)),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(child: ProfileFeedView())
          ],
        ),
      ),
    );
  }
}
