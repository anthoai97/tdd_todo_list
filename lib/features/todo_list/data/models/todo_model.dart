import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel(
      {required int id, required bool status, required String content})
      : super(id: id, status: status, content: content);

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      content: json['content'],
      id: (json['id'] as num).toInt(),
      status: (json['status'] as bool),
    );
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'content': content, 'status': status};
}
