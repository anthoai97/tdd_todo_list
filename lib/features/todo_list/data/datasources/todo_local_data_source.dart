import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';

abstract class TodoLocalDateSource {
	Future<List<Todo>> getTodoList();
} 