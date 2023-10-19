import 'package:fit_buddy/components/FitBuddyTimeLinePost.dart';
import 'package:fit_buddy/services/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/FitBuddyPostModel.dart';

class SinglePostPage extends StatefulWidget {
  final String postId;

  SinglePostPage({super.key, required this.postId});

  @override
  State<SinglePostPage> createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  Future<Post>? postFuture;

  @override
  void initState() {
    super.initState();
    postFuture = FireStore.FireStore().getSinglePost(widget.postId);  // Assuming you have postId in your widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Single Post Page"),
      ),
      body: Center(
        child: FutureBuilder<Post>(
          future: postFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              Post? post = snapshot.data;
              if (post != null) {
                return FitBuddyTimelinePost(postData: post);
              } else {
                return Text("Post not found");
              }
            } else {
              return CircularProgressIndicator(); // Show loading indicator while fetching
            }
          },
        ),
      ),
    );
  }
}