import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ttd_todo_list/core/error/excaptions.dart';
import 'package:ttd_todo_list/core/error/failure.dart';
import 'package:ttd_todo_list/features/todo_list/data/datasources/todo_local_data_source.dart';
import 'package:ttd_todo_list/features/todo_list/data/repositories/todo_repository_impl.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';

import 'todo_repository_impl_test.mocks.dart';

@GenerateMocks([TodoLocalDataSource])
void main() {
  late TodoRepositoryImpl repositoryImpl;
  late MockTodoLocalDataSource mockTodoLocalDataSource;

  const tStatus = false;
  const tTodoList = [
    Todo(content: 'Test', id: 1, status: tStatus),
    Todo(content: 'Test2', id: 2, status: tStatus)
  ];

  setUp(() {
    mockTodoLocalDataSource = MockTodoLocalDataSource();
    repositoryImpl =
        TodoRepositoryImpl(localDataSource: mockTodoLocalDataSource);
  });

  group('Get todo list', () {
    test('Should return List<Todo> locally cached data list', () async {
      // arrange
      when(mockTodoLocalDataSource.getTodoList())
          .thenAnswer((_) async => tTodoList);

      // act
      final result = await repositoryImpl.getTodoList();

      // assert
      verify(mockTodoLocalDataSource.getTodoList());
      expect(result, equals(const Right(tTodoList)));
    });

    test('Should return CacheFailure when no cache data present', () async {
      // arrange
      when(mockTodoLocalDataSource.getTodoList()).thenThrow(CacheException());

      // act
      final result = await repositoryImpl.getTodoList();

      // assert
      verify(mockTodoLocalDataSource.getTodoList());
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
