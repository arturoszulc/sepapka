class AppState {
  final bool isSignedIn;
  final bool appInitialized;
  final bool fetchDataError;

  AppState({
    required this.isSignedIn,
    required this.appInitialized,
    required this.fetchDataError});

  factory AppState.initial() {
    return AppState(
        isSignedIn: false,
        appInitialized: false,
        fetchDataError: false);
  }

  AppState copyWith({
    bool? isSignedIn,
    bool? appInitialized,
    bool? fetchDataError,
  }) {
    return AppState(
      isSignedIn: isSignedIn ?? this.isSignedIn,
      appInitialized: appInitialized ?? this.appInitialized,
        fetchDataError: fetchDataError ?? this.fetchDataError,
    );
  }
}