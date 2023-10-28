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
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black,),
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
        items: <String>['Private', 'Public'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            alignment: Alignment.center,
            child: ButtonTheme(
                buttonColor: FitBuddyColorConstants.lAccent,
                alignedDropdown: true,
                child: SizedBox(width: 10, child: Icon(value == 'Private' ? Icons.visibility_off : Icons.visibility))
            ),
          );
        }).toList(),
      ),
    );
  }
}