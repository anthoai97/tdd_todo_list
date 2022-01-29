import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttd_todo_list/core/constants.dart';
import 'package:ttd_todo_list/features/todo_list/data/datasources/todo_local_data_source.dart';
import 'package:ttd_todo_list/features/todo_list/data/models/todo_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late TodoLocalDataSourceImpl dataSource;
  late SharedPreferences sharedPreferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.todoKey: fixture('todo_cache.json'),
    });
    sharedPreferences = await SharedPreferences.getInstance();
    dataSource = TodoLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  });

  group("Get Cache Todo list", () {
    final tTodoList = (json.decode(fixture('todo_cache.json')) as List)
        .map((e) => TodoModel.fromJson(e))
        .toList();

    test(
        "Should return Todo list from SharedPreference when there is in the cache",
        () async {
      // act
      final result = await dataSource.getTodoList();
      // assert
      expect(result, equals(tTodoList));
    });
  });

  group('Create Todo', () {
    final tTodo = TodoModel.fromJson((json.decode(fixture('todo.json'))));

    test('Should return a todo when create todo complete', () async {
      // act
      final result = await dataSource.createTodo(tTodo);

      // assert
      expect(result, equals(tTodo));
    });
  });

  group('Update Todo', () {
    final tTodo = TodoModel.fromJson((json.decode(fixture('todo.json'))));

    test('Should return a todo when update todo complete', () async {
      // act
      final result = await dataSource.updateTodo(tTodo);

      // assert
      expect(result, equals(tTodo));
    });
  });
}
