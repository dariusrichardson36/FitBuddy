

import 'package:flutter/cupertino.dart';

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
  @override
  Widget build(BuildContext context) {
    print(widget.activityData["activities"]);
    return Container(
      child: Column(
        children: [
          Row(
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
              Column(
                children: [
                  Text(widget.activityData["creator_userName"]),
                  Text("25/5")
                ],
              )
            ],
          ),
          Text("Activity  |  sets   |  reps  |   weight"),
          Column(
            children: widget.activityData["activities"].map<Widget>((activity) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(activity["workout"].toString()),
                  Text(activity["sets"].toString()),
                  Text(activity["reps"].toString()),
                  Text(activity["weight"].toString()), // replace with your desired widget
                  // ... any other widgets you want in this row
                ],
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}