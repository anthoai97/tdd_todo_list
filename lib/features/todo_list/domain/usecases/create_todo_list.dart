import 'package:dartz/dartz.dart';
import 'package:ttd_todo_list/core/error/failure.dart';
import 'package:ttd_todo_list/core/usecases/usecase.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/features/todo_list/domain/repositories/todo_repository.dart';

class CreateTodo implements Usecase<Todo, CreateTodoParam> {
  final TodoRepository repository;

  CreateTodo(this.repository);

  @override
  Future<Either<Failure, Todo>> call(CreateTodoParam params) async =>
      await repository.createTodo(params.todo);
}

class CreateTodoParam {
  final Todo todo;

  const CreateTodoParam({required this.todo});
}
