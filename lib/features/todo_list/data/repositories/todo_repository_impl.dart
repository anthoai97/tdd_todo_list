import 'package:ttd_todo_list/core/error/excaptions.dart';
import 'package:ttd_todo_list/features/todo_list/data/datasources/todo_local_data_source.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ttd_todo_list/features/todo_list/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDateSource localDateSource;

  TodoRepositoryImpl({required this.localDateSource});

  @override
  Future<Either<Failure, Todo>> createTodo() {
    // TODO: implement createTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodoList() async {
    try {
      final localTodoList = await localDateSource.getTodoList();
      return Right(localTodoList);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Todo>> updateTodo() {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
