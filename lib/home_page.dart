import 'package:flutter/material.dart';

import 'firebase/firebase_home_page.dart';
import 'widget/til_button.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final List<Widget> list = [
    const TilButton(
        title: '1. Firebase', routeName: FirebaseHomePage.routeName),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter TIL'),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return list[index];
        },
      ),
    );
  }
}
