class AppState {
  final bool isSignedIn;
  final bool appInitialized;

  AppState({
    required this.isSignedIn,
    required this.appInitialized});

  factory AppState.initial() {
    return AppState(
        isSignedIn: false,
        appInitialized: false);
  }
}