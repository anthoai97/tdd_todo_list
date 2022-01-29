import 'package:ttd_todo_list/core/error/excaptions.dart';
import 'package:ttd_todo_list/features/todo_list/data/datasources/todo_local_data_source.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ttd_todo_list/features/todo_list/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Todo>> createTodo(Todo todo) async {
    try {
      final localTodo = await localDataSource.createTodo(todo);
      return Right(localTodo);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodoList() async {
    try {
      final localTodoList = await localDataSource.getTodoList();
      return Right(localTodoList);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo todo) async {
    try {
      final localTodo = await localDataSource.updateTodo(todo);
      return Right(localTodo);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
