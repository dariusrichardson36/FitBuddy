
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class FitBuddyDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String value;
  final onChange;
  final labelText;

  const FitBuddyDropdownMenu({
    super.key,
    required this.items,
    required this.value,
    required this.onChange,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField (
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: TextStyle(color: FitBuddyColorConstants.lOnSecondary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: FitBuddyColorConstants.lOnSecondary),

        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: FitBuddyColorConstants.lError),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: FitBuddyColorConstants.lError),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: FitBuddyColorConstants.lOnSecondary),
        ),
        //fillColor: FitBuddyColorConstants.lSecondary,
        filled: true, // Todo decide if should be filled or not
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,


          child: Text(value),
        );
      }).toList(),

      onChanged: onChange,
      icon: Icon(Icons.keyboard_arrow_down_rounded),
      iconSize: 50,
    );
  }
}
