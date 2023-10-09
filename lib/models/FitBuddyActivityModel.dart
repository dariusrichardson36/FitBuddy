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
}

class SetCollection {
  final int reps;
  final int sets;
  final int weight;

  SetCollection({required this.reps, required this.sets, required this.weight});

  factory SetCollection.fromMap(Map<String, dynamic> json) {
    return SetCollection(
      reps: json['reps'],
      sets: json['sets'],
      weight: json['weight'],
    );
  }
}
