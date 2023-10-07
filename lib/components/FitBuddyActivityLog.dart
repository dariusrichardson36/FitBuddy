

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_buddy/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FitBuddyActivityLog extends StatefulWidget {
  final activityData;

  const FitBuddyActivityLog({
    super.key,
    required this.activityData
  });

  @override
  _FitBuddyActivityLogState createState() => _FitBuddyActivityLogState();
}

class _FitBuddyActivityLogState extends State<FitBuddyActivityLog> {

  String formatDateForDisplay(Timestamp timestamp) {
    final currentDate = DateTime.now();
    final postDate = timestamp.toDate();
    final difference = currentDate.difference(postDate);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays <= 5) {
      return '${difference.inDays}d';
    } else {
      return '${postDate.month}/${postDate.day}';
    }
  }


  @override
  Widget build(BuildContext context) {
    print(widget.activityData.data());
    return Container(
      child: Column(
        children: [
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile header
                profileHeader(),
                SizedBox(height: 10),
                // if no description, or description is empty don't show
                ...(widget.activityData["description"] != null && widget.activityData["description"] != "")
                    ? [
                  Text(widget.activityData["description"], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  SizedBox(height: 10),
                ]
                    : [],
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget.activityData["activities"].map<Widget>((activityData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Activity name
                        Text(activityData["name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(height: 5),
                        // Row containing three columns
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Column for reps
                              Column(
                                children: [
                                  Text("reps", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: FitBuddyColorConstants.lOnSecondary)),
                                  ...activityData["activity"].map<Widget>((detail) {
                                    return Padding(padding: EdgeInsets.only(top: 5) ,child: Text(detail["reps"].toString(), style: TextStyle(fontSize: 14)));
                                  }).toList(),
                                ],
                              ),
                              // Column for sets
                              Column(
                                children: [
                                  Text("sets", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: FitBuddyColorConstants.lOnSecondary)),
                                  ...activityData["activity"].map<Widget>((detail) {
                                    return Padding(padding: EdgeInsets.only(top: 5), child: Text(detail["sets"].toString(), style: TextStyle(fontSize: 14)));
                                  }).toList(),
                                ],
                              ),
                              // Column for weight
                              Column(
                                children: [
                                  Text("weight", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: FitBuddyColorConstants.lOnSecondary)),
                                  ...activityData["activity"].map<Widget>((detail) {
                                    return Padding(padding: EdgeInsets.only(top: 5), child: Text(detail["weight"].toString(), style: TextStyle(fontSize: 14)));
                                  }).toList(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Spacing between each activity
                        SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  profileHeader() {
    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage('https://pbs.twimg.com/profile_images/1650839170653335552/WgtT2-ut_400x400.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.activityData["creator_userName"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(formatDateForDisplay(widget.activityData["timestamp"]), style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12, color: FitBuddyColorConstants.lOnSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}

