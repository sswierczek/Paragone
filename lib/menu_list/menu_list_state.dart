import 'package:paragone/menu_list/menu_item.dart';

class MenuListState {
  final List<MenuItem> menuList;
  final MenuState state;

  MenuListState(this.menuList, this.state);

  factory MenuListState.initialState() => MenuListState(List.unmodifiable([MenuItem("PSZENICA"), MenuItem("PEPPERONI")]), MenuState.initial);
}

enum MenuState {
  initial, listWithItems
}
