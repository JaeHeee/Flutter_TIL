import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                FirebaseCrashlytics.instance
                    .setCustomKey('setCustomKeyTest', 'customValue');
              },
              child: const Text('Key'),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseCrashlytics.instance.log('log Test');
              },
              child: const Text('Log'),
            ),
            ElevatedButton(
              onPressed: () async {
                FirebaseCrashlytics.instance.crash();
              },
              child: const Text('Crash'),
            ),
            ElevatedButton(
              onPressed: () {
                throw StateError('Uncaught error thrown by app');
              },
              child: const Text('Throw Error'),
            ),
            ElevatedButton(
              onPressed: () {
                runZonedGuarded(() {
                  Future<void>.delayed(const Duration(seconds: 2), () {
                    final list = <int>[];
                    print(list[0]);
                  });
                }, FirebaseCrashlytics.instance.recordError);
              },
              child: const Text('runZonedGuarded'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  throw Error();
                } catch (exception, stack) {
                  await FirebaseCrashlytics.instance.recordError(
                    exception,
                    stack,
                    reason: 'Test fatal error',
                    fatal: true,
                  );
                }
              },
              child: const Text('Record Fatal Error'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  throw Error();
                } catch (exception, stack) {
                  await FirebaseCrashlytics.instance.recordError(
                    exception,
                    stack,
                    reason: 'as an example of non-fatal error',
                  );
                }
              },
              child: const Text('Record Non-Fatal Error'),
            ),
          ],
        ),
      ),
    );
  }
}
