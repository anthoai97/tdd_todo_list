import 'package:ttd_todo_list/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:ttd_todo_list/core/error/failure.dart';
import 'package:ttd_todo_list/features/todo_list/data/models/todo_model.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/features/todo_list/domain/repositories/todo_repository.dart';

class UpdateTodo implements Usecase<Todo, UpdateTodoParam> {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  @override
  Future<Either<Failure, Todo>> call(UpdateTodoParam params) async =>
      await repository.updateTodo(params.todo);
}

class UpdateTodoParam {
  final TodoModel todo;

  const UpdateTodoParam({required this.todo});
}
