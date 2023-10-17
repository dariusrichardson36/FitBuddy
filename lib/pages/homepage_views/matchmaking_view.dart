import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';

Future<List<User>> getUsersFromFirestore() async {
  final collection = FirebaseFirestore.instance.collection('users');
  final snapshot = await collection.get();
  return snapshot.docs.map((doc) => User.fromDataSnapshot(doc)).toList();
}

class MatchmakingView extends StatelessWidget {
  const MatchmakingView({Key? key}) : super(key: key);

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

        return AppinioSwiper(
          cardsCount: users?.length ?? 0,
          onSwiping: (AppinioSwiperDirection direction) {
            print(direction.toString());
          },
          cardsBuilder: (BuildContext context, int index) {
            final user = users?[index];
            return Container(
              alignment: Alignment.center,
              child: Text(user?.displayName ?? 'No Name'),
              color: CupertinoColors.activeBlue,
            );
          },
        );
      },
    );
  }
}



