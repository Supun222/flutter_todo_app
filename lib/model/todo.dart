class Todo {
  String? id;
  String TodoText;
  bool isDone;

  Todo({
    required this.id,
    required this.TodoText,
    this.isDone = false
  });

  static List<Todo> todoList () {
    return [
      Todo(id: '1', TodoText: 'Morning Exercise', isDone: true),
      Todo(id: '2', TodoText: 'Buy Grocieries', isDone: true),
      Todo(id: '3', TodoText: 'Check mails'),
      Todo(id: '4', TodoText: 'Team meeting'),
      Todo(id: '5', TodoText: 'Work on mobile apps for 2 hours'),
      Todo(id: '5', TodoText: 'Making preworkout meal', isDone: true),
    ];
  }
}