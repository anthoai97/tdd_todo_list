import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/get_todo_list.dart';

part 'todo_event.dart';
part 'todo_state.dart';

const String errorMsg = 'Some unexpected happend';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodoList getTodoList;

  TodoBloc({required this.getTodoList}) : super(TodoLoading()) {
    on<TodoEvent>((event, emit) async {
      if (event is InitialTodo) {
        emit(TodoLoading());
        final result = await getTodoList.call(NoParams());
        result.fold((l) => emit(const TodoError(message: errorMsg)),
            (r) => emit(TodoLoaded(todoList: r)));
      }
    });
  }
}
