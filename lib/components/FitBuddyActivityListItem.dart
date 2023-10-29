import 'package:fit_buddy/components/FitBuddyButton.dart';
import 'package:fit_buddy/components/FitBuddyTextFormField.dart';
import 'package:fit_buddy/models/FitBuddyActivityModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FitBuddyActivityListItem extends StatefulWidget {
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
  State<FitBuddyActivityListItem> createState() => _FitBuddyActivityListItemState();
}

class _FitBuddyActivityListItemState extends State<FitBuddyActivityListItem> {
  final weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 100 ,child: Text(widget.exercise.name, style: const TextStyle(fontWeight: FontWeight.bold),)),
            FitBuddyButton(text: "Add set", onPressed: () {
              widget.onAddSet();
            }, fontSize: 14,),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.onRemove();
              }
            ),
          ],
        ),
        const SizedBox(height: 10),
        // add a row for every entry in exercise.sets
        for (var setCollection in widget.exercise.setCollection)
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
                widget.update();
              }, icon: const Icon(Icons.remove, ), constraints: const BoxConstraints(),),
              Column(
                children: [
                  const Text("sets"),
                  const SizedBox(height: 10),
                  Text(setCollection.sets.toString()),
                ]
              ),
              IconButton(onPressed: () {
                setCollection.sets++;
                widget.update();
              }, icon: const Icon(Icons.add), constraints: const BoxConstraints(),),
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: () {
                setCollection.reps--;
                widget.update();
              }, icon: const Icon(Icons.remove, ), constraints: const BoxConstraints(),),
              Column(
                  children: [
                    const Text("reps"),
                    const SizedBox(height: 10),
                    Text(setCollection.reps.toString()),
                  ]
              ),
              IconButton(onPressed: () {
                setCollection.reps++;
                widget.update();
              }, icon: const Icon(Icons.add), constraints: const BoxConstraints(),),
            ],
          ),
          Column(
            children: [
              const Text("weight"),
              SizedBox(
                height: 30,
                width: 70,
                child: TextFormField(
                  initialValue: '0',
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(0),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,4}(\.\d{0,2})?$'), replacementString: '9999.99'),

                  ],
                  onChanged: (value) {
                    if (value != "") {
                      double parsedValue = double.parse(value);
                      setCollection.weight = parsedValue;
                      widget.update();
                    }
                  },

                ),
              ),
            ]
          ),
        ],
      ),
    );
  }
}

