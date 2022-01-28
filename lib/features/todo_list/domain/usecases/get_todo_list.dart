import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ttd_todo_list/core/error/failure.dart';
import 'package:ttd_todo_list/core/usecases/usecase.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/features/todo_list/domain/repositories/todo_repository.dart';

class GetTodoList implements Usecase<List<Todo>, NoParams> {
  final TodoRepository repository;

  GetTodoList(this.repository);

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async => await repository.getTodoList();
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
