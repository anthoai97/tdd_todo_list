import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/features/todo_list/domain/repositories/todo_repository.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/get_todo_list.dart';

import 'get_todo_list_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late GetTodoList usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = GetTodoList(mockTodoRepository);
  });

  const tTodoList = [Todo(content: 'Test', id: 1, status: false)];

  test('Should return a list of todo from repository', () async {
    // arrage
    when(mockTodoRepository.getTodoList())
        .thenAnswer((_) async => const Right(tTodoList));

    // act
    final result = await usecase.call(NoParams());

    // assert
    expect(result, equals(const Right(tTodoList)));
    verify(mockTodoRepository.getTodoList());
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
