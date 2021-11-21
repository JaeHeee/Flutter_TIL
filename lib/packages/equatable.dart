import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EquatableScreen extends StatelessWidget {
  static const routeName = '/equatable-screen';
  const EquatableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final person1 = Person(id: 1, name: 'person1', age: 10);
    final person2 = Person(id: 1, name: 'person2', age: 20);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Equatable'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('person1.id == person2.id : ${person1.id == person2.id}'),
            Text(
                'person1.name == person2.name : ${person1.name == person2.name}'),
            Text('person1.age == person2.age : ${person1.age == person2.age}'),
            Text('person1 == person2 : ${person1 == person2}'),
          ],
        ),
      ),
    );
  }
}

class Person extends Equatable {
  final int id;
  final String name;
  final int age;

  Person({
    required this.id,
    required this.name,
    required this.age,
  });

  @override
  List<Object?> get props => [id, name, age];
}
