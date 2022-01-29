import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttd_todo_list/core/constants.dart';
import 'package:ttd_todo_list/core/error/excaptions.dart';
import 'package:ttd_todo_list/features/todo_list/data/models/todo_model.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';

abstract class TodoLocalDataSource {
  Future<List<Todo>> getTodoList();

  Future<Todo> createTodo(TodoModel todo);

  Future<Todo> updateTodo(TodoModel todo);

  Future<bool> saveTodo(List<TodoModel> todoList);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final SharedPreferences sharedPreferences;
  TodoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<Todo>> getTodoList() {
    final jsonString =
        sharedPreferences.getString(SharedPreferencesKey.todoKey);
    if (jsonString != null) {
      return Future.value((json
          .decode(jsonString)
          .map<Todo>((e) => TodoModel.fromJson(e))
          .toList()));
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<Todo> createTodo(Todo todo) async {
    final jsonString =
        sharedPreferences.getString(SharedPreferencesKey.todoKey);
    List<Todo> data;
    if (jsonString != null) {
      data = (json
          .decode(jsonString)
          .map<Todo>((e) => TodoModel.fromJson(e))
          .toList());
    } else {
      data = [];
    }
    data.add(todo);
    await saveTodo(data);
    return todo;
  }

  @override
  Future<Todo> updateTodo(Todo todo) async {
    final jsonString =
        sharedPreferences.getString(SharedPreferencesKey.todoKey);

    List<Todo> data;
    if (jsonString != null) {
      data = (json
          .decode(jsonString)
          .map<Todo>((e) => TodoModel.fromJson(e))
          .toList());
    } else {
      data = [];
    }

    var index = data.indexWhere((e) => e.id == todo.id);
    data[index] = todo;

    await saveTodo(data);
    return todo;
  }

  @override
  Future<bool> saveTodo(List<Todo> todoList) {
    try {
      String list = json.encode(todoList);
      sharedPreferences.setString(SharedPreferencesKey.todoKey, list);
      return Future.value(true);
    } on Exception {
      throw CacheException();
    }
  }
}
