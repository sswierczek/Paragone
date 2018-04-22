import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:paragone/app/state.dart';
import 'package:paragone/menu_list/model/menu_item.dart';
import 'package:redux/redux.dart';

class MenuListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel> (
    converter: (Store<AppState> store) => _ViewModel.create(store),
    builder: ((BuildContext context, _ViewModel viewModel) => Scaffold(
      appBar: AppBar(
        title: Text(viewModel.pageTitle),
      ),
      body:ListView(children: viewModel.items.map(_createListRow).toList()),
    ))
  );

  Widget _createListRow(_MenuListItemViewModel item) => Row(
    children: [
      Text(item.name),
    ],
  );
}

class _ViewModel {
  final String pageTitle;
  final List<_MenuListItemViewModel> items;

  _ViewModel(this.pageTitle, this.items);

  factory _ViewModel.create(Store<AppState> store) {
    List<_MenuListItemViewModel> items = store.state.menuListState.menuList
        .map((MenuItem item) => _MenuListItemViewModel(item.name))
        .toList();
    return _ViewModel("Menu", items);
  }
}

@immutable
class _MenuListItemViewModel {
  final String name;
  const _MenuListItemViewModel(this.name);
}