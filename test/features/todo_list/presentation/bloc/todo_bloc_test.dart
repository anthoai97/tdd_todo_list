import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ttd_todo_list/core/error/failure.dart';
import 'package:ttd_todo_list/features/todo_list/data/models/todo_model.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/create_todo_list.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/get_todo_list.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/update_todo.dart';
import 'package:ttd_todo_list/features/todo_list/presentation/bloc/todo_bloc.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'todo_bloc_test.mocks.dart';

@GenerateMocks([GetTodoList, CreateTodo, UpdateTodo])
void main() {
  late MockGetTodoList mockGetTodoList;
  late MockCreateTodo mockCreateTodo;
  late MockUpdateTodo mockUpdateTodo;
  late TodoBloc bloc;

  setUp(() {
    mockGetTodoList = MockGetTodoList();
    mockCreateTodo = MockCreateTodo();
    mockUpdateTodo = MockUpdateTodo();

    bloc = TodoBloc(
      getTodoList: mockGetTodoList,
      createTodo: mockCreateTodo,
      updateTodo: mockUpdateTodo,
    );
  });

  test('InitialState should be empty', () {
    // assert
    expect(bloc.state, equals(TodoLoading()));
  });

  group('Get todo list', () {
    final tTodoList = [
      const Todo(content: 'Test', id: 1, status: false),
      const Todo(content: 'Test2', id: 2, status: false)
    ];

    final tTodo = TodoModel.fromJson((json.decode(fixture('todo.json'))));
    const tTodoUpdate = Todo(content: 'Test', id: 1, status: true);

    final tCreateTodoList = List<Todo>.from(tTodoList)..add(tTodo);
    final tUpdateTodoList = [
      const Todo(content: 'Test', id: 1, status: true),
      const Todo(content: 'Test2', id: 2, status: false)
    ];

    test('Should get data from the get todo usecase', () async {
      // arrange
      when(mockGetTodoList(any)).thenAnswer((_) async => Right(tTodoList));

      // act
      bloc.add(const InitialTodo(status: null));
      await untilCalled(mockGetTodoList(any));
      // assert
      verify(mockGetTodoList(NoParams()));
    });

    blocTest<TodoBloc, TodoState>(
      'Should emit [Loading, Loaded] when data is gotten successfullly',
      build: () {
        when(mockGetTodoList(any)).thenAnswer((_) async => Right(tTodoList));
        return bloc;
      },
      act: (bloc) => bloc.add(const InitialTodo(status: null)),
      expect: () => <TodoState>[
        TodoLoading(),
        TodoLoaded(todoList: tTodoList),
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

    blocTest<TodoBloc, TodoState>(
      'Should emit [Loading, Loaded] when create todo is gotten successfullly',
      build: () {
        when(mockCreateTodo(any)).thenAnswer((_) async => Right(tTodo));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(CreateTodoEvent(todo: tTodo, todoList: tTodoList)),
      expect: () => <TodoState>[
        TodoLoading(),
        TodoLoaded(todoList: tCreateTodoList),
      ],
    );

    blocTest<TodoBloc, TodoState>(
      'Should emit [Loading, Error] with a proper message for the error when create fails',
      build: () {
        when(mockCreateTodo(any)).thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(CreateTodoEvent(todo: tTodo, todoList: tTodoList)),
      expect: () => <TodoState>[
        TodoLoading(),
        const TodoError(message: errorMsg),
      ],
    );

    blocTest<TodoBloc, TodoState>(
      'Should emit [Loading, Loaded] when update todo is gotten successfullly',
      build: () {
        when(mockUpdateTodo(any))
            .thenAnswer((_) async => const Right(tTodoUpdate));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(UpdateTodoEvent(todo: tTodoUpdate, todoList: tTodoList)),
      expect: () => <TodoState>[
        TodoLoading(),
        TodoLoaded(todoList: tUpdateTodoList),
      ],
    );

    blocTest<TodoBloc, TodoState>(
      'Should emit [Loading, Error] with a proper message for the error when update fails',
      build: () {
        when(mockCreateTodo(any)).thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(CreateTodoEvent(todo: tTodoUpdate, todoList: tTodoList)),
      expect: () => <TodoState>[
        TodoLoading(),
        const TodoError(message: errorMsg),
      ],
    );
  });
}
