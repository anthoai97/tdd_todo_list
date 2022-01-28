import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ttd_todo_list/core/error/failure.dart';
import 'package:ttd_todo_list/core/usecases/usecase.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/features/todo_list/domain/repositories/todo_repository.dart';

class GetTodoListByStatus
    implements Usecase<List<Todo>, GetTodoListByStatusParams> {
  final TodoRepository repository;

  GetTodoListByStatus(this.repository);

  @override
  Future<Either<Failure, List<Todo>>> call(
          GetTodoListByStatusParams params) async =>
      await repository.getTodoListByStatus(params.status);
}

class GetTodoListByStatusParams extends Equatable {
  final bool status;

  const GetTodoListByStatusParams(this.status);

  @override
  List<Object?> get props => [];
}
