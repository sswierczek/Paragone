import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:paragone/menu_list/menu_item.dart';
import 'package:paragone/menu_list/menu_list_state.dart';
import 'package:redux/redux.dart';

class MenuListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => StoreConnector<MenuListState, _ViewModel> (
    converter: (Store<MenuListState> store) => _ViewModel.create(store),
    builder: ((BuildContext context, _ViewModel viewModel) => Scaffold(
      appBar: AppBar(
        title: Text(viewModel.pageTitle),
      ),
      body: ListView(children: viewModel.items.map(_createListRow).toList())
    ))
  );

  Widget _createListRow(_MenuListItemViewModel item) => Row(
    children: [
      Text(item.title),
    ],
  );
}

class _ViewModel {
  final String pageTitle;
  final List<_MenuListItemViewModel> items;

  _ViewModel(this.pageTitle, this.items);

  factory _ViewModel.create(Store<MenuListState> store) {
    List<_MenuListItemViewModel> items = store.state.menuList
        .map((MenuItem item) => _MenuListItemViewModel(item.title)).toList();

    return _ViewModel('Menu', items);
  }
}

@immutable
class _MenuListItemViewModel {
  final String title;

  const _MenuListItemViewModel(this.title);
}