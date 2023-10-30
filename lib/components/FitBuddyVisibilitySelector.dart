import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:fit_buddy/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class FitBuddyVisibilitySelector extends StatefulWidget {
  final onChanged;
  final String value;

  const FitBuddyVisibilitySelector({
    super.key,
    required this.onChanged,
    required this.value,
  });


  @override
  State<FitBuddyVisibilitySelector> createState() => _FitBuddyVisibilitySelectorState();
}

class _FitBuddyVisibilitySelectorState extends State<FitBuddyVisibilitySelector> {
  List<CoolDropdownItem<String>> visibilityDropdownItems = [];
  final visibilityDropdownController = DropdownController();
  final List<String> options = [
    'Public',
    'Private',
  ];

  @override
  void initState() {
    for (var i = 0; i < options.length; i++) {
      visibilityDropdownItems.add(
        CoolDropdownItem<String>(
            label: options[i],
            icon: SizedBox(
              height: 25,
              width: 25,
              child: Icon(
                options[i] == 'Private' ? Icons.visibility_off : Icons.visibility,
                color: Colors.white, // Set your desired icon color here
              )
            ),
            value: options[i]),
      );
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox (
      width: 60,
      height: 40,
      child: DropdownButtonHideUnderline(
        child: CoolDropdown<String>(
          dropdownList: visibilityDropdownItems,
          controller: visibilityDropdownController,

          onChange: (selected) {
            widget.onChanged(selected);
            visibilityDropdownController.close();
          },
          defaultItem: visibilityDropdownItems.first,
        ),
      ),
    );
  }
}