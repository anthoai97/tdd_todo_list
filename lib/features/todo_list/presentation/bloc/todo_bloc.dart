import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:ttd_todo_list/features/todo_list/domain/entities/todo.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/create_todo_list.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/get_todo_list.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/update_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

const String errorMsg = 'Some unexpected happend';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodoList getTodoList;
  final CreateTodo createTodo;
  final UpdateTodo updateTodo;

  TodoBloc(
      {required this.getTodoList,
      required this.createTodo,
      required this.updateTodo})
      : super(TodoLoading()) {
    on<TodoEvent>((event, emit) async {
      if (event is InitialTodo) {
        emit(TodoLoading());
        final result = await getTodoList.call(NoParams());
        result.fold((l) => emit(const TodoError(message: errorMsg)), (r) {
          emit(TodoLoaded(todoList: r));
        });
      }
      if (event is CreateTodoEvent) {
        emit(TodoLoading());
        final result = await createTodo.call(CreateTodoParam(todo: event.todo));
        result.fold((l) => emit(const TodoError(message: errorMsg)), (r) {
          var todoCreated = List<Todo>.from(event.todoList)..add(r);
          emit(TodoLoaded(todoList: todoCreated));
        });
      }
      if (event is UpdateTodoEvent) {
        emit(TodoLoading());
        final result = await updateTodo.call(UpdateTodoParam(todo: event.todo));
        result.fold((l) => emit(const TodoError(message: errorMsg)), (r) {
          var index = event.todoList.indexWhere((e) => e.id == r.id);
          var todoUpdated = List<Todo>.from(event.todoList);
          todoUpdated[index] = r;
          emit(TodoLoaded(todoList: todoUpdated));
        });
      }
    });
  }
}
