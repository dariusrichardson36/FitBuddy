import 'package:fit_buddy/components/FitBuddyButton.dart';
import 'package:fit_buddy/models/FitBuddyActivityModel.dart';
import 'package:fit_buddy/models/FitBuddyExerciseModel.dart';
import 'package:flutter/material.dart';

class FitBuddyActivityListItem extends StatelessWidget {
  final Activity exercise;

  FitBuddyActivityListItem({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 100 ,child: Text(exercise.name, style: TextStyle(fontWeight: FontWeight.bold),)),
            FitBuddyButton(text: "Add set", onPressed: () {}, fontSize: 14,),
            Spacer(),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {

              }
            ),
          ],
        ),
        SizedBox(height: 10),
        // add a row for every entry in exercise.sets
        for (var setCollection in exercise.setCollection)
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text("sets"),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(setCollection.sets.toString()),
                  ),
                ]
              ),
              SizedBox(width: 10),
              Column(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text("reps"),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(setCollection.reps.toString()),
                    ),
                  ]
              ),
              SizedBox(width: 10),
              Column(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text("weight"),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(setCollection.weight.toString()),
                    ),
                  ]
              ),
            ],
          ),
        SizedBox(height: 10),
      ],
    );
  }



}

