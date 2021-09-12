import 'package:flutter/material.dart';
import 'package:flutter_til/widget/dismissible_widget.dart';

import 'firebase/firebase_crashlytics.dart';
import 'firebase/firebase_home_page.dart';
import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TIL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        FirebaseHomePage.routeName: (ctx) => const FirebaseHomePage(),
        FirebaseCrashlyticsScreen.routeName: (ctx) =>
            const FirebaseCrashlyticsScreen(),
        DismissibleWidget.routeName: (ctx) => DismissibleWidget(),
      },
    );
  }
}
