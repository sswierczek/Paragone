import 'dart:async';
import 'package:paragone/app/state.dart';
import 'package:paragone/menu_list/model/menu_item.dart';
import 'package:paragone/menu_list/menu_list_actions.dart';
import 'package:redux/redux.dart';

class MenuListMiddleware extends MiddlewareClass<AppState> {

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    if(action is FetchMenuAction) {
      _fetchMenuItems().then((menuList) {
        store.dispatch(MenuItemsLoadedAction(menuList));
      });
    }
    next(action);
  }

  Future<List<MenuItem>> _fetchMenuItems() async =>
    Future.delayed(const Duration(seconds: 3), () => [MenuItem('Pszenica'), MenuItem('Pepperoni')]);
}