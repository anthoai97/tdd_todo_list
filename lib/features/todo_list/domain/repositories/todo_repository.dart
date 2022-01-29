import 'package:dartz/dartz.dart';
import 'package:ttd_todo_list/core/error/failure.dart';
import 'package:ttd_todo_list/features/todo_list/data/models/todo_model.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodoList();

  Future<Either<Failure, Todo>> createTodo(TodoModel todo);

  Future<Either<Failure, Todo>> updateTodo(TodoModel todo);
}
