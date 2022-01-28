import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String content;
  final bool status;

  const Todo({required this.id, required this.content, required this.status});

  @override
  List get props => [id, content, status];
}
