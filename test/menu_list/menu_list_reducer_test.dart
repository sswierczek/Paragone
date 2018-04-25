import 'package:flutter_test/flutter_test.dart';
import 'package:paragone/app/state.dart';
import 'package:paragone/app/reducer.dart';
import 'package:paragone/menu_list/menu_list_actions.dart';
import 'package:paragone/menu_list/model/menu_item.dart';
import 'package:redux/redux.dart';

void main() {

  Store<AppState> store;

  setUp(() {
    store = Store<AppState>(
      appReducer,
      initialState: AppState.initial(),
    );
  });

  group('Menu List State Reducer', () {
    test('should set isLoading as true in response to a FetchMenuAction', () {
      store.dispatch(FetchMenuAction());

      expect(store.state.menuListState.isLoading, true);
    });

    test('should return list of menu items in response to a MenuItemsLoadedAction', () {
      final menuItems = [MenuItem('test')];

      store.dispatch(MenuItemsLoadedAction(menuItems));

      expect(store.state.menuListState.menuList, menuItems);
    });

    test('should return empty list in response to a MenuItemsNotLoadedAction', () {
      store.dispatch(MenuItemsNotLoadedAction());

      expect(store.state.menuListState.menuList, []);
    });
  });
}