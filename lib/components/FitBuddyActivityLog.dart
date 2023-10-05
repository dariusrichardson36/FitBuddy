

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
  @override
  Widget build(BuildContext context) {
    print(widget.activityData["activities"]);
    return Container(
      child: Column(
        children: [
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < ["Activity", "sets", "reps", "weight"].length; i++)
                        ...[
                          VerticalDivider(color: Colors.black, thickness: 1,),  // Do not insert a divider before the first item
                          Expanded(child: Text(["Activity", "sets", "reps", "weight"][i], textAlign: TextAlign.center))
                        ],
                    ],
                  ),
                ),
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}