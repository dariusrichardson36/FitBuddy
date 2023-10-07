

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
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 40,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: widget.activityData["activities"].map<Widget>((activityData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(activityData["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          SizedBox(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Sets", style: TextStyle(color: FitBuddyColorConstants.lOnSecondary)),
                                Text("Reps", style: TextStyle(color: FitBuddyColorConstants.lOnSecondary)),
                                Text("Weight", style: TextStyle(color: FitBuddyColorConstants.lOnSecondary)),
                              ],
                            ),
                          ),

                          ...activityData["activity"].map((detail) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: SizedBox(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(detail["sets"].toString()),
                                    Text(detail["reps"].toString()),
                                    Text(detail["weight"].toString()),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.activityData["activities"].map<Widget>((activityData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Activity name
                        Text(activityData["name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

                        // Reps title
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                          child: Text("reps", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                        ),

                        // Individual rep values
                        ...activityData["activity"].map<Widget>((detail) {
                          return Text(detail["reps"].toString(), style: TextStyle(fontSize: 14));
                        }).toList(),

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
}