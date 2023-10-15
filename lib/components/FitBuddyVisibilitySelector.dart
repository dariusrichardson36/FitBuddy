import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FitBuddyVisibilitySelector extends StatelessWidget {
  final onChanged;
  final String value;

  FitBuddyVisibilitySelector({
    super.key,
    required this.onChanged,
    required this.value,
  });


  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth (

      child: DropdownButtonFormField<String>(
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        //alignment: Alignment.center,
        decoration: InputDecoration(
          constraints: BoxConstraints(
            //maxWidth: 50,
          ),
        ),
        style: TextStyle(color: Colors.black),
        onChanged: onChanged,
        onTap: () {
          print("Hello");
        },
        items: <String>['Private', 'Public'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Text(value),
                SizedBox(width: 10),
                Icon(value == 'Private' ? Icons.visibility_off : Icons.visibility),
              ],
            ),
          );
        }).toList(),
        hint: value == 'Private'
            ? Icon(Icons.visibility_off)
            : (value == 'Public' ? Icon(Icons.visibility) : Text("Choose visibility")),
      ),
    );
  }


}