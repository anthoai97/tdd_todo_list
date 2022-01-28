import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ttd_todo_list/core/error/failure.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/get_todo_list.dart';
import 'package:ttd_todo_list/features/todo_list/presentation/bloc/todo_bloc.dart';

import 'todo_bloc_test.mocks.dart';

@GenerateMocks([GetTodoList])
void main() {
  late MockGetTodoList mockGetTodoList;
  late TodoBloc bloc;

  setUp(() {
    mockGetTodoList = MockGetTodoList();
    bloc = TodoBloc(getTodoList: mockGetTodoList);
  });

  test('InitialState should be empty', () {
    // assert
    expect(bloc.state, equals(TodoLoading()));
  });

  group('Get todo list', () {
    const tTodoList = [
      Todo(content: 'Test', id: 1, status: false),
      Todo(content: 'Test2', id: 2, status: false)
    ];

    test('Should get data from the get todo usecase', () async {
      // arrange
      when(mockGetTodoList(any))
          .thenAnswer((_) async => const Right(tTodoList));

      // act
      bloc.add(const InitialTodo(status: null));
      await untilCalled(mockGetTodoList(any));
      // assert
      verify(mockGetTodoList(NoParams()));
    });

    blocTest<TodoBloc, TodoState>(
      'Should emit [Loading, Loaded] when data is gotten successfullly',
      build: () {
        when(mockGetTodoList(any))
            .thenAnswer((_) async => const Right(tTodoList));
        return bloc;
      },
      act: (bloc) => bloc.add(const InitialTodo(status: null)),
      expect: () => <TodoState>[
        TodoLoading(),
        const TodoLoaded(todoList: tTodoList),
      ],
    );

    blocTest<TodoBloc, TodoState>(
      'Should emit [Loading, Error] with a proper message for the error when the getting data fails',
      build: () {
        when(mockGetTodoList(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const InitialTodo(status: null)),
      expect: () => <TodoState>[
        TodoLoading(),
        const TodoError(message: errorMsg),
      ],
    );
  });
}
