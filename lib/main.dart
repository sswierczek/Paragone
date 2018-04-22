import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paragone/app/di/app_injector.dart';
import 'package:paragone/core/repository/repo.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paragone/app/reducer.dart';
import 'package:paragone/app/state.dart';
import 'package:paragone/menu_list/menu_list_page.dart';
import 'package:paragone/menu_list/model/menu_list_middleware.dart';
import 'package:redux/redux.dart';

Future<void> main() async {
  var appInjector = AppInjector().init();
  var repository = await appInjector.getInstance(Repository).configure();

  runApp(new MyApp(repository));
}

class MyApp extends StatelessWidget {
  const MyApp(this.repository);

  final repository;

  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [MenuListMiddleware()],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>
      StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new MenuListPage(),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title, this.repository}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning

  // This class is the configuration for the state. It holds the values (in this

  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  final title;
  final repository;

  @override
  _MyHomePageState createState() => new _MyHomePageState(repository);
}

class _MyHomePageState extends State<MyHomePage> {
  var _counter = 0;

  // FIXME Move to lower layer of future architecture
  final Repository repository;

  _MyHomePageState(this.repository);

  @override
  void initState() {
    super.initState();
    _fetchCounter();
  }

  @override
  void dispose() {
    super.dispose();
    repository.cleanUp();
  }

  Future<Null> _fetchCounter() async {
    _updateCounterState(await repository.getCounter());
  }

  Future<Null> _incrementCounter() async {
    _updateCounterState(await repository.incrementCounter());
  }

  void _updateCounterState(int counter) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter = counter;
    });
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text(widget.title),
        ),
        body: new Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: new Column(
            // Column is also layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug paint" (press "p" in the console where you ran
            // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
            // window in IntelliJ) to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'You have pushed the button this many times:',
              ),
              new Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: new Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
}
