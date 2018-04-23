import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:paragone/app/state.dart';
import 'package:paragone/menu_list/model/menu_item.dart';
import 'package:paragone/menu_list/menu_list_actions.dart';
import 'package:paragone/views/loading/loading_indicator.dart';
import 'package:redux/redux.dart';

class MenuListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel> (
      converter: (Store<AppState> store) => _ViewModel.create(store),
      onInit: (store) => store.dispatch(FetchMenuAction()),
      builder: ((BuildContext context, _ViewModel viewModel) => Scaffold(
      appBar: AppBar(
        title: Text(viewModel.pageTitle),
      ),
        body: _createWidget(viewModel),
    ))
  );

  Widget _createWidget(_ViewModel viewModel) =>
      viewModel.isLoading ? LoadingIndicator() : _createListView(viewModel);


  ListView _createListView(_ViewModel viewModel) => ListView.builder(
    itemCount: viewModel.items.length,
    itemBuilder: (BuildContext context, int index) =>
        _createListRow(viewModel.items[index]),
  );

  Widget _createListRow(_MenuListItemViewModel item) => Row(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child:  Text(
          item.name,
          style: TextStyle(color:Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      )
    ],
  );
}

class _ViewModel {
  final String pageTitle;
  final List<_MenuListItemViewModel> items;
  final bool isLoading;

  _ViewModel({this.pageTitle, this.items, this.isLoading});

  factory _ViewModel.create(Store<AppState> store) {
    List<_MenuListItemViewModel> items = store.state.menuListState.menuList
        .map((MenuItem item) => _MenuListItemViewModel(item.name))
        .toList();
    return _ViewModel(pageTitle: 'Menu', items: items, isLoading: store.state.menuListState.isLoading);
  }
}

@immutable
class _MenuListItemViewModel {
  final String name;
  const _MenuListItemViewModel(this.name);
}