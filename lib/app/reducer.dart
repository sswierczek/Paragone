import 'package:paragone/menu_list/menu_item.dart';
import 'package:paragone/menu_list/menu_list_actions.dart';
import 'package:paragone/menu_list/menu_list_reducer.dart';
import 'package:paragone/menu_list/menu_list_state.dart';
import 'package:redux/redux.dart';

MenuListState appReducer(MenuListState state, action) =>
    MenuListState(menuItemsListReducer(state.menuList, action), menuListStateReducer(state.state, action));

final Reducer<List<MenuItem>> menuItemsListReducer = combineReducers([
  TypedReducer<List<MenuItem>, AddAction>(addItems),
]);

final Reducer<MenuState> menuListStateReducer = combineReducers<MenuState>([
  TypedReducer<MenuState, DisplayListAction>(displayList),
]);
