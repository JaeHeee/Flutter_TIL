import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../repository/todo_repository.dart';

class FlutterBlocScreen extends StatefulWidget {
  @override
  _FlutterBlocScreenState createState() => _FlutterBlocScreenState();
}

class _FlutterBlocScreenState extends State<FlutterBlocScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(repository: TodoRepository()),
      child: TodoListWidget(),
    );
  }
}

class TodoListWidget extends StatefulWidget {
  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  String title = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(ListTodosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter BloC'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TodoBloc>().add(CreateTodoEvent(title: title));
        },
        child: const Icon(
          Icons.edit,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                title = val;
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (_, state) {
                  if (state is Empty) {
                    return Container();
                  } else if (state is Error) {
                    return Container(
                      child: Text(state.message),
                    );
                  } else if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is Loaded) {
                    final items = state.todos;

                    return ListView.separated(
                      itemBuilder: (_, index) {
                        final item = items[index];

                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.title,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<TodoBloc>(context)
                                    .add(DeleteTodoEvent(todo: item));
                              },
                              child: const Icon(
                                Icons.delete,
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (_, index) => const Divider(),
                      itemCount: items.length,
                    );
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
