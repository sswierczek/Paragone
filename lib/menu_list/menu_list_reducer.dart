import 'package:paragone/menu_list/menu_list_actions.dart';
import 'package:paragone/menu_list/menu_list_state.dart';
import 'package:redux/redux.dart';

final menuListReducer = combineReducers<MenuListState>([
  TypedReducer<MenuListState, FetchMenuAction>(_fetchMenuItems)
]);

MenuListState _fetchMenuItems(MenuListState state, FetchMenuAction action) =>
    MenuListState(menuList: []..addAll(state.menuList)..addAll(action.items));