
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_buddy/components/FitBuddyActivityLog.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TimeLineView extends StatefulWidget {
  const TimeLineView({super.key});

  @override
  _TimeLineViewState createState() => _TimeLineViewState();
}

class _TimeLineViewState extends State<TimeLineView> {
  late Stream<QuerySnapshot> _timelinePostsStream;
  bool _isLoading = true;
  int _postsLoaded = 0;

  @override
  void initState() {
    super.initState();
    loadTimeline();
  }

  void loadMorePosts(context) {

  }

  void loadTimeline() {
    // Replace with actual currentUserId
    //String currentUserId = 'exampleUserId';
    //List<String> friendsIds = await getFriendsIds();
    setState(() {
      _timelinePostsStream = Firestore().getTimelineStream();
      _postsLoaded = 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _timelinePostsStream,
      builder: (context, snapshot) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage('https://pbs.twimg.com/profile_images/1650839170653335552/WgtT2-ut_400x400.jpg'), // Replace with your image URL
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Image.asset("lib/images/logo.png", width: 35, height: 35),
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                ],
              ),
            ),
            if (snapshot.connectionState == ConnectionState.waiting) ... {
              Center(child: CircularProgressIndicator()),
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) ... {
              Expanded(
                child: ListView.builder(
                  controller: ScrollController(),
                  itemCount: snapshot.data!.docs.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == snapshot.data!.docs.length) {
                      return Padding(padding: EdgeInsets.symmetric(vertical: 20) ,child: Center(child: CircularProgressIndicator())); // Loading indicator at the end
                    }
                    final post = snapshot.data!.docs[index];
                    return FitBuddyActivityLog(activityData: post);
                  },
                ),
              ),
            } else ... {
              Center(child: Text('No posts available.')),
            },
          ],
        );
      },
    );
  }
}