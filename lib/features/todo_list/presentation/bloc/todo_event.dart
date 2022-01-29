part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class InitialTodo extends TodoEvent {
  const InitialTodo();
}

class UpdateTodoEvent extends TodoEvent {
  final TodoModel todo;
  final List<Todo> todoList;

  const UpdateTodoEvent({required this.todo, required this.todoList});
}

class CreateTodoEvent extends TodoEvent {
  final TodoModel todo;
  final List<Todo> todoList;

  const CreateTodoEvent({required this.todo, required this.todoList});
}
