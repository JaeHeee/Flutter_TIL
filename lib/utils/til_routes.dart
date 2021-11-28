import 'package:flutter/material.dart';

import '../dart/isolate/isolate_screen.dart';
import '../firebase/firebase_crashlytics.dart';
import '../firebase/firebase_home_page.dart';
import '../packages/equatable.dart';
import '../packages/flutter_bloc/screen/flutter_bloc_screen.dart';
import '../packages/freezed/screen/freezed.dart';
import '../widget/dismissible_widget.dart';
import '../widget/girdview_widget.dart';

mixin TilRouteName {
  static const firebaseHome = '/firebase-home';
  static const firebaseCrashlytics = '/firebase-crashlytics';
  static const dismissibleWidget = '/dismissible-widget';
  static const gridViewWidget = '/gridView-widget';
  static const isolateScreen = '/isolate-screen';
  static const equatableScreen = '/equatable-screen';
  static const freezedScreen = '/freezed-screen';
  static const flutterBlocScreen = '/flutter-bloc-screen';
}

mixin TilRoutes {
  static Map<String, WidgetBuilder> routes = {
    TilRouteName.firebaseHome: (ctx) => const FirebaseHomePage(),
    TilRouteName.firebaseCrashlytics: (ctx) =>
        const FirebaseCrashlyticsScreen(),
    TilRouteName.dismissibleWidget: (ctx) => DismissibleWidget(),
    TilRouteName.gridViewWidget: (ctx) => GridViewWidget(),
    TilRouteName.isolateScreen: (ctx) => const IsolateScreen(),
    TilRouteName.equatableScreen: (ctx) => const EquatableScreen(),
    TilRouteName.freezedScreen: (ctx) => const FreezedScreen(),
    TilRouteName.flutterBlocScreen: (ctx) => FlutterBlocScreen(),
  };
}
