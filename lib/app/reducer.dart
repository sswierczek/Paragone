import 'package:paragone/app/state.dart';
import 'package:paragone/menu_list/menu_list_reducer.dart';

AppState appReducer(AppState state, action) =>
    AppState(
      menuListState: menuListReducer(state.menuListState, action)
    );