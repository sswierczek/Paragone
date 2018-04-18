import 'package:paragone/menu_list/menu_item.dart';

class MenuListState {
  final List<MenuItem> menuList;
  final States states;

  const MenuListState(this.menuList, this.states);

  factory MenuListState.initial() => MenuListState(List.unmodifiable([]), States.menuList);
}

enum States {
  menuList
}
