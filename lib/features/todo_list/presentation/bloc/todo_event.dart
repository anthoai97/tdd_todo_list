part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class InitialTodo extends TodoEvent {
  final bool? status;

  const InitialTodo({required this.status});
}
