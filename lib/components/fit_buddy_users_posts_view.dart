import 'dart:async';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_buddy/components/FitBuddyActivityLog.dart';
import 'package:fit_buddy/models/FitBuddyPostModel.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UserPostsView extends StatefulWidget {
  const UserPostsView({super.key});

  @override
  _TimeLineViewState createState() => _TimeLineViewState();
}

class _TimeLineViewState extends State<UserPostsView> {
  late Stream<List<Post>> _timelinePostsStream;
   final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  final _firestore = FireStore.FireStore();

  @override
  void initState() {
    super.initState();
    loadTimeline();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        loadMorePosts();
      }
    });
  }

  Future<void> loadMorePosts() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      _firestore.getMoreTimeLinePosts();
      setState(() {
        _isLoading = false;
      });
    }
  }

  void loadTimeline() {
    setState(() {
      _firestore.initTimeLine();
      _timelinePostsStream = _firestore.postsController.stream;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Post>>(
      stream: _timelinePostsStream,
      builder: (context, snapshot) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (snapshot.connectionState == ConnectionState.waiting) ... {
              Center(child: CircularProgressIndicator()),
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) ... {
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data!.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == snapshot.data!.length && _isLoading) {
                      return Padding(padding: EdgeInsets.symmetric(vertical: 20) ,child: Center(child: CircularProgressIndicator())); // Loading indicator at the end
                    }
                    final posts = snapshot.data!;
                    return FitBuddyTimelinePost(postData: posts[index]);
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