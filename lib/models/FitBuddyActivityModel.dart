class Activity {
  final List<RepSet> repSets;
  final String name;

  Activity({required this.repSets, required this.name});

  factory Activity.fromJson(Map<String, dynamic> json) {
    var repSetJson = json['activity'] as List;
    List<RepSet> repSetsList = repSetJson.map((i) => RepSet.fromJson(i)).toList();
    return Activity(
      repSets: repSetsList,
      name: json['name'],
    );
  }
}

class RepSet {
  final int reps;
  final int sets;
  final int weight;

  RepSet({required this.reps, required this.sets, required this.weight});

  factory RepSet.fromJson(Map<String, dynamic> json) {
    return RepSet(
      reps: json['reps'],
      sets: json['sets'],
      weight: json['weight'],
    );
  }
}
