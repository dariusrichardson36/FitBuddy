import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';

Future<List<User>> getUsersFromFirestore() async {
  final collection = FirebaseFirestore.instance.collection('users');
  final snapshot = await collection.get();
  return snapshot.docs.map((doc) => User.fromDataSnapshot(doc)).toList();
}

class MatchmakingView extends StatelessWidget {
  const MatchmakingView({Key? key}) : super(key: key);

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

        final group1Users = users?.where((user) => isUserInGroup(user, 'A', 'F')).toList();
        final group2Users = users?.where((user) => isUserInGroup(user, 'G', 'M')).toList();
        final group3Users = users?.where((user) => isUserInGroup(user, 'N', 'S')).toList();
        final group4Users = users?.where((user) => isUserInGroup(user, 'T', 'Z')).toList();

        return AppinioSwiper(
          cardsCount: group1Users?.length ?? 0,
          onSwiping: (AppinioSwiperDirection direction) {
            print(direction.toString());
          },

          cardsBuilder: (BuildContext context, int index) {
            final user = group1Users?[index];
            final imageUrl = user?.image_url ?? placeholderImageUrl;

            return Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.blue,
              child: Column(
                children: [
                  // Profile picture aligned with the top of the card and taking half of the height
                  Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height * 0.43, // Adjust as needed
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Text widget with size 24 font aligned to the left
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16.0), // Add padding to the left side of the text
                    child: Text(
                      user?.displayName ?? 'No Name',
                      style: TextStyle(
                        fontSize: 30, // Set the font size to 24
                        fontWeight: FontWeight.bold
                      ),
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
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Gym Experience: ',
                      style: TextStyle(
                        fontSize: 20,
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
                      'Gym Goals: ',
                      style: TextStyle(
                        fontSize: 20,
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
                      'Lifting Style: ',
                      style: TextStyle(
                        fontSize: 20,
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
                      'Training Frequency: ',
                      style: TextStyle(
                        fontSize: 20,

                      ),
                    ),
                  ),
                  SizedBox(
                      height: 40
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Implement the "Yes" button action here
                          // This will be triggered when the green dumbbell is tapped
                          print('No Button Tapped');
                        },
                        child: FaIcon(
                          FontAwesomeIcons.dumbbell,
                          color: Colors.red,
                          size: 60.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Implement the "No" button action here
                          // This will be triggered when the red dumbbell is tapped
                          print('Yes Button Tapped');
                        },
                        child: FaIcon(
                          FontAwesomeIcons.dumbbell,
                          color: Colors.green,
                          size: 60.0,
                        ),
                      ),
                    ],
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




