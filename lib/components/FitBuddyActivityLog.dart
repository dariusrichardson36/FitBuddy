

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_buddy/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/FitBuddyPostModel.dart';
import '../models/FitBuddyActivityModel.dart';

class FitBuddyActivityLog extends StatefulWidget {
  final Post postData;

  const FitBuddyActivityLog({
    super.key,
    required this.postData
  });

  @override
  _FitBuddyActivityLogState createState() => _FitBuddyActivityLogState();
}

class _FitBuddyActivityLogState extends State<FitBuddyActivityLog> {
  bool _showAllActivities = false;

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
    print("Activity data:");
    print(widget.postData.activities);
    var activities = widget.postData.activities;
    if (!_showAllActivities && activities.length > 2) {
      activities = activities.sublist(0, 2);
    }
    return Column(
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
              ...(widget.postData.description != "")
                  ? [
                Text(widget.postData.description, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              ]
                  : [],
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: activities.map<Widget>((activityData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      // Activity name
                      Text(activityData.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 5),
                      // Row containing three columns
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Column for reps
                            buildDetailColumn("reps", activityData.setCollection),
                            // Column for sets
                            buildDetailColumn("sets", activityData.setCollection),
                            // Column for weight
                            buildDetailColumn("weight", activityData.setCollection),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              if (!_showAllActivities && widget.postData.activities.length > 2)
                SizedBox(
                  height: 24,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        _showAllActivities = true;
                      });
                    },
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              if (_showAllActivities && widget.postData.activities.length > 2)
                SizedBox(
                  height: 24,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        _showAllActivities = false;
                      });
                    },
                    icon: Icon(Icons.keyboard_arrow_up),
                  ),
                ),
              //SizedBox(height: 10),
            ],
          ),
        )
      ],
    );
  }

  Widget buildDetailColumn(String label, List<SetCollection> activityData) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: FitBuddyColorConstants.lOnSecondary)),
        ...activityData.map<Widget>((detail) => Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(detail.getProperty(label).toString(), style: TextStyle(fontSize: 14))
        )).toList(),
      ],
    );
  }

  Widget profileHeader() {
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
              Text(widget.postData.creatorUserName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(formatDateForDisplay(widget.postData.timestamp), style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12, color: FitBuddyColorConstants.lOnSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}

