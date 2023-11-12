import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/user.dart';
import 'package:intl/intl.dart';

import '../../services/auth.dart';

// Constructs list of user information from user class
Future<List<User>> getUsersFromFirestore() async {
  final collection = FirebaseFirestore.instance.collection('users');
  final snapshot = await collection.get();
  return snapshot.docs.map((doc) => User.fromDataSnapshot(doc)).toList();
}

String? getCurrentUserUID() {
  FirebaseAuth auth = FirebaseAuth.instance;

  User? user = auth.currentUser as User?;

  if (user != null) {
    String? uid = user?.uid;
    print('Current User UID: $uid');
  } else {
    print('No user is currently signed in.');
  }
}


class MatchmakingView extends StatelessWidget {

  const MatchmakingView({Key? key}) : super(key: key);


  // Here is my like function
  Future<void> likeProfile(String likerID, String likedID) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('users').doc(likerID);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final userSnapshot = await transaction.get(userRef);

        if (userSnapshot.exists) {
          final userData = userSnapshot.data();
          final likes = List<String>.from(userData?['likes'] ?? []);

          if (!likes.contains(likedID)) {
            likes.add(likedID);
            transaction.update(userRef, {'likes': likes});
            print('Like added to Firestore!');
          } else {
            print('User already liked this profile!');
          }
        }
      });
    } catch (error) {
      print('Error adding like: $error');
    }
  }


  // Here is my matching function
  Future<void> likeUser(String likerID, String likedID) async {
    try {
      var likerRef = FirebaseFirestore.instance.collection('users').doc(likerID);
      var likedRef = FirebaseFirestore.instance.collection('users').doc(likedID);

      var likerSnapshot = await likerRef.get();
      var likedSnapshot = await likedRef.get();

      if (likerSnapshot.exists && likedSnapshot.exists) {
        var likerData = likerSnapshot.data();
        var likedData = likedSnapshot.data();

        var likerAlreadyLiked =
            likerData?['Likes'] != null && likerData?['Likes'].contains(likedID);
        var likedAlreadyLiked =
            likedData?['Likes'] != null && likedData?['Likes'].contains(likerID);

        if (likerAlreadyLiked && likedAlreadyLiked) {
          var likerMatchData = {'userId': likedID};
          var likedMatchData = {'userId': likerID};

          await FirebaseFirestore.instance.runTransaction((transaction) async {
            var likerMatchesDoc = await transaction.get(likerRef);
            var likedMatchesDoc = await transaction.get(likedRef);

            var likerMatchesArray = (likerMatchesDoc.data()?['Matches'] as List<Map<String, dynamic>>?) ?? [];
            likerMatchesArray.add(likerMatchData);
            transaction.update(likerRef, {'Matches': likerMatchesArray});

            var likedMatchesArray = (likedMatchesDoc.data()?['Matches'] as List<Map<String, dynamic>>?) ?? [];
            likedMatchesArray.add(likedMatchData);
            transaction.update(likedRef, {'Matches': likedMatchesArray});

            print('Match found and updated in Firestore!');
          });
        } else {
          print('No mutual like yet.');
        }
      } else {
        print('One or both users not found.');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  static const String placeholderImageUrl = 'https://www.seekpng.com/png/detail/847-8474751_download-empty-profile.png';

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<User>>(
      future: getUsersFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No users found.');
        }

        final users = snapshot.data;
        //final age = dob != null ? calculateAgeFromDOB(dob) : 0;

        final group1Users = users?.where((user) =>
            isUserInGroup(user, 'A', 'F')).toList();
        final group2Users = users?.where((user) =>
            isUserInGroup(user, 'G', 'M')).toList();
        final group3Users = users?.where((user) =>
            isUserInGroup(user, 'N', 'S')).toList();
        final group4Users = users?.where((user) =>
            isUserInGroup(user, 'T', 'Z')).toList();



        // Here is my swiper
        return AppinioSwiper(

          cardsCount: group2Users?.length ?? 0,

          // Tracks direction that the card is swiped in
          onSwiping: (AppinioSwiperDirection direction) {
            if (direction == AppinioSwiperDirection.bottom) {
              print('Liked');
            }
          },
          cardsBuilder: (BuildContext context, int index) {
            final user = group2Users?[index];
            final imageUrl = user?.image_url ?? placeholderImageUrl;

            // Tracks the current user id being displayed on screen
            final docID = group2Users?[index].uid ?? 'None'; // Assuming `userId` is the document ID field
            print(docID);

            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              color: Colors.blueGrey[100],
              child: Column(
                children: [
                  // Profile picture aligned with the top of the card and taking half of the height
                  Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.45, // Set 40% of the screen height
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fitWidth, // Take up 90% of the screen width
                      width: MediaQuery
                          .of(context)
                          .size
                          .width, // Set 90% of the screen width
                    ),
                  ),

                  // Text widget with size 24 font aligned to the left
                  SizedBox(
                      height: 10
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    // Add padding to both sides of the row
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // Distribute children to both ends of the row
                      children: [
                        Text(
                          user?.displayName ?? 'No Name',
                          style: GoogleFonts.roboto(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '20',
                          style: GoogleFonts.roboto(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),


                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6.0),
                        child: SizedBox(
                          height: 40,
                          child: Image.asset('lib/images/emptyBadge.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6.0),
                        child: SizedBox(
                          height: 40,
                          child: Image.asset('lib/images/emptyBadge.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6.0),
                        child: SizedBox(
                          height: 40,
                          child: Image.asset('lib/images/emptyBadge.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6.0),
                        child: SizedBox(
                          height: 40,
                          child: Image.asset('lib/images/emptyBadge.png'),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                      height: 10
                  ),
                  // Inside cardsBuilder in your AppinioSwiper widget
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors
                              .black, // Set the color for the regular text
                        ),
                        children: [
                          TextSpan(
                            text: 'Lifting Experience:',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight
                                  .bold, // Set the part before the colon as bold
                            ),
                          ),
                          TextSpan(
                            text: ' ${user?.liftingExperience ??
                                'No Experience'}',
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                      height: 10
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors
                              .black, // Set the color for the regular text
                        ),
                        children: [
                          TextSpan(
                            text: 'Gym Goals:',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight
                                  .bold, // Set the part before the colon as bold
                            ),
                          ),
                          TextSpan(
                            text: ' ${user?.gymGoals ?? 'No Gym Goals'}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 10
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors
                              .black, // Set the color for the regular text
                        ),
                        children: [
                          TextSpan(
                            text: 'Lifting Style:',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight
                                  .bold, // Set the part before the colon as bold
                            ),
                          ),
                          TextSpan(
                            text: ' ${user?.liftingStyle ??
                                'No Lifting Style'}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 10
                  ),

                  // Here is my code for my buttons, and the logic as far as liking and disliking goes
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              String? currentUserID = getCurrentUserUID(); // Fetch the current user ID
                              String? likedUserID = group2Users?[index].uid; // Get the liked user ID

                              likeProfile(currentUserID!, likedUserID!); // Call your like function
                            },
                            child: Icon(
                              Icons.favorite,
                              size: 40,
                              color: Colors.green,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Perform the dislike action when the 'x' icon is tapped
                              // You might want to implement functionality for 'x' action
                            },
                            child: Icon(
                              Icons.close,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },

        );
      },
    );
  }

  bool isUserInGroup(User? user, String startLetter, String endLetter) {
    final displayName = user?.displayName;
    if (displayName != null && displayName.isNotEmpty) {
      final firstLetter = displayName[0].toUpperCase();
      return firstLetter.compareTo(startLetter) >= 0 &&
          firstLetter.compareTo(endLetter) <= 0;
    }
    return false;
  }
}





