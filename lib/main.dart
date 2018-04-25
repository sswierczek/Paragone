import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paragone/app/di/app_injector.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paragone/app/state.dart';
import 'package:paragone/menu_list/menu_list_page.dart';
import 'package:redux/redux.dart';

Future<void> main() async {
  var appInjector = AppInjector().init();
  var store = await appInjector.getInstance(Store);

  runApp(new MyApp(store));
}

class MyApp extends StatelessWidget {
  const MyApp(this.store);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) =>
      StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Paragone',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new MenuListPage(),
        ),
      );
}