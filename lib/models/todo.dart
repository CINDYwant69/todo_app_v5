class Todo {
  int? id;
  String title;
  bool isCompleted;

  Todo({
    this.id,
    required this.title,
    this.isCompleted = false,
  });
}