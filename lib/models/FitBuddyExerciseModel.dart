class Exercise {
  final String Name;

  Exercise({required this.Name});

  factory Exercise.fromMap(Map<String, dynamic> json) {
    return Exercise(
      Name: json['name'],
    );
  }
}