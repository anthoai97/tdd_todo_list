import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/update_todo.dart';

import 'get_todo_list_test.mocks.dart';

void main() {
  late UpdateTodo usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = UpdateTodo(mockTodoRepository);
  });

  const tTodo = Todo(content: 'Test', id: 1, status: false);

  test('Should return a todo when update Todo complete', () async {
    // arrage
    when(mockTodoRepository.updateTodo(any))
        .thenAnswer((_) async => const Right(tTodo));

    // act
    final result = await usecase.call(const UpdateTodoParam(todo: tTodo));

    // assert
    expect(result, equals(const Right(tTodo)));
    verify(mockTodoRepository.updateTodo(tTodo));
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
