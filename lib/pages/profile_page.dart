import 'package:fit_buddy/components/fit_buddy_users_posts_view.dart';
import 'package:fit_buddy/constants/color_constants.dart';
import 'package:fit_buddy/constants/route_constants.dart';
import 'package:fit_buddy/models/user.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget ui(BuildContext context, User userData) {
    String? name;
    String? image;

    // sets name variable and gives default value if NULL.
    if (userData.name != null) {
      name = userData.name;
    } else {
      name = "Name Unknown";
    }

    // sets image variable and gives default value if NULL.
    if (userData.image != null) {
      image = userData.image;
    } else {
      image = "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg";
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // User profile picture in top left
                  Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:
                            NetworkImage(image!), // Replace with your image URL
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(width: 10),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      // Users display name.
                      Text(
                        name!,
                        style: TextStyle(
                            color: FitBuddyColorConstants.lOnPrimary,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      // Row of badges on display + button to change order.
                      Row(
                        children: [
                          Icon(Icons.military_tech, color: Colors.amber),
                          Icon(Icons.military_tech,
                              color: Colors.blueGrey[100]),
                          Icon(Icons.military_tech, color: Colors.orange[900]),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add,
                                  color: FitBuddyColorConstants.lOnPrimary)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.restart_alt,
                                  color: FitBuddyColorConstants.lOnPrimary)),
                        ],
                      ),
                    ],
                  ),
                  // Button that brings you back to the home page.
                  Column(
                    children: [
                      IconButton(
                          onPressed: () =>
                              context.goNamed(FitBuddyRouterConstants.homePage),
                          icon: Icon(Icons.arrow_forward,
                              color: FitBuddyColorConstants.lOnPrimary)),
                      SizedBox(height: 45)
                    ],
                  )
                ],
              ),
              SizedBox(height: 25),
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
              UserPostsView()
            ],
          ),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    Future<User> test = FireStore.FireStore().getUserData();

    return FutureBuilder(
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
        });
  }
}
