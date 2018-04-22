import 'dart:async';
import 'package:paragone/app/state.dart';
import 'package:paragone/menu_list/model/menu_item.dart';
import 'package:paragone/menu_list/menu_list_actions.dart';
import 'package:redux/redux.dart';

class MenuListMiddleware extends MiddlewareClass<AppState> {

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if(action is FetchMenuAction) {
      await _fetchMenuItems();
    }
  }

  Future<List<MenuItem>> _fetchMenuItems() async {
    await Future.sync(() => Duration(seconds: 2));
    return [MenuItem("Pszenica"), MenuItem("Pepperoni")];
  }
}