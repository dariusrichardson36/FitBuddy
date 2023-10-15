import 'package:flutter/material.dart';

import '../components/FitBuddyButton.dart';
import '../components/FitBuddyVisibilitySelector.dart';

class CreateWorkoutPage extends StatefulWidget {
  const CreateWorkoutPage({Key? key}) : super(key: key);

  @override
  _CreateWorkoutPageState createState() => _CreateWorkoutPageState();
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage> {
  final TextEditingController _descriptionController = TextEditingController();
  String _dropdownValue = "Private";
  int _currentLength = 0;

  @override
  initState() {
    super.initState();
    _descriptionController.addListener(() {
      setState(() {
        _currentLength = _descriptionController.text.length;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FitBuddyVisibilitySelector(
                    value: _dropdownValue,
                    onChanged: (value) {
                      setState(() {
                        _dropdownValue = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _descriptionController,
                maxLength: 60,
                maxLines: 2,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  counterStyle: TextStyle(
                    height: double.minPositive,
                  ),
                  counterText: "$_currentLength/60",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  labelText: 'Workout description',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                height: 50,
                child: FitBuddyButton(
                  text: "Add exercise",
                  onPressed: () {
                    //Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
