import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/features/todo_list/domain/repositories/todo_repository.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/get_todo_list.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/get_todo_list_by_status.dart';

import 'get_todo_list_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late GetTodoListByStatus usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = GetTodoListByStatus(mockTodoRepository);
  });

  const tStatus = true;
  const tTodoList = [
    Todo(content: 'Test', id: 1, status: tStatus),
    Todo(content: 'Test2', id: 2, status: tStatus)
  ];

  test('Should return a list of todo with same status from repository',
      () async {
    // arrage
    when(mockTodoRepository.getTodoListByStatus(any))
        .thenAnswer((_) async => const Right(tTodoList));

    // act
    final result = await usecase.call(const GetTodoListByStatusParams(tStatus));
	
    // assert
    expect(result, const Right(tTodoList));
    verify(mockTodoRepository.getTodoListByStatus(tStatus));
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
