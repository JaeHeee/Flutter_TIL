import 'package:equatable/equatable.dart';

import '../model/todo.dart';

abstract class TodoState extends Equatable {}

class Empty extends TodoState {
  @override
  List<Object> get props => [];
}

class Loading extends TodoState {
  @override
  List<Object> get props => [];
}

class Error extends TodoState {
  final String message;

  Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class Loaded extends TodoState {
  final List<Todo> todos;

  Loaded({
    required this.todos,
  });

  @override
  List<Object> get props => [todos];
}
