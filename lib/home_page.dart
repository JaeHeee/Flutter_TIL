import 'package:flutter/material.dart';

import 'utils/til_routes.dart';
import 'widget/til_button.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Widget> list = [
    const TilButton(title: '1. Firebase', routeName: TilRouteName.firebaseHome),
    const TilButton(
        title: '2. Dismissible', routeName: TilRouteName.dismissibleWidget),
    const TilButton(
        title: '3. GridView', routeName: TilRouteName.gridViewWidget),
    const TilButton(title: '4. Isolate', routeName: TilRouteName.isolateScreen),
    const TilButton(
        title: '4. Equatable', routeName: TilRouteName.equatableScreen),
    const TilButton(title: '5. Freezed', routeName: TilRouteName.freezedScreen),
    const TilButton(
        title: '6. FlutterBloc', routeName: TilRouteName.flutterBlocScreen),
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
