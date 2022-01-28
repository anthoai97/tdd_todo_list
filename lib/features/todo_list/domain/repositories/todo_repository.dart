import 'package:dartz/dartz.dart';
import 'package:ttd_todo_list/core/error/failure.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';

abstract class TodoRepository {
	Future<Either<Failure, List<Todo>>> getTodoList();
	Future<Either<Failure, List<Todo>>> getTodoListByStatus(bool status);

	Future<Either<Failure, Todo>> createTodo();
	Future<Either<Failure, bool>> delete();
	Future<Either<Failure, Todo>> updateTodo();
}