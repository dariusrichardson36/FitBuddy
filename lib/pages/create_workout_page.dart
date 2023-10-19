import 'package:fit_buddy/pages/create_workout_views/choose_exercise_view.dart';
import 'package:flutter/cupertino.dart';

import 'create_workout_views/create_workout_view.dart';

class CreateWorkoutPage extends StatefulWidget {
  const CreateWorkoutPage({super.key});

  @override
  State<CreateWorkoutPage> createState() => _CreateWorkoutPageState();
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage>{
  bool _isCreate = true;

  void _switchView() {
    setState(() {
      _isCreate = !_isCreate;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isCreate) {
      print("entering create workout view");
      return CreateWorkoutView(onButtonPressed: _switchView);
    } else {
      print("entering choose exercise view");
      return ChooseExerciseView(onButtonPressed: _switchView,);
    }
  }
}