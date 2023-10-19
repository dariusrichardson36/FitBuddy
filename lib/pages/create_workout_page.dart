import 'package:fit_buddy/models/FitBuddyExerciseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/FitBuddyButton.dart';
import '../components/FitBuddyVisibilitySelector.dart';
import '../constants/color_constants.dart';
import '../constants/route_constants.dart';
import '../models/FitBuddyActivityModel.dart';
import '../services/firestore/firestore_service.dart';

class CreateWorkoutPage extends StatefulWidget {
  // Create page variables
  List<Activity> _workout = [];
  final TextEditingController _descriptionController = TextEditingController();


  // Choose exercise page variables


  CreateWorkoutPage({super.key});

  @override
  State<CreateWorkoutPage> createState() => _CreateWorkoutPageState();
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage> with TickerProviderStateMixin {
  // Create page variables
  List<Activity> _workout = [];
  final TextEditingController _descriptionController = TextEditingController();
  bool _isCreate = true;
  String _dropdownValue = "Private";
  int _currentLength = 0;

  // Choose exercise page variables
  late TabController _tabController;
  int _selectedTabIndex = 0;
  late Stream _favoriteExercises;
  late Future _allExercises;

  void _switchView() {
    setState(() {
      _isCreate = !_isCreate;
    });
  }

  void _addExercise(Exercise exercise){
    setState(() {
      print(exercise.name);
      widget._workout.add(Activity(name: exercise.name, setCollection: <SetCollection>[]));
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
    _favoriteExercises = FirestoreService.firestoreService().postService.getFavoriteExercises();
    _allExercises = FirestoreService.firestoreService().postService.getAllExercises();
  }

  @override
  Widget build(BuildContext context) {
    if (_isCreate) {
      return _createWorkoutView();
    } else {
      return _chooseExerciseView();
    }
  }

  Widget _createWorkoutView() {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_rounded, size: 30),
                    onPressed: () {
                      context.goNamed(FitBuddyRouterConstants.homePage);
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
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget._workout.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget._workout[index].name),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_rounded),
                        onPressed: () {
                          setState(() {
                            widget._workout.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: FitBuddyButton(
                  text: "Add exercise",
                  onPressed: () {
                    _switchView();
                  },
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chooseExerciseView() {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.arrow_back_ios_rounded, size: 30), onPressed: _switchView),
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.0, color: FitBuddyColorConstants.lAccent),
                        insets: EdgeInsets.symmetric(horizontal: 50.0),
                      ),
                      tabs: [
                        Text(
                          "All",
                          style: TextStyle(
                            fontWeight: _selectedTabIndex == 0 ? FontWeight.bold : FontWeight.normal,
                            color: FitBuddyColorConstants.lAccent,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "Favorites",
                          style: TextStyle(
                            fontWeight: _selectedTabIndex == 1 ? FontWeight.bold : FontWeight.normal,
                            color: FitBuddyColorConstants.lAccent,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 30.0)
                ],
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Padding(padding: EdgeInsets.only(right: 20) ,child: Icon(Icons.search_rounded, size: 30, color: FitBuddyColorConstants.lOnPrimary,)),
                  prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 24),
                  border: InputBorder.none,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    allExercisesView(),
                    favoritesView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  allExercisesView() {
    return FutureBuilder(future: _allExercises, builder: (context, snapshot) {
      return snapshot.hasData ? ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return exercise(snapshot.data[index], false);
        },
      ) : Center(child: CircularProgressIndicator());
    });
  }

  favoritesView() {
    return StreamBuilder(stream: _favoriteExercises, builder: (context, snapshot) {
      return snapshot.hasData ? ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return exercise(snapshot.data[index], true);
        },
      ) : Center(child: CircularProgressIndicator());
    });
  }

  exercise(Exercise exercise, bool isFavorite) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _addExercise(exercise);
        _switchView();
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(exercise.name),
              IconButton(
                onPressed: () {
                  // Todo
                },
                icon: isFavorite
                    ? Icon(Icons.star_rounded, color: FitBuddyColorConstants.lAccent)
                    : Icon(Icons.star_border_rounded, color: FitBuddyColorConstants.lAccent),
              ),
            ],
          ),
          Divider(thickness: 2, color: FitBuddyColorConstants.lAccent),
        ],
      ),
    );
  }
}