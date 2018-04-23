import 'package:paragone/menu_list/menu_list_actions.dart';
import 'package:paragone/menu_list/menu_list_state.dart';
import 'package:redux/redux.dart';

final menuListReducer = combineReducers<MenuListState>([
  TypedReducer<MenuListState, FetchMenuAction>(_isLoading),
  TypedReducer<MenuListState, MenuItemsLoadedAction>(_menuItemsLoaded),
  TypedReducer<MenuListState, MenuItemsNotLoadedAction>(_emptyList),
]);

MenuListState _isLoading(MenuListState state, FetchMenuAction) =>
    MenuListState(isLoading: true);

MenuListState _menuItemsLoaded(MenuListState state, MenuItemsLoadedAction action) =>
    MenuListState(menuList: []..addAll(state.menuList)..addAll(action.items));

MenuListState _emptyList(MenuListState state, MenuItemsNotLoadedAction action) =>
    MenuListState(menuList: []);