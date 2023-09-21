
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FitBuddyDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String value;
  final onChange;

  const FitBuddyDropdownMenu({
    super.key,
    required this.items,
    required this.value,
    required this.onChange,
  });





  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField (
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500])
      ),
      value: value,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChange,

    );
  }
}
