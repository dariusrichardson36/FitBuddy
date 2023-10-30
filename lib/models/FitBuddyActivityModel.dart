class Activity {
  final List<SetCollection> setCollection;
  final String name;

  Activity({required this.setCollection, required this.name});

  factory Activity.fromMap(Map<String, dynamic> json) {
    var setCollection = json['activity'] as List;
    List<SetCollection> setCollectionList = setCollection.map((i) => SetCollection.fromMap(i)).toList();
    return Activity(
      setCollection: setCollectionList,
      name: json['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'activity': setCollection.map((e) => e.toMap()).toList(),
      'name': name,
    };
  }
}

class SetCollection {
  int reps;
  int sets;
  double weight;

  SetCollection({
    this.reps = 0,
    this.sets = 0,
    this.weight = 0});


  getProperty(String label) {
    if (label == 'reps') return reps;
    if (label == 'sets') return sets;
    if (label == 'weight') return weight;
    throw Exception('Invalid property name');
  }

  factory SetCollection.fromMap(Map<String, dynamic> json) {
    return SetCollection(
      reps: json['reps'],
      sets: json['sets'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reps': reps,
      'sets': sets,
      'weight': weight,
    };
  }

  String formatWeight() {
    if (weight == weight.truncateToDouble()) {
      // If weight is a whole number
      return weight.truncate().toString();
    } else {
      // If weight has decimal places
      return weight.toStringAsFixed(2); // This will give you 2 decimal places
    }
  }

  void incrementReps() {
    reps++;
  }

  void decrementReps() {
    if (reps > 0) reps--;
  }

  void incrementSets() {
    sets++;
  }

  void decrementSets() {
    if (sets > 0) sets--;
  }

}
