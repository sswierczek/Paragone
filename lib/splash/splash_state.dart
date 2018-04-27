class SplashState {
  final bool isLoading;

  SplashState({this.isLoading = false});

  factory SplashState.initial() => SplashState(isLoading: true);
}