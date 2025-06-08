class Task {
  final String id;
  String title;
  String description;
  DateTime dueDate;
  bool isComplete;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isComplete = false,
  });

  // ✅ Convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'isComplete': isComplete,
    };
  }

  // ✅ Convert from Firestore document
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      isComplete: map['isComplete'],
    );
  }
}
