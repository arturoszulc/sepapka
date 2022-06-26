

class AppState {
  final bool isSignedIn;
  final bool isSignedOut;
  final bool fetchDataError;

  AppState({
    required this.isSignedIn,
    required this.isSignedOut,
    required this.fetchDataError});

  factory AppState.initial() {
    return AppState(
        isSignedIn: false,
        isSignedOut: false,
        fetchDataError: false);
  }

  AppState copyWith({
    bool? isSignedIn,
    bool? isSignedOut,
    bool? fetchDataError,
  }) {
    return AppState(
      isSignedIn: isSignedIn ?? this.isSignedIn,
      isSignedOut: isSignedOut ?? this.isSignedOut,
        fetchDataError: fetchDataError ?? this.fetchDataError,
    );
  }
}