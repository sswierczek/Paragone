import 'package:meta/meta.dart';
import 'package:paragone/menu_list/menu_list_state.dart';

@immutable
class AppState {
  final MenuListState menuListState;

  const AppState({
    this.menuListState,
  });

  factory AppState.initial() => AppState(
        menuListState: MenuListState.initial(),
      );
}
