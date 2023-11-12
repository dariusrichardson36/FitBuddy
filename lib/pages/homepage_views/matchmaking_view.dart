import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/user.dart';
import 'package:intl/intl.dart';


Future<List<User>> getUsersFromFirestore() async {
  final collection = FirebaseFirestore.instance.collection('users');
  final snapshot = await collection.get();
  return snapshot.docs.map((doc) => User.fromDataSnapshot(doc)).toList();
}



String? currentUserID;

void getCurrentUser() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    currentUserID = user.uid;
    print('Current User ID: $currentUserID');
  } else {
    print('User is not logged in.');
  }
}

class MatchmakingView extends StatelessWidget {

  const MatchmakingView({Key? key}) : super(key: key);
  Future<void> likeProfile(String userId) async {
    try {
      // Add a like to Firestore
      final likedUserProfileRef =
      FirebaseFirestore.instance.collection('users').doc(currentUserID).collection('Likes').doc(userId);
      print('Liked added to Firestore!');
    } catch (error) {
      print('Error adding like: $error');
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

        int activeCardIndex = 0;

        return AppinioSwiper(

          cardsCount: group2Users?.length ?? 0,
          onSwiping: (AppinioSwiperDirection direction) {
            if (direction == AppinioSwiperDirection.bottom) {
              print('Liked');
            }
          },
          cardsBuilder: (BuildContext context, int index) {
            final user = group2Users?[index];
            final imageUrl = user?.image_url ?? placeholderImageUrl;

            final docID = group2Users?[index].uid ?? 'No ID'; // Assuming `userId` is the document ID field
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
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      ' ${user?.uid ??
                          'No id'}',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  ),
                  SizedBox(
                      height: 25
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





