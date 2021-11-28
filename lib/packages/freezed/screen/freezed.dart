import 'package:flutter/material.dart';

import '../model/person.dart';

class FreezedScreen extends StatelessWidget {
  const FreezedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final person1 = Person(id: 1, name: 'person1', age: 10);
    final person2 = person1.copyWith(age: 20);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Freezed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('person1: $person1'),
            Text('person2: $person2'),
            Text('person name length: ${person1.nameLength}'),
          ],
        ),
      ),
    );
  }
}
