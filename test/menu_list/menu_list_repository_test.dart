import 'package:flutter_test/flutter_test.dart';
import 'package:paragone/menu_list/model/menu_item.dart';
import 'package:paragone/menu_list/model/menu_list_repository.dart';

void main() {

  MenuListRepository testSubject;

  setUp(() {
    testSubject = MenuListRepository();
  });

  test('should fetch menu items when fetchMethodItems is called', () async {
    // GIVEN
    var expectedResult = [MenuItem('Pszenica'), MenuItem('Pepperoni')];
    
    // WHEN
    Future<List<MenuItem>> items = testSubject.fetchMenuItems();

    // THEN
    await items.then((menuItems) {
      expect(menuItems.length, expectedResult.length);
      expect(menuItems[0].name, expectedResult[0].name);
      expect(menuItems[1].name, expectedResult[1].name);
    });
  });
}