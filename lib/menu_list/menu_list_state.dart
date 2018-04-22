import 'package:paragone/menu_list/model/menu_item.dart';

class MenuListState {
  final List<MenuItem> menuList;

  MenuListState({this.menuList});

  factory MenuListState.initial() => MenuListState(
    menuList: [],
  );
}
