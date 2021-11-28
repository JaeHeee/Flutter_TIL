import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../utils/til_routes.dart';
import '../widget/til_button.dart';

class FirebaseHomePage extends StatefulWidget {
  const FirebaseHomePage({Key? key}) : super(key: key);

  @override
  _FirebaseHomePageState createState() => _FirebaseHomePageState();
}

class _FirebaseHomePageState extends State<FirebaseHomePage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final List<Widget> list = [
    const TilButton(
        title: '1. Firebase Crashlytics',
        routeName: TilRouteName.firebaseCrashlytics),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Container(
                child: const Text('Error'),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Firebase'),
            ),
            body: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return list[index];
              },
            ),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
