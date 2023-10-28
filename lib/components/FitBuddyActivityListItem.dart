import 'package:fit_buddy/components/FitBuddyButton.dart';
import 'package:fit_buddy/models/FitBuddyActivityModel.dart';
import 'package:flutter/material.dart';

class FitBuddyActivityListItem extends StatelessWidget {
  final Activity exercise;
  final Function onRemove;
  final Function onAddSet;
  final Function update;

  const FitBuddyActivityListItem({
    super.key,
    required this.exercise,
    required this.onRemove,
    required this.onAddSet,
    required this.update,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 100 ,child: Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.bold),)),
            FitBuddyButton(text: "Add set", onPressed: () {
              onAddSet();
            }, fontSize: 14,),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                onRemove();
              }
            ),
          ],
        ),
        const SizedBox(height: 10),
        // add a row for every entry in exercise.sets
        for (var setCollection in exercise.setCollection)
          setCollectionRow(setCollection),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget setCollectionRow(SetCollection setCollection) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(onPressed: () {
                setCollection.sets--;
                update();
              }, icon: const Icon(Icons.remove, ), padding: EdgeInsets.zero, constraints: const BoxConstraints(),),
              Column(
                children: [
                  const Text("sets"),
                  Text(setCollection.sets.toString()),
                ]
              ),
              IconButton(onPressed: () {
                setCollection.sets++;
                update();
              }, icon: const Icon(Icons.add), padding: EdgeInsets.zero, constraints: const BoxConstraints(),),
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: () {
                setCollection.reps--;
                update();
              }, icon: const Icon(Icons.remove, ), padding: EdgeInsets.zero, constraints: BoxConstraints(),),
              Column(
                  children: [
                    const Text("reps"),
                    Text(setCollection.reps.toString()),
                  ]
              ),
              IconButton(onPressed: () {
                setCollection.reps++;
                update();
              }, icon: const Icon(Icons.add), padding: EdgeInsets.zero, constraints: const BoxConstraints(),),
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: () {
                setCollection.weight--;
                update();
              }, icon: const Icon(Icons.remove, ), padding: EdgeInsets.zero, constraints: const BoxConstraints(),),
              Column(
                  children: [
                    const Text("weight"),
                    Text(setCollection.weight.toString()),
                  ]
              ),
              IconButton(onPressed: () {
                setCollection.weight++;
                update();
              }, icon: const Icon(Icons.add), padding: EdgeInsets.zero, constraints: const BoxConstraints(),),
            ],
          ),
        ],
      ),
    );
  }
}

