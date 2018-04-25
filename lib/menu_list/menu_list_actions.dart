import 'package:paragone/menu_list/model/menu_item.dart';

class FetchMenuAction {}

class MenuItemsLoadedAction {
  final List<MenuItem> items;

  const MenuItemsLoadedAction(this.items);
}

class MenuItemsNotLoadedAction {}
