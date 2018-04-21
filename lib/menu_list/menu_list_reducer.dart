import 'package:paragone/menu_list/menu_item.dart';
import 'package:paragone/menu_list/menu_list_actions.dart';
import 'package:paragone/menu_list/menu_list_state.dart';

List<MenuItem> addItems(List<MenuItem> items, AddAction action) =>
    List.unmodifiable(List.from(items)..addAll(action.items));

MenuState displayList(MenuState menuState, DisplayListAction action) =>
    MenuState.listWithItems;