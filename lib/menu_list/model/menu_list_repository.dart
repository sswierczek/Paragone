import 'dart:async';

import 'package:paragone/menu_list/model/menu_item.dart';

class MenuListRepository {
  Future<List<MenuItem>> fetchMenuItems() async =>
      Future.delayed(const Duration(seconds: 3), () => [MenuItem('Pszenica'), MenuItem('Pepperoni')]);
}