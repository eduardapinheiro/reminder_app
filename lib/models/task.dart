class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      isCompleted: map['isCompleted'],
    );
  }
}
