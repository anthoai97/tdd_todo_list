import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttd_todo_list/core/constants.dart';
import 'package:ttd_todo_list/features/todo_list/data/models/todo_model.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';

abstract class TodoLocalDataSource {
  Future<List<Todo>> getTodoList();
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
}
