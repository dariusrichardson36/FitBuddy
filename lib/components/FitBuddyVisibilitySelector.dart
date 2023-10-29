import 'package:fit_buddy/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FitBuddyVisibilitySelector extends StatelessWidget {
  final onChanged;
  final String value;

  const FitBuddyVisibilitySelector({
    super.key,
    required this.onChanged,
    required this.value,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox (
      width: 75,
      height: 40,
      child: DropdownButtonFormField<String>(
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white,),
        //alignment: Alignment.center,
        decoration: InputDecoration(
          isDense: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(30.0)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: FitBuddyColorConstants.lAccent,
        ),
        isDense: true,
        alignment: Alignment.center,
        borderRadius: BorderRadius.circular(10.0),
        style: const TextStyle(color: Colors.black),
        onChanged: onChanged,
        value: value,
        itemHeight: null,
        items: <String>['Private', 'Public'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,

            child: Container(
              color: FitBuddyColorConstants.lAccent, // Set your desired color here
              child: Center(
                child: Icon(
                  value == 'Private' ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white, // Set your desired icon color here
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}