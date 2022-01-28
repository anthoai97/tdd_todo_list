import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ttd_todo_list/features/todo_list/data/models/todo_model.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tTodoModel = TodoModel(id: 1, content: 'Test', status: false);
  test('Should be a subclass of Todo entity', () {
    expect(tTodoModel, isA<Todo>());
  });

  group('FromJson', () {
    test('Should return a valid model when the use JSON data', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('todo.json'));

      // act
      final result = TodoModel.fromJson(jsonMap);

      // assert
      expect(result, tTodoModel);
    });

    test('Should return Json map containing the proper data', () async {
      // act
      final result = tTodoModel.toJson();

      // assert
      final validMatcher = {"id": 1, "content": "Test", "status": false};
      expect(result, validMatcher);
    });
  });
}
