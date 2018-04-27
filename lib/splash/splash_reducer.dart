import 'package:paragone/splash/splash_actions.dart';
import 'package:paragone/splash/splash_state.dart';
import 'package:redux/redux.dart';

final SplashStateReducer = combineReducers<SplashState>([
  TypedReducer<SplashState, SplashLoadedAction>(_splashLoaded),
]);

SplashState _splashLoaded(SplashState state, SplashLoadedAction action) =>
    SplashState(isLoading: false);