import 'package:paragone/app/store.dart';
import 'package:paragone/core/repository/repo.dart';
import 'package:redux/redux.dart';

abstract class AppInjector {
  AppInjector init();

  dynamic getInstance(Type type);

  factory AppInjector() => _ManualAppInjector();
}

// Use inject.dart when ready https://github.com/sswierczek/Paragone/issues/19
// Manual Di with singletons only.Cannot use for example dice as dart:mirror library is blocked
class _ManualAppInjector implements AppInjector {
  Map<Type, dynamic> singletons = {};

  @override
  AppInjector init() {
    singletons[Repository] = _createRepository();
    singletons[Store] = _createStore();
    return this;
  }

  @override
  getInstance(Type type) {
    if (singletons.containsKey(type)) {
      return singletons[type];
    } else {
      throw StateError('Class $type is not registered in DI');
    }
  }

  // Use dependencies declared before like Repository(singletons[TYPE], singletons[TYPE2], NotSingleton()) etc.
  // not very sophisticated but this is what we have now
  _createRepository() => Repository();
  _createStore() => createStore();
}
