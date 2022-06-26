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

  AppState copyWith({
    bool? isSignedIn,
    bool? appInitialized,
  }) {
    return AppState(
      isSignedIn: isSignedIn ?? this.isSignedIn,
      appInitialized: appInitialized ?? this.appInitialized,
    );
  }
}