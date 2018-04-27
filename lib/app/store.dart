import 'package:paragone/app/state.dart';
import 'package:paragone/app/reducer.dart';
import 'package:paragone/menu_list/model/menu_list_middleware.dart';
import 'package:paragone/menu_list/model/menu_list_repository.dart';
import 'package:redux/redux.dart';

Store<AppState> createStore(MenuListRepository menuListRepository) =>
    Store<AppState>(
      appReducer,
      initialState: AppState.initial(),
      middleware: [MenuListMiddleware(menuListRepository)],
    );
