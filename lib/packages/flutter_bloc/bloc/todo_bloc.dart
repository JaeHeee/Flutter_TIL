import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/todo.dart';
import '../repository/todo_repository.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc({
    required this.repository,
  }) : super(Empty()) {
    on<ListTodosEvent>((event, emit) => _listTodosEvent(event, emit));
    on<CreateTodoEvent>((event, emit) => _createTodoEvent(event, emit));
    on<DeleteTodoEvent>((event, emit) => _deleteTodoEvent(event, emit));
  }

  Future<void> _listTodosEvent(
    ListTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      emit(Loading());
      final resp = await repository.listTodo();

      final todos = resp
          .map<Todo>(
            (e) => Todo.fromJson(e),
          )
          .toList();

      emit(Loaded(todos: todos));
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  Future<void> _createTodoEvent(
    CreateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      if (state is Loaded) {
        final parsedState = (state as Loaded);

        final newTodo = Todo(
          id: parsedState.todos[parsedState.todos.length - 1].id + 1,
          title: event.title,
          createdAt: DateTime.now().toString(),
        );

        final prevTodos = [
          ...parsedState.todos,
        ];

        final newTodos = [
          ...prevTodos,
          newTodo,
        ];

        emit(Loaded(todos: newTodos));

        final resp = await repository.createTodo(newTodo);

        emit(Loaded(
          todos: [
            ...prevTodos,
            Todo.fromJson(resp),
          ],
        ));
      }
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  Future<void> _deleteTodoEvent(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      if (state is Loaded) {
        final newTodos = (state as Loaded)
            .todos
            .where((todo) => todo.id != event.todo.id)
            .toList();

        emit(Loaded(todos: newTodos));

        await repository.deleteTodo(event.todo);
      }
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }
}
