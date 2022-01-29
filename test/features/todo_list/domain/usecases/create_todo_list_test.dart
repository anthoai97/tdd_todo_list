import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/create_todo_list.dart';

import 'get_todo_list_test.mocks.dart';

void main() {
  late CreateTodo usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = CreateTodo(mockTodoRepository);
  });

  const tTodo = Todo(content: 'Test', id: 1, status: false);

  test('Should return a todo when create Todo', () async {
    // arrage
    when(mockTodoRepository.createTodo(any))
        .thenAnswer((_) async => const Right(tTodo));

    // act
    final result = await usecase.call(const CreateTodoParam(todo: tTodo));

    // assert
    expect(result, equals(const Right(tTodo)));
    verify(mockTodoRepository.createTodo(tTodo));
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
