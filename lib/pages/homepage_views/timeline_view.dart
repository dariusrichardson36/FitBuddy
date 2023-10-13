
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TimeLineView extends StatefulWidget {
  const TimeLineView({super.key});

  @override
  _TimeLineViewState createState() => _TimeLineViewState();
}

class _TimeLineViewState extends State<TimeLineView> {
  late Stream<QuerySnapshot> timelinePostsStream;

  @override
  void initState() {
    super.initState();
    loadTimeline();
  }

  void loadTimeline() async {
    // Replace with actual currentUserId
    //String currentUserId = 'exampleUserId';
    //List<String> friendsIds = await getFriendsIds();
    setState(() {
      timelinePostsStream = Firestore().getTimelineStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: timelinePostsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No posts available.'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final post = snapshot.data!.docs[index];
            return ListTile(
              title: Text(post['description']),
              //subtitle: Text('By ${post['userId']} at ${post['timestamp']}'),
            );
          },
        );
      },
    );
  }
}