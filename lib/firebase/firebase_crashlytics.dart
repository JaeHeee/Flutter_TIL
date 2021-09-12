import 'package:flutter/material.dart';

class FirebaseCrashlyticsScreen extends StatelessWidget {
  static const routeName = '/firebase-crashlytics';

  const FirebaseCrashlyticsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Crashlytics'),
      ),
      body: Container(),
    );
  }
}
