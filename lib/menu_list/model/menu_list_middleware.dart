import 'package:paragone/app/state.dart';
import 'package:paragone/menu_list/menu_list_actions.dart';
import 'package:paragone/menu_list/model/menu_list_repository.dart';
import 'package:redux/redux.dart';

class MenuListMiddleware extends MiddlewareClass<AppState> {
  final MenuListRepository repository;

  MenuListMiddleware(this.repository);

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    if(action is FetchMenuAction) {
      repository.fetchMenuItems().then((menuList) {
        store.dispatch(MenuItemsLoadedAction(menuList));
      });
    }
    next(action);
  }
}