import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_buddy/constants/color_constants.dart';
import 'package:fit_buddy/models/user.dart';
import 'package:fit_buddy/pages/profile_feed_view.dart';
import 'package:fit_buddy/services/firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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

  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    User user = FirestoreService.firestoreService().userService.user;
    int _currentPage = 0;

    Future<void> pickImage() async {
      final picker = ImagePicker();
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      // Upload to Firebase Storage.
      if (image != null) {
        final storageRef = FirebaseStorage.instance.ref();
        final picRef = storageRef.child("profile_pictures/1");

        try {
          //Store the file
          await picRef.putFile(File(image!.path));
          var imageUrl = await picRef.getDownloadURL();
          print(imageUrl);
        } catch (error) {
          //Some error occurred
        }
      } else {
        // Handle the case where the user didn't pick an image.
        print('No image selected');
      }
    }

    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            SizedBox(
              height: 350,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    print(index);
                    _currentPage = index;
                    print(_currentPage);
                  });
                },
                itemCount: user.images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTapUp: (TapUpDetails details) {
                      // Get the width of the widget
                      var width = MediaQuery.of(context).size.width;
                      // Check where the user tapped
                      if (details.globalPosition.dx < width / 2) {
                        // If the user tapped on the left side, go to the previous image
                        if (_controller.page != 0) {
                          _controller.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                        }
                      } else {
                        // If the user tapped on the right side, go to the next image
                        if (_controller.page != user.images.length - 1) {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.decelerate,
                          );
                        }
                      }
                    },
                    child: Image.network(user.images[index], fit: BoxFit.cover),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 40, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // This centers the indicators horizontally
                    children: List.generate(user.images.length, (index) {
                      return Expanded(
                        child: Container(
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                            color: _currentPage.round() == index
                                ? FitBuddyColorConstants
                                    .lOnPrimary // Active indicator color
                                : FitBuddyColorConstants
                                    .lSecondary, // Inactive indicator color
                          ),
                        ),
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon:
                            const Icon(Icons.arrow_back_ios_rounded, size: 30),
                        onPressed: () {
                          context.goNamed(FitBuddyRouterConstants.homePage);
                        },
                      ),
                      //    const SizedBox(width: 30),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          "@${user.username}",
                          style: TextStyle(
                              color: FitBuddyColorConstants.lOnPrimary,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 215),
                  Text(
                    user.name,
                    style: TextStyle(
                        color: FitBuddyColorConstants.lPrimary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ]),
          const SizedBox(height: 20),
          const Expanded(child: ProfileFeedView())
        ],
      ),
    );
  }
}
