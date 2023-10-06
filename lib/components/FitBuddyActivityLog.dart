

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
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 35,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      SizedBox(width: 10),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.activityData["creator_userName"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Text("6/10", style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12, color: FitBuddyColorConstants.lOnSecondary)),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 120, child:Text("Activity", style: TextStyle(color: FitBuddyColorConstants.lOnSecondary))),
                    SizedBox(width: 70, child:Text("Sets", style: TextStyle(color: FitBuddyColorConstants.lOnSecondary))),
                    SizedBox(width: 70, child:Text("Reps", style: TextStyle(color: FitBuddyColorConstants.lOnSecondary))),
                    SizedBox(width: 70, child:Text("Weight", style: TextStyle(color: FitBuddyColorConstants.lOnSecondary))),
                  ],
                ),
                SizedBox(height: 5),
                Column(
                  children: widget.activityData["activities"].map<Widget>((activityData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(activityData["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                        ...activityData["activity"].map((detail) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Expanded(child: Text(detail["sets"].toString())),
                                Expanded(child: Text(detail["reps"].toString())),
                                Expanded(child: Text(detail["weight"].toString())),
                              ],
                            ),
                          );
                        }).toList(),
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