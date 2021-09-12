import 'package:flutter/material.dart';
import 'package:flutter_til/widget/isolate/isolate_screen.dart';
import 'widget/girdview_widget.dart';

import 'firebase/firebase_home_page.dart';
import 'widget/dismissible_widget.dart';
import 'widget/til_button.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final List<Widget> list = [
    const TilButton(
        title: '1. Firebase', routeName: FirebaseHomePage.routeName),
    const TilButton(
        title: '2. Dismissible', routeName: DismissibleWidget.routeName),
    const TilButton(title: '3. GridView', routeName: GridViewWidget.routeName),
    const TilButton(title: '4. Isolate', routeName: IsolateScreen.routeName),
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
