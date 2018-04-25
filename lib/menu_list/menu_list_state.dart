import 'package:paragone/menu_list/model/menu_item.dart';

class MenuListState {
  final List<MenuItem> menuList;
  final bool isLoading;

  MenuListState({this.menuList = const [], this.isLoading = false});

  factory MenuListState.initial() => MenuListState(menuList: []);
}
